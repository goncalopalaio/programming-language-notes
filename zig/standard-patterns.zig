const std = @import("std");
const debug = std.debug.print;

pub fn main() !void {
    // Allocators

    try page_allocator();
    try fixed_buffer_allocator();
    try arena_allocator();
    try alloc_free_create_destroy();
    try general_purpose_allocator();
    // There's also a special std.testing.allocator for tests.

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = &gpa.allocator;
    defer {
        const leaked = gpa.deinit();
        std.debug.assert(!leaked);
    }

    try file_system();
    try arraylist(allocator);
    try readers_and_writers(allocator);
    // try reading_user_input(allocator);
    try implementing_a_writer(allocator);
    try string_formatting(allocator);
    try formatting_specifiers();
    try custom_formatting(allocator);
    try parsing_json(allocator);
    try random_numbers();
    try threads();
    try hashmaps(allocator);
    try stacks(allocator);
    try sorting();
    try iterators(allocator);
}

fn formatting_specifiers() !void {
    debug("running formatting_specifiers\n", .{});

    var b: [8]u8 = undefined;

    // Formats a byte into an ascii character:
    _ = try std.fmt.bufPrint(&b, "{c} {c} {c} {c} ", .{65, 66, 67, 68});
    debug("\tformatted: {s}\n", .{b});

    // Previously {B} and {Bi} existed to output memory sizes in metric (1000) and power-of-two (1024) based notation.
    // but are now deprecated, so we're using fmtIntSizeDec.
    debug("\tformatted: {s}\n", .{std.fmt.fmtIntSizeDec(1024)});

    // {b} and {o} to output integers in binary and octal format.
    _ = try std.fmt.bufPrint(&b, "{b}", .{254});
    debug("\tformatted: {s}\n", .{b});

    // {*} performs pointer formatting, printing the address rather than the value.
    var b2: [16]u8 = undefined;
    const result = try std.fmt.bufPrint(&b2, "{*}", .{@intToPtr(*u8, 0xDEADBEEF)});
    debug("\tformatted: buf: {s} result: {s} {s} -- {*} {*}\n", .{b2, result, @TypeOf(result), &b2, &result});

    // {e} for scientific notation
    // {s} for strings.

    // Advanced formatting:
    // {[position][specifier]:[fill][alignment][width].[precision]}

    // Position:
    debug("\tadvanced formatting - position: {1s} {0s} {0s} {0s}\n", .{"a", "b"});

    debug("\tadvanced formatting - fill, aligned left  : |{s: <5}|\n", .{"hi!"});
    debug("\tadvanced formatting - fill, aligned right : |{s: >5}|\n", .{"hi!"});
    debug("\tadvanced formatting - fill, aligned center: |{s:_^5}|\n", .{"hi!"});

    debug("\tadvanced formatting - precision: |{d:.2}|\n", .{3.14159});

}

const ContainsIterator = struct {
    strings: []const []const u8,
    needle: []const u8,
    index: usize = 0,

    fn next(self: *ContainsIterator) ?[]const u8 {
        const index = self.index;

        for (self.strings[index..]) |string| {
            self.index += 1;

            // std.mem.indexOf returns ?usize
            if (std.mem.indexOf(u8, string, self.needle)) |_| {
                return string;
            }
        }

        return null;
    }
};

fn iterators(allocator: *std.mem.Allocator) !void {
    debug("running iterators\n", .{});

    // It's a common idiom to have a struct type with a next function with an optional in its return type so that the function
    // may return a null to indicate that the iteration is finished.

    const text = "robust, optimal, reusable, maintainable, ";

    var iter = std.mem.split(text, ", ");

    std.debug.assert(std.mem.eql(u8, iter.next().?, "robust"));
    std.debug.assert(std.mem.eql(u8, iter.next().?, "optimal"));
    std.debug.assert(std.mem.eql(u8, iter.next().?, "reusable"));
    std.debug.assert(std.mem.eql(u8, iter.next().?, "maintainable"));
    std.debug.assert(std.mem.eql(u8, iter.next().?, ""));
    std.debug.assert(iter.next() == null);

    // Some iterators have a !?T return type as opposed to ?T. It requires that the error is unpacked before the optional
    // meaning that the work done to get the next iteration may error.

    var fiter = (try std.fs.cwd().openDir(".", .{ .iterate = true })).iterate();

    var file_count: usize = 0;
    while (try fiter.next()) |entry| {
        if (entry.kind == .File) file_count += 1;
    }

    std.debug.assert(file_count > 0);

    // ?!T return types are also found, meaning the optional is unpacked before the error union.
    // This conveys that getting to the next iteration is not the part that can fail,
    // but rather getting the value of the next iteration may fail

    var arg_chars: usize = 0;
    var piter = std.process.args();

    while (piter.next(allocator)) |arg| {
        const argument = arg catch break;
        arg_chars += argument.len;
        debug("\targument: {s}\n", .{argument});
        allocator.free(argument);
    }

    std.debug.assert(arg_chars > 0);

    // Implementing a custom iterator.
    // This particular implementation will iterate over a slice of strings, yielding the strings which contain a given string.

    var string_arr = [_][]const u8{ "one", "two", "three" };

    var citer = ContainsIterator{
        .strings = &string_arr,
        .needle = "e",
    };

    while (citer.next()) |elem| {
        debug("\telem: {s}\n", .{elem});
    }
}

fn debug_array(arr: anytype) void {
    for (arr) |a| {
        debug("\t{}", .{a});
    }
    debug("\n", .{});
}

fn sorting() !void {
    debug("running sorting\n", .{});

    var data = [_]u8{ 10, 240, 0, 0, 10, 5 };
    debug_array(data);

    std.sort.sort(u8, &data, {}, comptime std.sort.asc(u8));
    debug_array(data);

    std.sort.sort(u8, &data, {}, comptime std.sort.desc(u8));
    debug_array(data);
}

fn stacks(allocator: *std.mem.Allocator) !void {
    debug("running stacks\n", .{});

    const parens = "(()())";

    var stack = std.ArrayList(usize).init(allocator);
    defer stack.deinit();

    const Pair = struct { open: usize, close: usize };
    var pairs = std.ArrayList(Pair).init(allocator);
    defer pairs.deinit();

    for (parens) |char, i| {
        if (char == '(') try stack.append(i);
        if (char == ')') try pairs.append(.{ .open = stack.pop(), .close = i });
    }

    for (pairs.items) |pair, idx| {
        var expected_pair = switch (idx) {
            0 => Pair{ .open = 1, .close = 2 },
            1 => Pair{ .open = 3, .close = 4 },
            2 => Pair{ .open = 0, .close = 5 },
            else => unreachable,
        };

        // Using std.meta.eql to compare all fields in the struct.
        std.debug.assert(std.meta.eql(pair, expected_pair));
    }
}

fn hashmaps(allocator: *std.mem.Allocator) !void {
    debug("running hashmaps\n", .{});

    const Point = struct { x: i32, y: i32 };

    var map = std.AutoHashMap(u32, Point).init(allocator);
    defer map.deinit();

    try map.put(1234, .{ .x = 1, .y = 4 });
    try map.put(9921, .{ .x = 1, .y = 4 });

    std.debug.assert(map.count() == 2);

    var sum = Point{ .x = 0, .y = 0 };
    var iterator = map.iterator();

    while (iterator.next()) |entry| {
        sum.x += entry.value.x;
        sum.y += entry.value.y;
    }

    debug("\tsum: {} {}\n", .{ sum.x, sum.y });

    // fetchPut() puts a value in the hashmap returning a value if there was a previous value for the key.
    var imap = std.AutoHashMap(u8, f32).init(allocator);
    defer imap.deinit();

    try imap.put(255, 10);
    const old = try imap.fetchPut(255, 100);

    std.debug.assert(old.?.value == 10);
    std.debug.assert(imap.get(255).? == 100);

    // Use std.StringHashMap when you need strings as keys.

    var smap = std.StringHashMap(enum { cool, uncool }).init(allocator);
    defer smap.deinit();

    try smap.put("loris", .uncool);
    try smap.put("me", .cool);
    std.debug.assert(smap.get("me").? == .cool);
    std.debug.assert(smap.get("loris").? == .uncool);

    // StringHashMap and AutoHashMap are wrappers over std.HashMap, use it for more control.
    // To have your elements backed by an array use std.ArrayHashMap and its wrapper std.AutoArrayHashMap.

    var amap = std.AutoArrayHashMap(u8, u8).init(allocator);
    defer amap.deinit();

    try amap.put(123, 211);
}
fn threads() !void {
    debug("running threads\n", .{});

    var thread = try std.Thread.spawn(ticker, @as(u8, 1));

    debug("\twaiting for thread\n", .{});
    thread.wait();
    debug("\tthread finished\n", .{});
}

var tick: isize = 0;

fn ticker(step: u8) void {
    while (tick <= 4) {
        debug("\ttick\n", .{});
        std.time.sleep(std.time.ns_per_s / 32);
        tick += @as(isize, step);
        debug("\ttock\n", .{});
    }
}

fn random_numbers() !void {
    debug("running random_numbers\n", .{});

    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });

    const rand = &prng.random;

    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);

    debug("\trandom -> prng:   {} {} {} {}\n", .{ a, b, c, d });

    // Crypto random numbers

    const crand = std.crypto.random;
    const ca = crand.float(f32);
    const cb = crand.boolean();
    const cc = crand.int(u8);
    const cd = crand.intRangeAtMost(u8, 0, 255);

    debug("\trandom -> crypto: {} {} {} {}\n", .{ ca, cb, cc, cd });
}

const Place = struct { lat: f32, lon: f32 };

fn parsing_json(allocator: *std.mem.Allocator) !void {
    debug("running parsing_json\n", .{});

    var stream = std.json.TokenStream.init(
        \\ { "lat": 40.99, "lon": -74.44 }
    );

    const x = try std.json.parse(Place, &stream, .{});

    debug("\t{} {}\n", .{ x.lat, x.lon });

    // Using stringify to turn data into a string:

    const y = Place{ .lat = 51.99, .lon = -0.9 };

    var string = std.ArrayList(u8).init(allocator);
    defer string.deinit();
    try std.json.stringify(y, .{}, string.writer());

    debug("\tstringify: {s}\n", .{string.items});

    var another_stream = std.json.TokenStream.init(
        \\ { "name": "Joe", "age": 25 }
    );

    const User = struct { name: []u8, age: u16 };

    const z = try std.json.parse(User, &another_stream, .{ .allocator = allocator });
    defer std.json.parseFree(User, z, .{ .allocator = allocator });

    debug("\tparsing strings: {s} {}\n", .{ z.name, z.age });
}

fn string_formatting(allocator: *std.mem.Allocator) !void {
    debug("running string_formatting\n", .{});

    // d   - decimal number
    // s   - string
    // any - default formatting

    const string = try std.fmt.allocPrint(allocator, "{d} + {d} = {d}", .{ 9, 10, 19 });
    defer allocator.free(string);

    std.debug.assert(std.mem.eql(u8, string, "9 + 10 = 19"));

    // Writers also have a print method that allows formatting:

    var list = std.ArrayList(u8).init(allocator);
    defer list.deinit();

    try list.writer().print("{} + {} = {}", .{ 9, 10, 19 });

    std.debug.assert(std.mem.eql(u8, list.items, "9 + 10 = 19"));

    const out = std.io.getStdOut();
    try out.writer().print("\tHello {s}!\n", .{"World"});

    const using_any = try std.fmt.allocPrint(allocator, "{any} + {any} = {any}", .{
        @as([]const u8, &[_]u8{ 1, 4 }),
        @as([]const u8, &[_]u8{ 2, 5 }),
        @as([]const u8, &[_]u8{ 3, 9 }),
    });
    defer allocator.free(using_any);

    std.debug.assert(std.mem.eql(u8, using_any, "{ 1, 4 } + { 2, 5 } = { 3, 9 }"));
}

// Custom formatting by implementing a format function.
const Person = struct {
    name: []const u8,
    birth_year: i32,

    pub fn format(self: Person, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        try writer.print("{s} ({})", .{ self.name, self.birth_year });
    }
};

fn custom_formatting(allocator: *std.mem.Allocator) !void {
    debug("running custom_formatting\n", .{});
    // To implement formatting, implement a format function for the struct.

    const freya = Person{ .name = "Freya", .birth_year = 1970 };

    debug("\t{s}\n", .{freya});
}

const MyByteList = struct {
    data: [100]u8 = undefined,
    items: []u8 = &[_]u8{},

    const Writer = std.io.Writer(*MyByteList, error{EndOfBuffer}, appendWrite);

    fn appendWrite(self: *MyByteList, data: []const u8) error{EndOfBuffer}!usize {
        if (self.items.len + data.len > self.data.len) return error.EndOfBuffer;

        std.mem.copy(u8, self.data[self.items.len..], data);

        self.items = self.data[0 .. self.items.len + data.len];

        return data.len;
    }

    fn writer(self: *MyByteList) Writer {
        return .{ .context = self };
    }
};

fn implementing_a_writer(allocator: *std.mem.Allocator) !void {
    debug("running implementing_a_writer\n", .{});

    // You should use an arraylist with a fixed buffer allocator for this but as an example:

    debug("\t using a custom writer\n", .{});
    var bytes = MyByteList{};
    _ = try bytes.writer().write("Hello");
    _ = try bytes.writer().write(" Writer!");
    std.debug.assert(std.mem.eql(u8, bytes.items, "Hello Writer!"));
}

fn readers_and_writers(allocator: *std.mem.Allocator) !void {
    // std.io.Writer and std.io.Reader provide standard ways of making use of IO.
    // std.ArrayList(u8) has a writer method which give us a writer. Using it as an example:
    debug("running readers_and_writers\n", .{});

    var another_list = std.ArrayList(u8).init(allocator);
    defer another_list.deinit();

    const another_bytes_written = try another_list.writer().write(
        "Hello World!",
    );

    std.debug.assert(another_bytes_written == 12);
    std.debug.assert(std.mem.eql(u8, another_list.items, "Hello World!"));

    // IO reader example:

    const message = "Hello File!";

    const file = try std.fs.cwd().createFile("test-files/junk-file.txt", .{ .read = true });
    defer file.close();

    try file.writeAll(message);
    try file.seekTo(0);

    const allowed_to_allocate_max = message.len;
    const contents = try file.reader().readAllAlloc(allocator, allowed_to_allocate_max);
    // If the file is larger than the max it will return error.StreamTooLong.
    defer allocator.free(contents);

    std.debug.assert(std.mem.eql(u8, contents, message));
}

fn reading_user_input(allocator: *std.mem.Allocator) !void {
    debug("running reading_user_input\n", .{});

    const stdout = std.io.getStdOut();
    const stdin = std.io.getStdIn();

    try stdout.writeAll(
        \\ Enter your name:
    );

    var buffer: [100]u8 = undefined;
    const input = (try nextLine(stdin.reader(), &buffer)).?;
    try stdout.writer().print("Your name is: \"{s}\"\n", .{input});
}

fn nextLine(reader: anytype, buffer: []u8) !?[]const u8 {
    var line = (try reader.readUntilDelimiterOrEof(buffer, '\n')) orelse return null;

    // Trimming windows-only carriage return character:
    if (std.builtin.Target.current.os.tag == .windows) {
        line = std.mem.trimRight(u8, line, "\r");
    }

    return line;
}

fn arraylist(allocator: *std.mem.Allocator) !void {
    debug("running arraylist\n", .{});

    var list = std.ArrayList(u8).init(allocator);
    defer list.deinit();

    try list.append('H');
    try list.append('e');
    try list.append('l');
    try list.append('l');
    try list.append('o');
    try list.appendSlice(" World!");

    std.debug.assert(std.mem.eql(u8, list.items, "Hello World!"));
}

fn file_system() !void {
    debug("running file_system\n", .{});

    const file = try std.fs.cwd().createFile("test-files/test.txt", .{ .read = true });
    defer file.close();
    // std.fs.openFileAbsolute also exists.

    const bytes_written = try file.writeAll("Hello!!!!");

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);

    std.debug.assert(std.mem.eql(u8, buffer[0..bytes_read], "Hello!!!!"));

    // You can use stat() to get file information:
    const stat = try file.stat();
    debug("\tstat: {} {} {} {} {}\n", .{ stat.size, stat.kind, stat.ctime, stat.mtime, stat.atime });

    std.debug.assert(stat.kind == .File);
    std.debug.assert(stat.ctime <= std.time.nanoTimestamp());

    // Making directories and iterating over their contents:
    try std.fs.cwd().makeDir("test-tmp");
    const dir = try std.fs.cwd().openDir("test-tmp", .{ .iterate = true });
    defer {
        std.fs.cwd().deleteTree("test-tmp") catch unreachable;
    }

    _ = try dir.createFile("x", .{});
    _ = try dir.createFile("y", .{});
    _ = try dir.createFile("z", .{});

    // Using iterators here. Explained later.
    var file_count: usize = 0;
    var iter = dir.iterate();
    while (try iter.next()) |entry| {
        if (entry.kind == .File) file_count += 1;
    }

    std.debug.assert(file_count == 3);
}
fn page_allocator() !void {
    debug("running page_allocator\n", .{});

    // Asks the OS for entire pages of memory; an allocation of a single byte will likely reserve multiple kibibytes.
    // As asking the OS for memory requires a system call this is also extremely inefficient for speed.
    const allocator = std.heap.page_allocator;

    const memory = try allocator.alloc(u8, 100);
    defer allocator.free(memory);

    debug("\tExpected to have a []u8 with 100 elements: {} {}\n", .{ @TypeOf(memory), memory.len });
}

fn general_purpose_allocator() !void {
    debug("running general_purpose_allocator\n", .{});

    // The standard library includes a general purpose allocator.
    // This is a safe allocator which can prevent double-free, use-after-free and can detect leaks.
    // The security features can be turned off by the configuration struct (left empty below).
    // It's designed for safety over performance but may still be many times faster than page_allocator.
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const leaked = gpa.deinit();
        std.debug.assert(!leaked);
    }

    const bytes = try gpa.allocator.alloc(u8, 100);
    defer gpa.allocator.free(bytes);

    // For high performance but very few safety features std.heap.c_allocator can be also considered but you need to link with libc (with -lc)
}

fn fixed_buffer_allocator() !void {
    debug("running fixed_buffer_allocator\n", .{});

    // Allocators memory into a fixed buffer and does not make any heap allocations.
    // Useful for when heap usage is not wanted - for example when writing a kernel or for performance considerations reasons.
    // It will give OutOfMemory if it has run of bytes.
    var buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    var allocator = &fba.allocator;

    const memory = try allocator.alloc(u8, 100);
    defer allocator.free(memory);

    debug("\tExpected to have a []u8 with 100 elements: {} {}\n", .{ @TypeOf(memory), memory.len });
}

fn arena_allocator() !void {
    debug("running arena_allocator\n", .{});

    // Takes a child allocator and allows you to allocate many times and only free once (deinit()).
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = &arena.allocator;

    const m1 = try allocator.alloc(u8, 1);
    const m2 = try allocator.alloc(u8, 10);
    const m3 = try allocator.alloc(u8, 100);
}

fn alloc_free_create_destroy() !void {
    debug("running alloc_free_create_destroy\n", .{});

    // alloc and free are used for slices. For single items use create and destroy.
    const byte = try std.heap.page_allocator.create(u8);
    defer std.heap.page_allocator.destroy(byte);
    byte.* = 128;
}
