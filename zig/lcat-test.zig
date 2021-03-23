const std = @import("std");

const p = std.debug.print;

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
var allocator = &gpa.allocator;
var data: std.StringHashMap(*std.ArrayList([]u8)) = undefined;

const RED = "\x1b[31;1m";
const GREEN = "\x1b[32;1m";
const CYAN = "\x1b[36;1m";
const WHITE = "\x1b[37;1m";
const DIM = "\x1b[2m";
const RESET = "\x1b[0m";

const CLEAR_FROM_BEGINNING_SCREEN = "\x1b[1J";
const SET_CURSOR_POSITION_TOP = "\x1b[1;1H";

fn reader(context: void) !void {
    const args = &[_][]const u8{
        "seq", "99999",
        // "adb", "logcat", "-v", "time"
    };

    const r = try std.ChildProcess.init(args, allocator);
    r.stdout_behavior = std.ChildProcess.StdIo.Pipe;
    defer r.deinit();

    _ = try r.spawn();

    var out = r.stdout orelse return error.FailedToAcquireStdout;

    const stdout = std.io.getStdOut();

    var buffer: [10000]u8 = undefined;
    var idx: usize = 0;
    while (true) : (idx += 1) {
        const read = try out.reader().readUntilDelimiterOrEof(&buffer, '\n');

        const content = read orelse break;

        const memory = try allocator.alloc(u8, content.len);
        std.mem.copy(u8, memory, content);

        if (data.get("1")) |device| {
            if (idx % 2 == 0) {
                try stdout.writeAll(CYAN);
            } else {
                try stdout.writeAll(GREEN);
            }

            try stdout.writer().print("append: |{s}| -> device has: {} lines\n", .{ memory, device.items.len });

            try device.append(memory);

            var max: usize = 10;
            if (device.items.len > max) {
                // try stdout.writeAll(SET_CURSOR_POSITION_TOP); // FIXME: can be done in one call const c = a ** b
                // try stdout.writeAll(CLEAR_FROM_BEGINNING_SCREEN);

                // device.shrinkAndFree(max); // NOTE: This is cutting the end and we probably want to cut the beginning, also leaks buffer memory
                // while(idx < device.items.len) : (idx+=1) {
                //    // p("removing: {}\n", .{idx});
                //    var gone = device.pop();
                //    allocator.free(gone);
                // }
            }
        }
    }

    p("exiting reader\n", .{});
}

pub fn main() !void {
    data = std.StringHashMap(*std.ArrayList([]u8)).init(allocator);
    var device_data = std.ArrayList([]u8).init(allocator);

    defer {
        const leaked = gpa.deinit();
        std.debug.assert(!leaked);
    }

    defer device_data.deinit();
    defer data.deinit();

    // defer device_data.deinit();
    try data.put("1", &device_data);

    const reader_thread = try std.Thread.spawn(reader, {});

    reader_thread.wait();

    var iterator = data.iterator();
    while (iterator.next()) |v| {
        for (v.value.items) |line| {
            // p(":: {s}\n", .{line});
            allocator.free(line);
        }
    }

    p("exiting main\n", .{});
}
