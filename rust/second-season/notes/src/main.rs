fn main() {
    println!("Hello!");
    variables();
    data_type_exploration();
    data_collections();
    enum_types_for_compound_data();

    functions();
    exercise_build_a_car();

    create_and_use_arrays();
    vector_data_types();
    exercise_compound_types();
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

    // How to instantiate:
    let user = Student {
        name: String::from("Cabbage"),
        remote: true,
        level: 32,
    };
    let mark = Grades('A', 'A', 'A', 3.2);

    println!("{} {} {}", user.name, user.remote, user.level);
    println!("{} {} {} {}", mark.0, mark.1, mark.2, mark.3);
}

fn enum_types_for_compound_data() {
    #[allow(dead_code)] // Unused
    enum WebEvent {
        // Enum variant can be like a unit struct.
        WeLoad,
        // Enum variant can be like a tuple struct.
        WeKeys(String, char),
        // Enum variant can be like a classic struct.
        WeClick { x: i64, y: i64 },
    }

    #[derive(Debug)]
    struct KeyPress(String, char);

    #[derive(Debug)]
    struct MouseClick {
        x: i64,
        y: i64,
    }

    #[derive(Debug)]
    enum Event {
        WeLoad(bool),
        WeClick(MouseClick),
        WeKeys(KeyPress),
    }

    // How to instantiate:

    let click = MouseClick { x: 100, y: 300 };
    let keys = KeyPress(String::from("Ctrl+"), 'N');
    println!("{} {} {} {}", &click.x, &click.y, &keys.0, &keys.1);

    let w = Event::WeLoad(true);
    let c = Event::WeClick(click);
    let k = Event::WeKeys(keys);

    // Using #[derive(Debug)] to print the struct content using {:#?}.
    println!("{:#?} {:#?} {:#?}", w, c, k);
}

fn functions() {
    fn goodbye(message: &str) {
        println!("{}", message);
    }
    goodbye("Bye!");

    fn divide_by_5(num: u32) -> u32 {
        if num == 0 {
            return 0;
        }
        num / 5
    }

    let num = 5;
    println!("{}", divide_by_5(num));
}

fn exercise_build_a_car() {
    // Declare Car struct to describe vehicle with four named fields
    struct Car {
        color: String,
        transmission: Transmission,
        convertible: bool,
        mileage: u32,
    }

    #[allow(dead_code)] // Some fields are unused
    #[derive(PartialEq, Debug)]
    // Declare enum for Car transmission type
    enum Transmission {
        // todo!("Fix enum definition so code compiles");
        Manual,
        SemiAuto,
        Automatic,
    }

    // Build a "Car" by using values from the input arguments
    // - Color of car (String)
    // - Transmission type (enum value)
    // - Convertible (boolean, true if car is a convertible)
    fn car_factory(color: String, transmission: Transmission, convertible: bool) -> Car {
        // Use the values of the input arguments
        // All new cars always have zero mileage
        Car {
            color: color,
            transmission: transmission,
            convertible: convertible,
            mileage: 2000,
        }
    }

    let car = car_factory(String::from("Red"), Transmission::Automatic, false);
    println!(
        "Car = {}, {:?} transmission, convertible: {}, mileage: {}",
        car.color, car.transmission, car.convertible, car.mileage
    );
}

fn create_and_use_arrays() {
    let days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thrusday",
        "Friday",
        "Saturday",
        "Sunday",
    ];

    let zeros = [0; 5]; // 5 zeroes
    let ones: [u32; 6] = [1; 6];

    let first_day = days[0];
    println!(
        "{} {} {} {} {}",
        first_day, days[1], days[2], zeros[0], ones[0]
    );
}

fn vector_data_types() {
    // Unlike arrays, vectors can grow or shrink at any time

    let three_nums = vec![15, 3, 654];
    let zeros = vec![0; 5];
    println!("{:?} {:?}", three_nums, zeros);

    let mut fruit = Vec::new();
    fruit.push("Apple");
    fruit.push("Banana");
    fruit.push("Cherry");
    println!("{:?}", fruit);
    fruit.pop();
    fruit.pop();
    fruit[0] = "Pineapple";
    println!("{:?} {}", fruit, fruit[0]);
}

fn exercise_compound_types() {
    #[derive(PartialEq, Debug)]
    enum Age {
        New,
        Used,
    }

    #[derive(PartialEq, Debug)]
    // Declare Car struct to describe vehicle with four named fields
    struct Car {
        color: String,
        motor: Transmission,
        roof: bool,
        age: (Age, u32),
    }

    #[derive(PartialEq, Debug)]
    // Declare enum for Car transmission type
    enum Transmission {
        Manual,
        SemiAuto,
        Automatic,
    }

    fn car_quality(miles: u32) -> (Age, u32) {
        let age = if miles == 0 { Age::New } else { Age::Used };

        (age, miles)
    }

    fn car_factory(color: String, motor: Transmission, roof: bool, miles: u32) -> Car {
        // Create a new "Car" instance as requested
        // - Bind first three fields to values of input arguments
        // - "age" field calls "car_quality" function with "miles" input argument
        Car {
            color: color,
            motor: motor,
            roof: roof,
            age: car_quality(miles),
        }
    }

    // Create car color array
    let colors = ["Blue", "Green", "Red", "Silver"];

    // Declare the car type and initial values
    let mut car: Car = car_factory(String::from(colors[0]), Transmission::Manual, false, 2000);
    let mut engine: Transmission = Transmission::Automatic;

    // Car order #1: New, Manual, Hard top
    car = car_factory(String::from(colors[0]), engine, true, 0);
    println!(
        "Car order 1: {:?}, Hard top = {}, {:?}, {}, {} miles",
        car.age.0, car.roof, car.motor, car.color, car.age.1
    );

    // Car order #2: Used, Semi-automatic, Convertible
    engine = Transmission::SemiAuto;
    car = car_factory(String::from(colors[1]), engine, false, 100);
    println!(
        "Car order 2: {:?}, Hard top = {}, {:?}, {}, {} miles",
        car.age.0, car.roof, car.motor, car.color, car.age.1
    );

    // Car order #3: Used, Automatic, Hard top
    engine = Transmission::Automatic;
    car = car_factory(String::from(colors[2]), engine, true, 200);
    println!(
        "Car order 3: {:?}, Hard top = {}, {:?}, {}, {} miles",
        car.age.0, car.roof, car.motor, car.color, car.age.1
    );
}
