const b = @import("thing.zig");
const a = @import("otherthing");
pub fn main() anyerror!void {
    b.banana();
    a.apple();
}
