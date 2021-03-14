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
const eql = std.mem.eql;

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

    var fizz_out: u8 = 3;
    while(fizz_out > 0) : (fizz_out -= 1) {
        log("going out: {}\n", .{fizz_out});
    }


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

    // For structs one level of dereferencing is done when accessing fields.
    // Notice the calls to self.x and y in the swap function.

    var my_stuff = Stuff {
        .x = 100,
        .y = 200,
    };

    log("my_stuff: {}\n", .{my_stuff});
    my_stuff.swap();
    log("my_stuff: swapped: {}\n", .{my_stuff});

    // Unions
    // Allows you to define types which store one value of many possible typed fields. Only one field may be active at one time.

    const Payload = union {
        int: i64,
        float: f64,
        bool: bool,
    };

    var payload = Payload {.int = 1234};
    // playload.float = 12.34; // cannot do this

    // Tagged unions
    // Unions that use an enum to detect which field is active.

    const Tag = enum { a, b, c };
    const Tagged = union(Tag) {a: u8, b: f32, c: bool};

    var my_value = Tagged {.b = 1.5};
    switch (my_value) {
        .a => |*byte| byte.* += 1,
        .b => |*float| float.* *= 2,
        .c => |*b| b.* = !b.*,
    }

    log("my_value.b will be 3: {}\n", .{my_value.b});

    // The tag type of a tagged union can also be inferred:
    const TaggedInferred = union(enum) {a: u8, b: f32, c: bool};
    var my_value_inf = Tagged {.c = true};
    log("my_value_inf.c: {}\n", .{my_value_inf.c});

    // void member types can have their type omitted from the syntax. Here none and stuff are of type void:
    // (?) note: not entirely sure what's the point of this.
    const Tagged2 = union(enum) {a: u8, b: f32, none, stuff};
    
    // Integer rules

    const decimal_int: i32 = 98222;
    const hex_int: u8 = 0xff;
    const octal_int: u16 = 0o755;
    const binary_int: u8 = 0b11110000;
    
    // Underscores may be placed as a visual separator.

    const permissions: u64 = 0o7_5_5;
    const te: i32 = 1_0;

    // Integer widening is allowed:
    const aa: u8 = 250;
    const bb: u16 = aa;
    log("same value: {} == {} = {}\n", .{aa,bb, aa == bb});

    // If you have a value that cannot be coerced into the type, @intCast can be used to convert. If the value is out of range it's a detectable illegal behaviour.
    const xx: u64 = 200;
    const yy = @intCast(u8, xx);
    log("coerced: {} into {}\n", .{xx, yy});

    // Integers by default are not allowed to overflow. This is detectable illegal behaviour.
    // For uses cases where overflow is expected the language provides overflow operators.
    var pp: u8 = 255;
    pp +%=1;
    log("overflowed to 0: {}\n", .{pp});

    // Floats
    // Floats are stricly IEEE compliant unless @setFloatMode(.Optimized) is used (equivalent to gcc ffast-math)

    // Widening is also supported:

    const tt: f16 = 1.0;
    const ll: f32 = a;

    // Multiple kinds of literals are supported:
    // Underscores can also be placed between digits.

    const fa: f64 = 123.0;
    const fb: f64 = 123.0E+77;
    const fc: f64 = 123.0e+77;
    const hex_fj: f64 = 0x103.70p-5;
    const hex_fr: f64 = 0x103.70;
    const hex_ft: f64 = 0x103.70P-5;

    // Integers and floats may be converted using @intToFloat, @floatToInt.
    // @intToFloat is always safe, @floatToInt is detectable illegal behaviour when the float value cannot fit into the integer destination type.

    const qa: i32 = 0;
    const qf = @intToFloat(f32, qa);
    log("same value: {} == {} = {}\n", .{qa, qf, qa == qf});

    // Labelled blocks.
    // Blocks are expressions and can be given labels, which can be used to yield values.

    const my_count = my_blk: {
        var sum: u32 = 0;
        var i: u32 = 0;
        while (i < 10) : (i += 1) sum += i;
        break :my_blk sum;
    };

    log("my_count: {}\n", .{my_count});

    // Labelled loops:
    // Loops can be given labels, allowing you to break and continue to outer loops.

    var q_count: usize = 0;
    outer: for ([_]i32 {1,2,3,4}) |_| {
        for ([_]i32 {1,2,3,4}) |_| {
            q_count += 1;
            continue :outer;
        }
    }
    log("q_count: {}\n", .{q_count});

    // Loops as expressions.
    // break accepts a value. This can be used to yield a value from a loop.
    // Loops also have an else branch. It's evaluated when the loop is not exited from with a break;
    log("range has number: {}\n", .{rangeHasNumber(0, 10, 3)});
    log("range has number: {}\n", .{rangeHasNumber(0, 10, 30)});

    // Optionals
    // Use the syntax *T and are used to store data, null or a value of type T.

    var found_index: ?usize = null;
    const ee = [_]i32 {1, 2, 3, 4};
    found_index = findIndexOf(ee, 5);
    log("found_index: {}\n", .{found_index});
    log("found_index: {}\n", .{findIndexOf(ee, 1)});

    // orelse is supported by options. It can be used when the optional is null, it unwraps it and provides a fallback value
    var t4: ?f32 = null;
    var t5 = t4 orelse 0;
    log("t6 should be zero: {} :: type: {}\n", .{t5 == 0, @TypeOf(t5) == f32});

    // When you know it's impossible for an optional value to be null you can use .? as a shorthand for orelse unreachable. Using this unwrapped value when it's null is detectable illegal behaviour.

    const t6: ?f32 = 5;
    const t7 = t6 orelse unreachable;
    const t8 = t6.?;
    log("t7 is equivalent to t8 -> {} == {}\n", .{t7, t8});

    // If optional payload capture:

    // This:
    const o1: ?i32 = 5;
    if (o1 != null) {
        const value = o1.?;
    }

    // Is equivalent to this:
    const o2: ?i32 = 5;
    if (o2) |value| {}

    // You can also use it in a while:
    var sum: u32 = 0;
    while(eventuallyNullSequence()) |value| {
        sum += value;
    }
    log("sum: {}\n", .{sum});

    // Comptime.
    // Code executed at compile time.
    // You can use comptime in variables or as blocks (including calling functions if everything in them can be run during compilation time).

    var x1 = comptime fibonacci(10);
    comptime var x2 = fibonacci(10);
    var x3 = comptime blk: {
        break :blk fibonacci(10);
    };
    log("x1: {} x2: {} x3: {}\n", .{x1, x2, x3});

    // Function parameters can also be tagged as comptime.
    // note: PascalCase functions return a type (this is why TypeOf starts with upper case)
    log("Comparing two types: {} == {} = {}\n", .{Matrix(f32, 4, 4), [4][4]f32, (Matrix(f32, 4, 4) == [4][4]f32)});

    // You can reflect upon types using the built-in @typeInfo
    const si = addSmallInts(u16, 20, 30);
    log("si: {}\n", .{si});

    // note: .{} is the anonymous struct syntax.

    // @Type function creates a type from a @typeInfo
    log("a bigger int: {} {}\n", .{u8, GetABiggerInt(u8)});

    // Returning a struct type is how you make generic data structures.

    const v1 = Vec(3, f32).init([_] f32 {10, -10, 5});
    const v2 = v1.abs();

    log("using std.mem.eql to compare two slices: {} {} -> {}\n", .{v1, v2, eql(f32, &v2.data, &[_]f32 {10, 10, 5})});

    // The types of function parameters cal also be inferred by using anytype in place of a type. @TypeOf can then be used on the parameter
    const t9 = 10;
    log("{} {}\n", .{plusOne(t9), @as(u32, 1)});

    // Comptime also has operators ++ and ** for concatenating and repeating arrays and slices. These operators only work at comptime.

    const t10 = [4]u8 {70, 71, 72, 73};
    const t11 = t10[0..];

    const joined = t10 ++ t11;
    const repeated = t10 ** 4;
    log("joined: {s} repeated: {s}\n", .{joined, repeated});

    // Payload captures
    // Used to capture the value or something, for example in if statements and optionals
    var maybe_num: ?usize = 10;
    if (maybe_num) |n| {
        //expect(@TypeOf(n) == usize);
        //expect(n == 10);
    } else {
        unreachable;
    }
    // With while loops and error unions:
    var summing: ?u32 = 10;
    while (itWillFailEventually()) |value| {
        if (value == 1) {
            summing.? += value;
        }
    } else |err| {
        log("error! {}\n", .{err});
    }
    log("summing! {}\n", .{summing});
    

    // Pointer capture.
    // It's also possible to modify captured values by taking the as pointers using the |*value| syntax.
    const abc = [_]u8 {'a', 'b', 'c'};
    var my_data = [_]u8 {'a', 'b', 'c'};
    for (my_data) |*byte| byte.* += 1;
    log("Pointer capture: {s} -> {s}\n", .{abc, my_data});

    // Inline loops.
    // There's the option to unroll loops at compile time. Using this for performance reasons is inadvisable unless you've tested it. The compiler tends to make better decisions here than you.
    var t_sum: usize = 0;
    const t_types = [_]type {i32, f32, u8, bool };
    inline for (t_types) |T| t_sum += @sizeOf(T);
    log("Type sum: {}\n", .{t_sum});

    // Opaque
    // opaque types have an unknown (non-zero) size and alignment. These types cannot be stored directly. These are used to maintain type safety with pointers to types we don't have information about.
    // for example extern functions (from C).
    // const Window = opaque {};
    // extern fn show_window(*Window) callconv(.C) void;
    // var main_window: *Window = undefined;
    // show_window(main_window);
    // Opaque types may have declarations in their definitions
    // const Window = opaque {
    //  fn show(self: *Window) void {
    //   show_window(self);
    //  }
    // }

    // TODO Anonymous structs
}

var numbers_left2: u32 = undefined;

fn itWillFailEventually() !u32 {
    return if (numbers_left2 == 0) error.ReachedZero else blk: {
        numbers_left2 -= 1;
        break :blk numbers_left2;
    };
}

fn plusOne(x: anytype) @TypeOf(x) {
    return x + 1;
}

fn Vec(comptime count: comptime_int, comptime T: type) type {
    return struct {
        data: [count]T,
        const Self = @This(); // Gets the type of the innermost struct, union or enum.

        fn abs(self: Self) Self {
            var tmp = Self { .data = undefined };

            for (self.data) |elem, i| {
                tmp.data[i] = if (elem < 0) -elem else elem;
            }

            return tmp;
        }

        fn init(data: [count]T) Self {
            return Self {.data = data };
        }
    };
}

fn GetABiggerInt(comptime T: type) type {
    // @Type function creates a type from a @typeInfo
    return @Type(
        .{
            .Int = .{
                .bits = @typeInfo(T).Int.bits + 1,
                .signedness = @typeInfo(T).Int.signedness,
            },
        }
    );
}

fn addSmallInts(comptime T: type, a: T, b: T) T {
    return switch(@typeInfo(T)) {
        .ComptimeInt => a + b,
        .Int => |info| if (info.bits <= 16) a + b else @compileError("ints are too large"),
        else => @compileError("only ints are accepted"),
    };
}

fn Matrix (comptime T: type, comptime width: comptime_int, comptime height: comptime_int) type {
    return [height][width]T;
}

var numbers_left: u32 = 4;
fn eventuallyNullSequence() ?u32 {
    if (numbers_left == 0) return null;
    numbers_left -= 1;
    return numbers_left;
}

fn findIndexOf(arr: [4]i32, number: i32) ?usize {
    for(arr) |v, i| {
        if (v == number) return 1;
    }
    return null;
}

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while(i < end) : (i += 1) {
        if (i == number) break true;
    } else false;
}

const Stuff = struct {
    x: i32,
    y: i32,

    fn swap(self: *Stuff) void {
        const tmp = self.x;
        self.x = self.y;
        self.y = tmp;
    }
};

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

