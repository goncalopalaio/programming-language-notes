const std = @import("std");

const RED = "\x1b[31;1m";
const GREEN = "\x1b[32;1m";
const CYAN = "\x1b[36;1m";
const WHITE = "\x1b[37;1m";
const DIM = "\x1b[2m";
const RESET = "\x1b[0m";
// ED -- Clear screen
const ED = "\x1b[J"; // Clears from cursor to the end of the screen. "\x1b[J" or "\x1b[0J"

const CLEAR_EVERYTHING_INCLUDING_SCROLLBACK = "\x1b[3J"; // Should not be repeated in loop (heavy)
const CLEAR_FROM_BEGINNING_SCREEN = "\x1b[1J";

const SET_CURSOR_POSITION_TOP = "\x1b[1;1H";
// DECSC -- Save cursor position
const DECSC = "\x1b7";
// DECRC -- Restore cursor position
const DECRC = "\x1b8";
// Note that ESC7/ESC8 are used instead of CSI s/CSI u as the latter are not
// supported by some terminals (eg. Terminal.app).

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = &gpa.allocator;
    defer {
        const leaked = gpa.deinit();
        std.debug.assert(!leaked);
    }

    const stdout = std.io.getStdOut();

    var idx: usize = 0;
    while (true) : (idx += 1) {
        if (idx % 2 == 0) {
            try stdout.writeAll(CYAN);
        } else {
            try stdout.writeAll(GREEN);
        }

        if (idx % 40 == 0) {
            try stdout.writeAll(CLEAR_FROM_BEGINNING_SCREEN);
            try stdout.writeAll(SET_CURSOR_POSITION_TOP);
        }

        try stdout.writer().print("|{}|\n", .{idx});
    }
}
