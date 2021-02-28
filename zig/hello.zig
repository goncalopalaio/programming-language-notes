//! This is a top level doc
//! This is the way to document something in general, that is it's not related
//! to what's below.
//! How to run this:
//! zig run hello.zig
//! Build the executable with:
//! zig build-exe hello.zig
//! Run the tests with:
//! zig test hello.zig

// Top-level declarations are order-independent. Notice the std declaration after it's used.
const log = std.debug.print;
const std = @import("std");
const expect = std.testing.expect;
const assert = std.debug.assert;
const os = std.os;

/// Stores a timestamp
/// This is a multiline doc comment.
const Timestamp = struct {
    /// Number of seconds since the epoch.
    seconds: i64,
    /// The number of nanoseconds since the epoch.
    nanos: u32,

    /// Returns a `Timestamp` struct representing Unix time.
    /// Also writing backticks with the PT layout kinda sucks.
    pub fn unixEpoch() Timestamp {
        return Timestamp{
            .seconds = 0,
            .nanos = 0,
        };
    }
};

pub fn main() !void {
    // <error type>!<return primitive type>
    const out = std.io.getStdOut().writer();
    // try will return if an error occurs.
    try out.print("Hi, {s}!\n", .{"World"});

    // writing to stout will probably not fail but
    // another type of writer() might (for ex. writing to a file).
    // to log stuff use:
    std.debug.print("Hello?\n", .{});
    // or (look at the top of the file for how this shorthand works)
    log("Hello again\n", .{});

    // Comments
    // Hello, this is a comment.
    // Use 3 slashes for Doc comments

    // A few primitive types

    // Integers
    const one_plus_one: i32 = 1 + 1;
    const one_plus_two = 1 + 2;
    log("Some integers {} {}\n", .{ one_plus_one, one_plus_two });

    // Floats
    const seven_div_three: f32 = 7.0 / 3.0;
    const seven_div_two = 7.0 / 2.0;
    log("Floating {} {}\n", .{ seven_div_three, seven_div_two });

    // Booleans
    log("{}\n{}\n{}\n", .{
        true and false,
        true or false,
        !true,
    });

    // Optionals
    var optional_number: ?u8 = null;
    log("Hey? {}\n", .{optional_number});
    optional_number = 255;
    log("Hey: {}\n", .{optional_number});

    var optional_value: ?[]const u8 = null;
    assert(optional_value == null);
    // log("optional: type: {s} -> {s}\n", .{ @typeName(@TypeOf(optional_value)), optional_value });
    log("\noptional 1\ntype: {s}\nvalue: {s}\n", .{
        @typeName(@TypeOf(optional_value)),
        optional_value,
    });

    // Using const here: ?[]const
    // will infer the size of the array at compile time.
    optional_value = "Hi";
    assert(optional_value != null);
    log("\noptional 2\ntype: {s}\nvalue: {s}\n", .{
        @typeName(@TypeOf(optional_value)),
        optional_value,
    });

    optional_value = "Hello";
    assert(optional_value != null);

    // Error union
    var number_or_error: anyerror!i32 = error.ArgNotFound;
    log("Error union 1\ntype: {s}\nvalue: {}\n", .{
        @typeName(@TypeOf(number_or_error)),
        number_or_error,
    });

    number_or_error = 1234;
    log("Error union 2\ntype: {s}\nvalue: {}\n", .{
        @typeName(@TypeOf(number_or_error)),
        number_or_error,
    });

    // Basic primite type list
    // i8	int8_t	signed 8-bit integer
    // u8	uint8_t	unsigned 8-bit integer
    // i16	int16_t	signed 16-bit integer
    // u16	uint16_t	unsigned 16-bit integer
    // i32	int32_t	signed 32-bit integer
    // u32	uint32_t	unsigned 32-bit integer
    // i64	int64_t	signed 64-bit integer
    // u64	uint64_t	unsigned 64-bit integer
    // i128	__int128	signed 128-bit integer
    // u128	unsigned __int128	unsigned 128-bit integer
    // isize	intptr_t	signed pointer sized integer
    // usize	uintptr_t	unsigned pointer sized integer

    // f16	_Float16	16-bit floating point (10-bit mantissa) IEEE-754-2008 binary16
    // f32	float	32-bit floating point (23-bit mantissa) IEEE-754-2008 binary32
    // f64	double	64-bit floating point (52-bit mantissa) IEEE-754-2008 binary64
    // f128	_Float128	128-bit floating point (112-bit mantissa) IEEE-754-2008 binary128

    // bool	bool	true or false
    // void	(none)	0 bit type
    // noreturn	(none)	the type of break, continue, return, unreachable, and while (true) {}
    // type	(none)	the type of types
    // anyerror	(none)	an error code
    // comptime_int	(none)	Only allowed for comptime-known values. The type of integer literals.
    // comptime_float	(none)	Only allowed for comptime-known values. The type of float literals.

    // There are others that are specifically for for ABI compatibility with C

    // In addition to the regular integer types you can have arbitraty bit-width integers.
    // for example:
    var a_7_bit_integer: i7 = 1234;

    // Primitive values
    // true and false
    // null - set an optional type to null
    // undefined - leave value unspecified.

    // TODO: https://ziglang.org/documentation/master/#toc-String-Literals-and-Unicode-Code-Point-Literals
}

test "comments" {
    const x = true; // This is a comment!
    expect(x);

    // Run this test by running:
    // zig test hello.zig
}
