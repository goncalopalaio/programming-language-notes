fn main() {
    println!("Hello!");
    variables();
    data_type_exploration();
    data_collections();
}

fn variables() {
    let a_number; // You can bound it later
    let b_number = 5;
    a_number = 6;
    let c_number = "Seven";

    println!(
        "Formatting with placeholders, {}, {}, {}",
        a_number, b_number, c_number
    );

    // Use mut for mutable variables
    let mut d_number = 10;
    println!("Before {}", d_number);
    d_number = 20;
    println!("After {}", d_number);

    // Shadowing
    // The old variable still exists but you can't no longer refer to it in this scope
    let shadow_num = 5;
    let shadow_num = shadow_num + 5;
    let shadow_num = shadow_num * 2;
    println!("Shadow number is {}", shadow_num);
}

fn data_type_exploration() {
    let number: u32 = 14;
    println!("number is {}", number);

    // Length	Signed	Unsigned
    // 8-bit	i8	    u8
    // 16-bit	i16	    u16
    // 32-bit	i32	    u32
    // 64-bit	i64	    u64
    // 128-bit	i128	u128
    // architecture-dependent	isize	usize

    // Floating point
    // 32-bit    f32
    // 64-bit    f64

    println!("{} {} {} {}", 1u32 + 2, 8i32 - 5, 15 * 3, 60 / 3);

    // Boolean
    let a: bool = false;
    let b = true;
    let is_bigger = 1 > 4;
    println!("{} {} {}", a, b, is_bigger);

    // Characters
    let upper_s = 'S';
    let lower_f = 'f';
    let smiley = '😃';
    println!("{} {} {}", upper_s, lower_f, smiley);
    // Unlike some languages that treat char types as 8-bit unsigned integers,
    // the char type here contains unicode code points, a char in Rust is a 21-bit integer that's padded to be 32 bits wide.
    // The char contains the plain code point value directly.

    // Strings

    // str type -> string slice, it's a view into string data.
    // &str behaves like as a pointer to immutable string data.
    // String literals are all of type &str.

    // String type -> string type, allocated on the heap.
    // Length doesn't need to be known at compile time.

    let string_1 = "Banana"; // Creates a reference (&str) to the str data type.
    let string_2: &str = "Pineapple";
    println!("{} {}", string_1, string_2);
}

fn data_collections() {
    // Tuples
    let e = ('E', 5i32, true);
    let d: (char, i32, bool) = ('E', 5i32, true);

    println!("{} {} {}", e.0, e.1, e.2);
    println!("{} {} {}", d.0, d.1, d.2);

    // Structs
    // Type composed of other types. The elements are called fields.
    // Three struct types:
    // Classic C structs    -> Each field has a name and data type.
    // Tuple structs        -> Similar to Classic C structs but fields don't have names.
    // Unit structs         -> Most commonly used as markers (useful for Rust's traits).

    struct Student {
        name: String,
        level: u8,
        remote: bool,
    }

    struct Grades(char, char, char, f32);

    // struct UnitExample;

    // How to instantiate.
    let user = Student {
        name: String::from("Cabbage"),
        remote: true,
        level: 32,
    };
    let mark = Grades('A', 'A', 'A', 3.2);

    println!("{} {} {}", user.name, user.remote, user.level);
    println!("{} {} {} {}", mark.0, mark.1, mark.2, mark.3);
}
