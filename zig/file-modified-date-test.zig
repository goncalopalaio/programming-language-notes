const std = @import("std");

fn ticker(id: u8) !void {
    std.log.info("ticker start", .{});
    defer std.log.info("ticker end", .{});

    
    
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = &gpa.allocator;
    defer {
        const leaked = gpa.deinit();
        std.debug.assert(!leaked);
    }

    // There are actual system callback that tell us when this happens but this will work for simple examples.

    const t = try std.Thread.spawn(ticker, @as(u8, 1));
    t.wait();
}
