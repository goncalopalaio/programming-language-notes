//! This is a top level doc
//! This is the way to document something in general, that is it's not related
//! to what's below.
//! How to run this:
//! zig run hello.zig
//! Build the executable with:
//! zig build-exe hello.zig
//! Run the tests with:
//! zig test hello.zig


// M1 install: ➜ brew install zig --HEAD

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

    // Variables use snake case, functions camelCase.

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
    log("Error -> union 1\ntype: {s}\nvalue: {}\n", .{
        @typeName(@TypeOf(number_or_error)),
        number_or_error,
    });

    number_or_error = 1234;
    log("Error -> union 2\ntype: {s}\nvalue: {}\n", .{
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
    var a_7_bit_integer: i7 = 40;

    // Primitive values
    // true and false
    // null - set an optional type to null
    // undefined - leave value unspecified.

    // TODO: https://ziglang.org/documentation/master/#toc-String-Literals-and-Unicode-Code-Point-Literals


    // Compile time expressions
    comptime {
        var t = 0;
        t += 1;
        t += 1;

        if (t == 2) {
            // log("t is for sure 2: {t}", .{t}); -- This will fail since it requires runtime stuff to run.
        } else {
            @compileError("wrong value");
        }
    }

    comptime var a: i32 = 1000;
    comptime var c: i32 = undefined;

    comptime {
        a = fibonacci(7);
        var b: i32 = fibonacci(9);
        c = fibonacci(10);
    }

    // note: expressions in global scope are implicitly comptime expressions. We can even use functions to initialize complex data there.

    log("comptime fibonacci stuff: {} {}\n", .{a, c});

    log("runtime fibonacci stuff: {}\n", .{fibonacci(7)});

    // Assignment

    const constant_a: i32 = 5;
    var variable_a: u32 = 1000;

    // @as performs an explicit type coercion

    const inferred_constant = @as(i32, 5);
    const inferred_variable = @as(u32, 5000);

    const has_to_have_a_value_a: i32 = undefined;
    var has_to_have_a_value_b: i32 = undefined;

    // Arrays

    const arr_a = [2]u8 {'h', 'i'};
    const arr_b = [_]u8 {'h', 'i'};

    log("arr_a as a string: {s}\n", .{arr_a});
    log("arr_a.len: {}\n", .{arr_a.len});
    log("arr_a: {} {}\n", .{arr_a[0], arr_a[1]});

    // If statements
    // No truthy or falsy values, only bool values are supported

    const going_to_explode = true;
    var explosion_size: u16 = 0;

    if (going_to_explode) {
        explosion_size += 1;
    }

    if (explosion_size == 0) {
        explosion_size -= 1;
    } else if (explosion_size == 1) {
        explosion_size *= 1;
    } else {
        explosion_size = 0;
    }

    // If statements can work as expressions

    const fuel: i32 = 1000;
    explosion_size += if (fuel >= 10) 10 else 0;

    log("explosion: {}\n", .{explosion_size});

    // While loops

    var blowing_up: u8 = 2;
    while (blowing_up < 100) {
        blowing_up *= 2;
    }
    log("boom: {}\n", .{blowing_up});


    var vanishing: u8 = 2;
    while (vanishing < 101) {
        vanishing += 1;

        if (vanishing % 2 == 0) {
            continue;
        }

        if (vanishing > 50) {
            break;
        }
    }
    log("vanishing: {}\n", .{vanishing});

    // For loops

    const color_ids = [_]u8 {'a', 'b', 'c'};

    for (color_ids) |character, index| {
        log("1: color_ids: char: {} idx: {}\n", .{character, index});
    }

    for (color_ids) |character| {
        log("2: color_ids: char: {}\n", .{character});
    }

    for (color_ids) |_, index| {
        log("3: color_ids: idx: {}\n", .{index});
    }

    for (color_ids) |_| {
        log("4: hey\n", .{});
    }


    // Defer will execute a statement while exiting the current block
    // Multiple defers will be executed in reverse order

    var late_to_the_party: i16 = 0;

    {
        defer late_to_the_party += 1;
        if (late_to_the_party == 0) log("I'm still at zero\n", .{});
    }
    log("Check me out, I'm one: {}\n", .{late_to_the_party});

    for (color_ids) |_| {
        defer log("5: I will be printed each time at the end of the loop\n", .{});
        log("5: Hello\n", .{});
    }

    {
        defer log("!\n", .{});
        defer log("i", .{});
        defer log("H", .{});
    }

    // Error set is like an enum. There are no exceptions, errors are values.

    const FileOpenError = error {
        AccessDenied,
        OutOfMemory,
        FileNotFound,
    };

    // Error sets coerce to their super sets.
    const AllocationError = error {
        OutOfMemory,
    };
    const another_err: FileOpenError = AllocationError.OutOfMemory;

    // Error union types
    // An error set type and a normal type can be combined with the ! operator to for an error union type.

    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;

    // catch is used followed by an expression to provide a fallback value (noreturn could also be used (?))
    log("Do we have the expected no_error type: {}\n", .{@TypeOf(no_error) == u16});

    // Example with payload capturing to take the value of the error from a function
    payloadCapturingExample() catch noreturn;

    // Try is a shortcut for x catch |err| return err
    var an_example = tryExample();
    log("This should be the value from the catch {}\n", .{an_example});

    // Errdefer works like defer but only executes when the function is returned from with an error (within the errdefer block).
    var bn_example = errDeferExample() catch 20;
    log("bn_example: {} some_problem: {}\n", .{bn_example, some_problem});

    // Error unions return from a function can have their error sets inferred so it's possible to omit it in the return type.
    const this_failed: error{AccessDenied}!void = createFile();

    // Error sets can be merged

    const SetOfErrorsA = error { NotDir, PathNotFound };
    const SetOfErrorsB = error { OutOfMemory, PathNotFound};
    const SetOfErrorsC = SetOfErrorsA || SetOfErrorsB;

    // There's anyerror which is the global error set (a superset of all error sets). It's usage should be generally avoided.

    // Switch statements. Must be exaustive, there's no fall through, all branches must coerce to the same type. Can be used as an expression.

    var potato: i8 = 10;
    switch(potato) {
        -1...1 => {
            potato = -potato;
        },
        10, 100 => {
            potato = @divExact(potato, 10); // Special considerations must be made when dividing signed integers ((?) - TODO check what this means exactly)
        },
        else => {},
    }

    if (potato == 1) {
        log("potato: {}\n", .{potato});
    } else {
        log("potato has other value: {}\n", .{potato});
    }

    const decider: i8 = 10;
    var tomato = switch (decider) {
        -1...1 => -x,
        10, 100 => @divExact(decider, 10),
        else => decider,
    };

    if (tomato == 1) {
        log("tomato: {}\n", .{tomato});
    } else {
        log("tomato has other value: {}\n", .{tomato});
    }

    // Runtime Safety like checking array bounds is enabled by default. Some types of builds might disabled though (more below)

    // Unreachable is an assertion that the statement will not be reached. Used to tell the compiler the a branch is impossible (fore optimization reasons). Reaching unreachable is detectable illegal behaviour.

    const yu: u32 = 1;
    // const ya: u32 = if (x == 10) else unreachable // Will throw error during runtime

    const a_upper = asciiToUpper('a');
    const a_upper_str = [_]u8 {a_upper};
    log("Upper a: {s}\n", .{a_upper_str});

    // Pointers
    // Normal pointers aren't allowed to have 0 or null as a value.
    // *T where T is the child type.
    // Referencing: &variable
    // De-referencing: variable.*
    var ko: u8 = 1;
    increment(&ko);
    log("ko: {}\n", .{ko});

    var ka: u16 = 0;
    // var ke: *u8 = @intToPtr(*u8, ka); // detectable illegal behaviour.

    // const pointers cannot be used to modify the referenced data.

    const ke: u8 = 1;
    var ki = &ke; // ki is: *const u8
    // ki.* += 1; // compilation error

    // Many-Item Pointers
    // For pointers to an unknown amount of elements: [*]T
    // This supports indexing, pointer arithmetic and slicing.

    // Slices
    // Slices are like a pair [*]T (pointer to data) and usize (element count)

    const pa = [_]u8 { 65, 66, 67, 68, 69, 70 };
    const pa_slice = pa[0..3]; // Slice pa[n..m] -> elements from n to (m - 1)
    log("pa_slice sum: {}\n", .{total_slice(pa_slice)});

    // When n and m are both known at compile time, slicing will produce a pointer to an array (*[N]T will coerce to a []T)
    log("pa_slice has expected type *const [3]u8: {s} :: {s}\n", .{@TypeOf(pa_slice), @TypeOf(pa_slice) == *const [3]u8});

    var pa_sliced_to_the_end = pa[0..];
    log("pa sliced to the end: {s} -> {s}\n", .{pa, pa_sliced_to_the_end});


    // Enums

    const Direction = enum {north, south, east, west };
    const Value = enum(u2) {zero, one, two}; // They can have specified integer tag types
    log("Value: 0 -> {} :: 1 -> {} :: 2 -> {} \n", .{@enumToInt(Value.zero), @enumToInt(Value.one), @enumToInt(Value.two)});

    // Values can be overridden, the next values continue from there
    
    const Value2 = enum(u32) {
        hundred = 100,
        thousand = 1000,
        million = 1000000,
        next
    };

    log("Value: million -> {} :: next (1000001) -> {}\n", .{@enumToInt(Value2.million), @enumToInt(Value2.next)});

    // Methods can be given to enums (note: apparently only when global scoped)
    log("isClubs: {}\n", .{Suit.spades.isClubs()});
    // Enums can also be given var and const declarations. Their values are unrelated and unattached to instances of the enum type (note: like static in java)
    Suit.count += 1;

    // Structs

    const Vec3 = struct {
        x: f32, y: f32, z: f32
    };

    const my_vector = Vec3 {
        .x = 0,
        .y = 100,
        .z = 50,
    };

    log("my_vector: {}\n", .{my_vector});

    // Fields can be given defaults

    const Vec4 = struct {
        x: f32, y: f32, z: f32 = 0, w: f32 = undefined
    };

    const my_vec4 = Vec4 {
        .x = 25,
        .y = 40,
        .w = 100,
    };

    log("my_vec4: {}\n", .{my_vec4});

}

const Suit = enum {
    var count: u32 = 0;
    clubs,
    spades,
    diamonds,
    hearts,

    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};

fn total_slice(values: []const u8) usize {
    var count: usize = 0;
    for (values) |v|  count += v;
    return count;
}

fn increment (num: *u8) void {
    num.* += 1;
}

fn asciiToUpper(x: u8) u8 {
    return switch(x) {
        'a' ... 'z' => x + 'A' - 'a',
        'A' ... 'Z' => x,
        else => unreachable,
    };
}

fn createFile() !void {
    // Error unions return from a function can have their error sets inferred so it's possible to omit it in the return type.
    return error.AccessDenied;
}

var some_problem: u32 = 0;
fn errDeferExample() error{Oops}!u8 {
    errdefer some_problem += 1;

    try failingFunction();

    return 155;
}

fn tryExample() i16 {
    var a_value = failFn() catch |err| {
        return 110;
    };

    return 0;
}

fn failFn() error{Oops}!i32 {
    try failingFunction();

    return 12;
}

fn payloadCapturingExample() !void {
    failingFunction() catch |err| {
        log("Error: {}\n", .{err});
        if (err == error.Oops) {
            log("Oops\n", .{});
        }
        return;
    };

    log("not reachable\n", .{});
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

fn fibonacci(index: i32) i32 {
    if (index < 2) return index;
    return fibonacci(index - 1) + fibonacci(index - 2);
}

// All aggregate types are anonymous, to give it a type, assign it to a constant:

const Node = struct {
    next: *Node,
    name: []u8,
};


test "comments" {
    const x = true; // This is a comment!
    expect(x);

    // Run this test by running:
    // zig test hello.zig
}

test "undefined leaves variables uninitialized" {
    var g: i32 = undefined;
    g = 1;
    expect(g == 1);

    const y = undefined;
}

var z: i32 = add(10, k);
const k: i32 = add(12, 34);

test "things on global scope are order independent, const global variables are comptime-known (as opposed to runtime-known" {
    expect(k == 46);
    expect(z == 56);
}

fn add(a: i32, b: i32) i32 {
    return a + b;
}


test "Global variables can be declared inside struct, union or enum" {
    expect(foo() == 1235);
    expect(foo() == 1236);

    U.f += 1;
    expect(U.f == 2);
}

const U = struct {
    var f: i32 = 1;
};

fn foo() i32 {
    const S = struct {
        var a: i32 = 1234;
    };
    S.a += 1;

    return S.a;
}

// threadlocal variables currently don't work on Mac M1: https://github.com/ziglang/zig/issues/8216 
// 
// threadlocal var q: i32 = 100;
// 
// test "thread local storage" {
//     const t1 = try std.Thread.spawn(testThreadLocalStorage, {});
//     const t2 = try std.Thread.spawn(testThreadLocalStorage, {});
// 
//     testThreadLocalStorage({});
// 
//     t1.wait();
//     t2.wait();
// }
// 
// fn testThreadLocalStorage(context: void) void {
//     assert(q == 100);
//     q += 1;
//     assert(q == 101);
// }


// I would expect that x in S.x would be scoped differently but apparently the declaring var x inside would shadow the existing x. inside S, x would be x and it already exists (? - wonky explanation here)
// const S = struct {
//     var x: i32 = 11111;
// };
// 
// var x: i32 = 9999;
// 
// pub fn main() !void {
//     S.x = 1;
//     x = 9;
// }

test "comptime vars" {
    var x: i32 = 1;
    comptime var y: i32 = 1;

    x += 1;
    y += 1;

    expect(x == 2);
    expect(y == 2);

    if (y != 2) {
        @compileError("wrong y value");
    }
}

