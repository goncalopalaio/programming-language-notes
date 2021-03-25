// File
const b = @import("thing.zig");
// Package
const a = @import("otherthing");
pub fn main() anyerror!void {
    b.banana();
    a.apple();
}
