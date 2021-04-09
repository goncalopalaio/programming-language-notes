const std = @import("std");

const Example = struct {
    filter: []const u8,
};

const OtherExample = struct {
    filter: []const u8,
};

const Filter = struct {
    filter_pid: []u8,
    filter_level: []u8,
    filter_tag: []u8,
    ignore_tag: []u8,
    filter_msg: []u8,
    ignore_msg: []u8,
    highlight_a: []u8,
    highlight_b: []u8,
    highlight_c: []u8,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = &gpa.allocator;
    defer {
        const leaked = gpa.deinit();
        std.debug.assert(!leaked);
    }

    {
        const e = Example{
            .filter = "HI",
        };

        const file = try std.fs.cwd().createFile("test-files/e.json", .{});
        defer file.close();
        try std.json.stringify(e, .{}, file.writer());
    }

    {
        const text = try std.fmt.allocPrint(allocator, "{d} + {d} = {d}", .{ 9, 10, 19 });
        defer allocator.free(text);

        const oe = OtherExample{
            .filter = text,
        };

        const file = try std.fs.cwd().createFile("test-files/oe.json", .{});
        defer file.close();
        try std.json.stringify(oe, std.json.StringifyOptions{ .whitespace = std.json.StringifyOptions.Whitespace{} }, file.writer());
    }

    {
        const text = try std.fmt.allocPrint(allocator, "Another example {}{}{}", .{ 9, 10, 19 });
        defer allocator.free(text);

        const oe = Filter{
            .filter_pid = text,
            .filter_level = text,
            .filter_tag = text,
            .ignore_tag = text,
            .filter_msg = text,
            .ignore_msg = text,
            .highlight_a = text,
            .highlight_b = text,
            .highlight_c = text,
        };

        const file = try std.fs.cwd().createFile("test-files/f.json", .{});
        defer file.close();
        try std.json.stringify(oe, std.json.StringifyOptions{ .whitespace = std.json.StringifyOptions.Whitespace{} }, file.writer());
    }

    {
        const file = try std.fs.cwd().openFile("test-files/f.json", .{});

        const allowed_to_allocate_max = 500;
        const contents = try file.reader().readAllAlloc(allocator, allowed_to_allocate_max);
        defer allocator.free(contents);

        std.log.info("File: {s}", .{contents});
        

        const parse_options = std.json.ParseOptions{ .allocator = allocator };
        const reconstructed = try std.json.parse(Filter, &std.json.TokenStream.init(contents), parse_options);
        defer std.json.parseFree(Filter, reconstructed, parse_options);

        std.log.info("Reconstructed filter_pid: {s}", .{reconstructed.filter_pid});
    }
}
