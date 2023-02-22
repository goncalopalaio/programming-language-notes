extern crate rand;
use rand::Rng;
// use std::io;
use std::cmp::Ordering;

static HELLO_WORLD: &str = "Hello World. This is used way in the end.";
static mut COUNTER: u32 = 0;

fn main() {
	println!("Guess the number");

	let do_first_section = false;

	if do_first_section {


		// Mutable strings

		let mut guess = String::new();
		println!("{:?}", guess);
		// Input


		//io::stdin().read_line(&mut guess).expect("Failed to read line");

		guess = "1234".to_owned();

		let guess: u32 = guess.trim().parse().expect("Please type a number");

		println!("You guessed {}", guess);


		match guess.cmp(&123) {
			Ordering::Less => println!("Less"),
			Ordering::Greater => println!("Greater"),
			Ordering::Equal => println!("Equal")
		}

		// // // // // // // // // // // // // // // 
		// Variables and Mutability
		// // // // // // // // // // // // // // // 

		let x = 5;
		println!("{:?}", x);

		// can't do this:
		// x = 6;

		let mut y = 12;
		println!("{:?}", y);

		y = 45050;

		println!("{:?}", y);

		// Constants can be declared in any scope:
		const MAX_POINTS: u32 = 1000_000;

		println!("{:?}", MAX_POINTS);


		// Shadowing

		let aa = 5;

		let aa = aa * 1200;
		println!("aa {:?}", aa);

		let spaces = "      ";
		let spaces = spaces.len();

		println!("spaces {:?}", spaces);

		// Shadowing will not work in case of mutable variables
		let mut more_spaces = "      ";
		//more_spaces = spaces.len();

		println!("more_spaces {}", more_spaces);
		more_spaces = "                  ";
		println!("more_spaces {}", more_spaces);

		// // // // // // // // // // // // // // // 
		// Data Types
		// // // // // // // // // // // // // // // 

		// Integer Types
		let a : i8 = 10;
		println!("{:?}", a);
		let a : i16 = 20;
		println!("{:?}", a);
		let a : u8 = 11; 
		println!("{:?}", a);
		let a : u64 = 1000;
		println!("{:?}", a);

		let a : u8 = 0b1111_0000;
		println!("{:?}", a);

		// Floating point types

		let x = 2.11110; // f64
		println!("{:?}", x);

		let y : f32 = 3.11110; // f32
		println!("{:?}", y);

		// Boolean type

		let t = true;
		println!("{:?}", t);
		let f: bool = false;
		println!("{:?}", f);

		// Character type

		let c = 'z';
		let z = '4';

		println!("{:?}", c);
		println!("{:?}", z);
	 

		// // // // // // // // // // // // // // // 
		// Compound types
		// // // // // // // // // // // // // // // 

	 	//// Tuple type

	 	let tup : (i32, f64, u8) = (500, 6.4, 1);

	 	println!("{:?}", tup);

	 	let (x,y,z) = tup;

	 	println!("{:?} {:?} {:?}", x, y, z);

	 	let x = tup.0;
	 	let y = tup.1;
	 	let z = tup.2;
	 	println!("{:?} {:?} {:?}", x, y, z);

	 	//// Array type

		let a = [1,3,4,5,6,7,8];

		println!("{:?}", a);

		let a = ["aaaa", "fffff", "fgffasfd"];

		println!("{:?}", a);

		let a: [i32; 5] = [1,2,3,4,5];

		println!("{:?}", a);

		let first = a[0];
		println!("{:?}", first);

		println!("{:?}", a.len());

		let last = a[a.len() - 1];
		println!("last {:?}", last);

		// Functions

		another_function();
		yet_another_function(145444);
		yet_yet_another_function(145444, 23423);

		//// Expressions
		let x = 5;
		println!("expressions1 x {:?}", x);
		let y = {
			let x = 3;
			println!("expressions2 x {:?}", x);
			x + 1
		};
		println!("expressions3 x {:?}", x);
		println!("expressions4 y {:?}", y);

		//// Functions with return values
		let x = function_with_return_value();
		println!("function_with_return_value result x {:?}", x);

		// // // // // // // // // // // // // // // 
		// Control flow
		// // // // // // // // // // // // // // // 

		//// If expressions

		let number = 3;

		if number < 5 {
			println!("condition was true");
		} else {
			println!("condition was false");
		}

		if number % 4 == 0 {
			println!("Number is divisible by 4");
		} else if number % 3 == 0 {
			println!("Number is divisible by 3");
		} else {
			println!("not divisible by 3 or 4");
		}

		//// Using if in a let statement

		let condition = true;

		let number = if condition {
			5
		} else {
			6
		};

		println!("{:?}", number);

		// // // // // // // // // // // // // // // 
		// Loops
		// // // // // // // // // // // // // // // 

		//// Repeating with loop
		let mut counter = 0;
		loop {
			println!("Again!");
			counter += 1;
			if counter >= 5 {
				break;
			}
		}
		println!("{:?}", counter);

		counter = 0;
		let result = loop {
			println!("Again!");
			counter += 1;
			if counter >= 5 {
				break counter * 3;
			}
		};
		println!("result will be 15 ---> {:?}", result);
		assert_eq!(result, 15);

		//// While

		let mut number = 3;

		while number != 0 {
			println!("{:?}", number);

			number -= 1;
		}
		println!("Lift off!");

		//// Looping through a collection with for

		let a = [10,20,30];
		let mut index = 0;
		println!("Printing with while");
		while index < a.len() {
			println!("{:?}", a[index]);
			index += 1;
		}
		println!("Printing with for");
		for element in a.iter() {
			println!("{:?}", element);
		}

		println!("Printing with range");

		for number in 1..4 {
			println!("{:?}", number);
		}

		println!("Printing with reverse range");

		for number in (1..4).rev() {
			println!("{:?}", number);
		}

		// // // // // // // // // // // // // // // 
		// Ownership
		// // // // // // // // // // // // // // // 

		let s = String::from("AAAAAAA");
		takes_ownership(s);

		//println!("{:?}", s); -> takes_ownership took ownership of s and freed it after it went out of scope

		let a = String::from("#######");
		let a = takes_ownership_ret(a);
		println!("{:?}", a);

		let (b, len) = takes_ownership_ret2(a);

		println!("{:?} {:?}", b, len);

		// Using this method we will always have to return the string to continue having ownership of it and not going out of scope
		// Using references solves this


		//// References and Borrowing

		// calculate_length does not take ownership of b
		// calculate_length borrows b
		println!("{:?}", calculate_length(&b));
		// You can't mutate unmutable references

		//// Mutable references

		let mut s = String::from("Hello");

		println!("{:?}", s);
		
		change_string(&mut s);

		println!("{:?}", s);

		// You only can have one MUTABLE reference to a particular piece of data at a time
		let mut s = String::from("Helllooooo");
		let r1 = &mut s;
		// this will not work a second time
		//let r2 = &mut s;
		println!("{:?}", r1);


		// This case will work since r1 goes out of scope before r2 exists
		let mut s = String::from("Helllooooo");
		{
			let r1 = &mut s;
			r1.push_str("WORLD");
			println!("{:?}", r1);
		}
		let r2 = &mut s;
		r2.push_str("DAAAAAAA");
		println!("{:?}", r2);

		// A similar rule will apply when there's a non-mutable reference already and we try to get another mutable reference


		//// Dangling references

		// The compiler will ensure that there are not dangling references and references are valid
		// See dangle()

		println!("{:?}", no_dangle());


		// // // // // // // // // // // // // // // 
		// The Slice type
		// // // // // // // // // // // // // // // 

		let mut s = String::from("Helloooo world");
		s.push_str("ZZZZZAAAAAAAA");

		let f = first_word(&s);
		// This will produce an error since it will invalidate the slice reference
		// s.clear();
		println!("first word {:?}", f);
		println!("{:?}", first_word_best(&s));

		let a = [1,23,44,555];
		println!("{:?}", a);
		let sliced = &a[2..4];
		println!("{:?}", sliced);
		// With explicit type
		let sliced: &[i32] = &a[0..1];
		println!("{:?}", sliced);

		// // // // // // // // // // // // // // // 
		// Structs
		// // // // // // // // // // // // // // // 

		#[derive(Debug)]
		struct User {
			username: String,
			email: String,
			active: bool,
			sign_in_count: u64
		}

		let user1 = User {
			email: String::from("example@email.com"),
			username: String::from("Joan"),
			active: false,
			sign_in_count: 20
		};

		println!("{:?}", user1);

		// user1 has to be marked as mut so it's modified
		// it's not allowed to mark just one field as mutable
		// user1.email = String::from("example@anothermail.com");

		
		fn build_user(email: String, name: String) -> User {
			User {
				email: email,
				username: name,
				active: false,
				sign_in_count: 1
			}
		}

		println!("{:?}", build_user(String::from("AAAAAA"), String::from("BBBBBBBBB")));

		fn build_user_shorter(email: String, username: String) -> User {
			User {
				username,
				email,
				active: false,
				sign_in_count: 1
			}
		}	
		println!("{:?}", build_user_shorter(String::from("AAAAAA"), String::from("BBBBBBBBB")));

		// Creating other instances using struct update syntax

		let user2 = User {
			username: String::from("USERNAME2"),
			..user1
		};

		println!("{:?}", user2);

		// Tuple structs without named fields
		
		#[derive(Debug)]
		struct Color(i32, i32, i32);
		#[derive(Debug)]
		struct Point(i32, i32, i32);

		let red = Color(255,0,0);
		let origin = Point(0,0,0);

		println!("{:?}", red);
		println!("{:?}", origin);
		println!("{:?}", red.0);

		#[derive(Debug)]
		struct Rectangle {
			width: u32,
			height: u32
		}
		let rect1 = Rectangle {width: 1000, height: 20000};
		println!("Another way of printing with the Debug trait: {:#?}", origin);
		println!("Another way of printing with the Debug trait: {:#?}", rect1);

		// Implementation block

		impl Rectangle {
			fn area(&self) -> u32 {
				// We are using & to do an immutable borrow since we don't want to take ownership of self.
				self.width * self.height
			}

			fn laugh(&self, other: &Rectangle) -> bool {
				println!("Hihihih {:#?} {:#?}", self, other);
				true
			}

			fn square(size: u32) -> Rectangle {
				Rectangle {width: size, height: size}
			}
		}

		let rect2 = Rectangle {width: 5000, height: 4000};
		rect1.laugh(&rect2);
		println!("{:?}", rect1.area());

		// Associated functions
		println!("{:?}", Rectangle::square(44444));

		// It's possible to have multiple Implementation blocks for the same struct

		impl Rectangle {
			fn frown(&self) {
				println!(":(");
			}
		}

		rect1.frown();

		// // // // // // // // // // // // // // // 
		// Enums and Pattern Matching
		// // // // // // // // // // // // // // // 

		#[derive(Debug)]
		enum IpAddressKind {
			V4,
			V6
		}

		let four = IpAddressKind::V4;
		let six = IpAddressKind::V6;
		println!("{:?}", four);
		println!("{:?}", six);

		#[derive(Debug)]
		struct IpAddr {
			kind: IpAddressKind,
			address: String
		}

		let home = IpAddr {
			kind: IpAddressKind::V4,
			address: String::from("127.0.0.1")
		};

		println!("{:?}", home);

		// Enums can have data directly in them

		#[derive(Debug)]
		enum ImprovedIpAddr {
			V4(u8,u8,u8,u8),
			V6(String)
		}

		let another_home = ImprovedIpAddr::V4(127,0,0,1);
		let loopback = ImprovedIpAddr::V6(String::from("::1"));

		println!("{:?}", another_home);
		println!("{:?}", loopback);

		
		// Standard library Option

		// Option has Some(T) and None
		let some_number = Option::Some(555);
		println!("{:?}", some_number);
		let some_number = Some(555);
		println!("{:?}", some_number);

		let absent_number: Option<i32> = None;
		println!("No number in here {:?}", absent_number);


		// The match control flow operator

		#[derive(Debug)]
		enum Coin {
			Penny,
			Nickel,
			Dime,
			Quarter
		}

		fn get_coin_value(coin: Coin) -> u32 {
			match coin {
				Coin::Penny => 555,
				Coin::Nickel => 555,
				Coin::Dime => 555,
				Coin::Quarter => 555,
			}
		}

		println!("{:?}", get_coin_value(Coin::Penny));
		println!("{:?}", get_coin_value(Coin::Nickel));
		println!("{:?}", get_coin_value(Coin::Dime));
		println!("{:?}", get_coin_value(Coin::Quarter));

		fn print_lucky_coin(coin: Coin) -> u32 {
			match coin {
				Coin::Penny => {
					println!("Lucky!");
					555455
				},
				Coin::Nickel => 555,
				Coin::Dime => 555,
				Coin::Quarter => 555,
			}	
		}
		println!("{:?}", print_lucky_coin(Coin::Penny));

		// Patterns that bind to values

		#[derive(Debug)]
		enum Region {
			North,
			Center,
			South
		}

		enum Euro {
			Simple,
			Located(Region)
		}

		fn name(euro: Euro) -> u32 {
			match euro {
				Euro::Simple => 3333333,
				Euro::Located(state) => {
					println!("State {:?}", state);
					5655532
				},
			}
		}

		println!("Name test: {:?}", name(Euro::Located(Region::North)));
		println!("Name test: {:?}", name(Euro::Located(Region::Center)));
		println!("Name test: {:?}", name(Euro::Located(Region::South)));
		println!("Name test: {:?}", name(Euro::Simple));

		// Matching with Option<T>

		fn plus_one(x: Option<i32>) -> Option<i32> {
			match x {
				None => None,
				Some(i) => Some(i + 1)
			}
		}

		let a_five = Some(5);
		let a_six = plus_one(a_five);
		let no_num = plus_one(None);

		println!("{:?} {:?}", a_six, no_num);

		// If you don't want to be exaustive in a match statement use _
		let a_euro = Euro::Simple;
		match a_euro {
			Euro::Simple => println!("Simple"),
			_ => println!("Other things"),
		}

		// There's a more consise alternative to the match statement, if let
		// It allows you to match one pattern and ignore the rest

		// This is the same
		let something = Some(123u8);
		match something {
			Some(3) => println!("Threeeeeee"),
			_ => ()
		}
		// As
		if let Some(3) = something {
			println!("Threeeeeee");
		}

		let another_thing = Some(111u8);
		if let Some(111) = another_thing {
			println!("Ones");
		} else {
			println!("Not ones");
		}


		// // // // // // // // // // // // // // // 
		// Packages, Crates and Modules
		// // // // // // // // // // // // // // // 

		

		pub mod sound {
			fn breathe_in() {
				println!("breathe in");
			}
			pub mod instrument {
				pub fn clarinet() {
					println!("Clarineeetttt");

					super::breathe_in();
				}	
			}
		}

		sound::instrument::clarinet();

		mod plant {
			#[derive(Debug)]
			pub struct Vegetable {
				pub name: String,
				id:i32
			}

			impl Vegetable {
				pub fn new(name: &str) -> Vegetable {
					Vegetable {
						name: String::from(name),
						id: 1
					}
				}
			}

			#[derive(Debug)]
			pub enum Appetizer {
				Soup,
				Salad
			}
		}

		let mut v = plant::Vegetable::new("Pumpkin");
		v.name = String::from("Big Pumpkin");
		println!("{:?}", v.name);
		// Accesses from here to v.id won't work since it's not public

		println!("{:?}", plant::Appetizer::Soup);
		println!("{:?}", plant::Appetizer::Salad);


		// Keyword use to bring paths into a scope
		// use sound::instrument;
		// clarinet();

		// To rename a type use 'as'
		// use std::io::Result as IoResult;

		// Using 'pub use' you can call performance_group::instrument::clarinet();
		// This is Re-exporting.
		//	mod performance_group {
		//		pub use crate::sound::instrument;
		//
		//		pub fn clarinet_trio() {
		//			instrument::clarinet();
		//		}
		//	}

		// External packages 
		// Add to Cargo.toml:
		// [dependencies]
		// rand = "0.5.5"

		// extern crate rand;
		// use rand::Rng;
		println!("{:?}", rand::thread_rng().gen_range(1, 102));

		// Nested paths for cleaning up large use lists

		// use std::cmp::Ordering;
		// use std::io;
		// Instead you can use:
		// use std::{cmp::Ordering, io};

		// Bringing all public definitions into scope with the Glob operator:
		// use std::collections::*:

		// Separating modules into different files:
		// Use:
		// mod sound;
		// to include the module from src/sound.rs
		// now you can use sound using:
		// crate::sound::instrument::clarinet(); <- absolute path
		// sound::instrument::clarinet(); <- relative path


		// // // // // // // // // // // // // // // 
		// Common Collections
		// // // // // // // // // // // // // // // 

		// Vectors

		let v: Vec<i32> = Vec::new();
		println!("{:?}", v);
		// Use the vec! macro for convenience
		let v = vec![1, 2, 3];
		println!("{:?}", v);

		{
			let mut v = Vec::new();
			v.push(5555);
			v.push(555);
			v.push(55);
			v.push(5);
			println!("{:?}", v);
		} // <- v goes out of scope and is freed here


		let v = vec![1, 2, 3, 4];

		let third = &v[2];
		println!("{:?}", third);

		let third: &i32 = &v[2];
		println!("{:?}", third);	

		println!("This returns Some: {:?}", v.get(2));

		// To access an element safely, use .get and match.
		// for example this will fail:
		// println!("This will panic {:?}", &v[10000]);

		match v.get(10000) {
			Some(val) => println!("{:?}", val),
			None => println!("No value here")
		}

		match v.get(2) {
			Some(val) => println!("{:?}", val),
			None => println!("No value here")
		}

		// Iterating values in a vector

		for i in &v {
			println!("{:?}", i);
		}

		// Iterating values in a vector while mutating

		let mut v = vec![1, 2, 3, 4];	
		for i in &mut v {
			*i += 50;
		}
		for i in &v {
			println!("{:?}", i);
		}

		v.push(100);
		v.push(200);
		v.push(300);

		for i in &v {
			println!("{:?}", i);
		}		
		

		// // // // // // // // // // // // // // // 
		// Storing UTF-8 Encoded text with Strings
		// // // // // // // // // // // // // // // 


		
		let hello = String::from("こんにちは");
		println!("{:?}", hello);
		let hello = String::from("Olá");
		println!("{:?}", hello);

		let mut s = String::from("foo");
		s.push_str("bar");
		s.push_str("bar");
		s.push_str("bar");

		let s2 = "bar";
		println!("s2: {:?}", s2);

		s.push_str(s2);

		println!("{:?} {:?}", s, s2);

		// the + operator uses the add method that by itself moves the the first value and a reference to the second

		let s1 = String::from("Hi");
		let s2 = String::from("World");

		let s3 = s1 + &s2;

		println!("{:?}", s3);
		//println!("{:?}", s1); // can't use s1 no more, it was moved in the add operation

		// You can use the format macro when there's a concatenation of multiple values.
		// Since some of the values are moved, it get's a little bit unwieldy.

		let s1 = String::from("la");
		let s2 = String::from("le");
		let s3 = String::from("li");

		let s = s1 + "-" + &s2 + "-" + &s3;
		println!("{:?}", s);
		
		let s1 = String::from("la");
		let s2 = String::from("le");
		let s3 = String::from("li");

		let s = format!("{}-{}-{}", s1,s2,s3);
		println!("{:?}", s);


		// Indexing into strings.first_word_best
		// Rust strings do not support string indexing (why? UTF-8 encoding.)
		// this will give the length. i.e the number of bytes: 10 and 20. To index this directly would be problematic.
		// the we enter into bytes, scalars and graphemes.
		println!("len1: {:?} len2: {:?}", String::from("Holllaaaaa").len(), String::from("Здравствте").len());

		// that said, you can index with a range.
		let hello = "Здравствуйте";
		// each of these characters is 2 bytes. So this will print Зд
		println!("{:?}", &hello[0..4]);

		// This will panic since the byte at index 1 is not a char boundary:
		// println!("{:?}", &hello[0..1]);

		// Methods to iterate strings.
		// Use .chars() Although we can't access directly in O(1) there's knowledge about character boundaries
		println!("Characters:");
		for c in hello.chars() {
			println!("{:?}", c);
		}

		// you can also iterate over bytes if that's what you want:

		println!("Bytes:");
		for b in hello.bytes() {
			println!("{:?}", b);
		}

		// You have to use an external library for graphemes.



		// // // // // // // // // // // // // // // 
		// Hashmaps
		// // // // // // // // // // // // // // // 

		

		use std::collections::HashMap;

		let mut scores = HashMap::new();

		scores.insert(String::from("Blue"), 10);
		scores.insert(String::from("Yellow"), 10);

		println!("scores: {:?}", scores);

		// You can turn tuples or vectors into an hashmap

		let teams = vec![String::from("Blue"), String::from("Yellow")];
		let initial_scores = vec![10, 50];
		// collect can be used into many data structures.
		// _ can be used since the types can be inferred.
		let scores: HashMap<_,_> = teams.iter().zip(initial_scores.iter()).collect();

		println!("Scores for teams: {:?}", scores);

		// Hashmap ownership
		// types that implement Copy (like i32) the values are copied.
		// For owned values like String, the values are moved and hashmap will own them

		let name = String::from("Color");
		let value = String::from("Yellow");
		let mut map = HashMap::new();
		map.insert(name, value);

		println!("{:?}", map);
		// println!("{:?}", name); // this will fail because name was moved
		

		
		{
			// Accessing values
			let mut scores = HashMap::new();
			scores.insert(String::from("Blue"), 100);
			println!("{:?}", scores);

			println!("{:?}", scores.get("Blue"));

			let blue_key = String::from("Blue");
			println!("{:?}", scores.get(&blue_key));

			match scores.get("Blue") {
				Some(val) => println!("{:?}", val),
				None => (),
			}

			if let Some(val) = scores.get("Blue") {
				println!("Blue val: {:?}", val);
			}

			// Overwriting values
			scores.insert(String::from("Blue"), 222100);
			println!("{:?}", scores);

			// Only inserting if the if the key has no value
			
			println!("debug: {:?}", scores.entry(String::from("Blue")));

			scores.entry(blue_key).or_insert(1234);
			println!("{:?}", scores);

			// Updating a value based on the old value

			let text = "hi my world hello hello my world";

			let mut scores = HashMap::new();
			for word in text.split_whitespace() {
				let count = scores.entry(word).or_insert(0);
				*count += 1;
			}

			println!("{:?}", scores);

			// Hashing functions
			// By default HashMap uses a cryptographically strong hashing function to provide resistance to
			// DoS attacks. If this is not required and you find the hashing function to be slow for your needs
			// The hashing function can be replaced by specifying a different hasher
		}

		//  *
		// ***	
		//*****
		// ***
		//	*

		fn diamond(width: u16, height: u16, reverse: bool) {
				let rg: Vec<u16> = if reverse {
					(1..height).rev().collect()
				} else {
					(1..height).collect()
				};

				for h in rg.into_iter() {
					for _spaces in 1..(width-h) {
						print!(" ");
					}
					for _ in 1..(2*h) {
						print!("#");			
					}
					println!("");
				}
					
			}

		diamond(5,5,false);
		diamond(5,5,true);
		diamond(5,5,false);
		diamond(5,5,true);

		// // // // // // // // // // // // // // // 
		// Error handling
		// // // // // // // // // // // // // // // 

		// You can use the panic macro to stop the program and unwind the stack (cleaning up what's above).
		
		// Disabling unwinding and enabling a direct abort can reduce the resulting binary size:
		// Switch it by setting:
		// 
		// 	[profile.release]
		//	panic = 'abort'
		// By enabling abort, the program will stop in the moment and OS will have to clean the memory that the program was using

		// panic!("Aaaah");

		// You can run: RUST_BACKTRACE=1 cargo run
		// for a full back trace


		// // // // // // // // // // // // // // // 
		// Recovering from errors with Result
		// // // // // // // // // // // // // // // 

		use std::fs::File;
		use std::io::Read;

		let f = File::open("hello.txt");
		let mut f = match f {
			Ok(file) => file,
			Err(error) => {
				panic!("There was a problem opening the file {:?}", error)
			}
		};
		let mut content = String::new();
		let read_bytes = match f.read_to_string(&mut content) {
			Ok(text) => text,
			Err(_err) => 0
		};

		println!("Read: {:?}", read_bytes);
		println!("{:?}", content);

		// Matching on different errors
		// You can call Err(error) => match error.kind() to get the enum with the kind of error

		// You can also do:

		use std::io::ErrorKind;

		let f = File::open("hello_other.txt").map_err(|error| {
			if error.kind() == ErrorKind::NotFound {
				File::create("hello_other.txt").unwrap_or_else(|error| { panic!("Failed file creation {:?}", error)})
			} else {
				panic!("There was a problem opening the file {:?}", error);
			}
		});

		println!("{:?}", f);


		// If you wan't you can call:
		let f = File::open("hello.txt").unwrap(); // This either will give you the result or panic!
		println!("{:?}", f);

		// You can also use expect to set the panic message
		let f = File::open("hello.txt").expect("AHHHH");
		println!("{:?}", f);


		// Propagating errors
		use std::io;

		fn read_stuff() -> Result<String, io::Error> {
			let f = File::open("hello.txt");

			let mut f = match f {
				Ok(file) => file,
				Err(e) => return Err(e)
			};

			let mut s = String::new();

			match f.read_to_string(&mut s) {
				Ok(_) => Ok(s),
				Err(e) => Err(e)
			}
		}

		println!("{:?}", read_stuff());

		// You can shorten this method with the ? operator
		// A shortcut to propagate errors:

		fn read_stuff_short() -> Result<String, io::Error> {
			let mut f = File::open("hello.txt")?;
			let mut s = String::new();
			f.read_to_string(&mut s)?;
			Ok(s)
		}

		println!("{:?}", read_stuff_short());

		// You can make this shorter by chaining calls:

		fn read_stuff_even_shorter() -> Result<String, io::Error> {
			let mut s = String::new();
			File::open("hello.txt")?.read_to_string(&mut s)?;
			Ok(s)
		}

		println!("{:?}", read_stuff_even_shorter());


		// Not related to errors but there's an utility to read a string without having you allocating a string manually
		// (only in 1.26??)
		// use std::fs;
		// let res = std::fs::read_to_string("hello.txt");
		// println!("{:?}", res);

		// If you want to return an error from the main function you will have to return a Box<dyn Error> that means any kind of error.


		// // // // // // // // // // // // // // // 
		// To panic! or not to panic!
		// // // // // // // // // // // // // // // 

		


		// Nothing to add besides what's written




		// // // // // // // // // // // // // // // 
		// Generic Types, Traits
		// // // // // // // // // // // // // // // 


		// This won't compile since we need to make sure T supports the > operator (see further how to do it)
		//	fn largest<T>(list: &[T]) -> T {
		//		let mut largest = list[0];
		//
		//		for item in list.iter() {
		//			if item > largest {
		//				largest = item;
		//			}
		//		}
		//
		//		largest
		//	}

		// Generic type in struct
		#[derive(Debug)]
		struct Coord<T> {
			x: T,
			y: T
		}
		let integer_coord = Coord {x: 5, y: 100};
		let float_coord = Coord {x: 1.1, y: 100.22};
		println!("{:?} {:?}", integer_coord, float_coord);

		// Multiple generic types
		#[derive(Debug)]
		struct Place<T, U> {
			x: T,
			y: U,
		}
		let place = Place {x: 5, y: 4.0};
		println!("{:?}", place);

		// Generic types in enums.
		// two examples in the std library: Option and Result
		// enum Option<T> {
		// 	Some(T),
		// 	None,
		// }
		//
		// enum Result<T, E> {
		//	Ok(T),
		// 	Err(E),
		// }

		#[derive(Debug)]
		enum Food<T> {
			Data(T)
		}

		let food_test = Food::Data("hello");
		println!("{:?}", food_test);

		// Generic types in method definitions
		#[derive(Debug)]
		struct Pt<T> {
			x: T, 
			y: T,
		}

		impl<T> Pt<T> {
			fn x(&self) -> &T {
				&self.x
			}
		}

		let pt = Pt {x:5555, y: 555532};

		println!("{:?}", pt.x());

		// What if you wanted to pass a Pt with different types into Pt<T>?
		#[derive(Debug)]
		struct Plc<T, U> {
			x: T,
			y: U,
		}

		impl<T, U> Plc<T, U> {
			fn mixup<V, W>(self, other: Plc<V, W>) -> Plc<T, W> {
				Plc {
					x: self.x,
					y: other.y,
				}
			}
		}

		let p3 = (Plc { x: 5, y: 123 }).mixup(Plc {x: 'h', y: "world"});
		println!("{:?}", p3);



		// Traits
		// Tells the compiler about functionality a particular type has.
		
		// With no default implementation:
		// pub trait Summary {
		//	fn summarize(&self) -> String;
		// }

		// You can also provide a Default implementations for a trait

		pub trait Summary {
			fn summarize(&self) -> String {
				String::from("(Read more..)")
			}
		}


		#[derive(Debug)]
		struct Article {
			headline: String,
			location: String,
			author: String,
			content: String,
		}

		// If there's a default implementation for the trait and there's no implementation defined by the struct, the default will be used
		impl Summary for Article {}


		let article = Article {
			headline: String::from("lalala"),
			location: String::from("lalala"),
			author: String::from("lalala"),
			content: String::from("lalala"),
		};

		println!("{}", article.summarize());

		#[derive(Debug)]
		struct Tweet {
			username: String,
			content: String,
			reply: bool,
			retweet: bool,
		}

		impl Summary for Tweet {
			fn summarize(&self) -> String {
				format!("{} {}", self.username, self.content)
			}
		}

		let tweet = Tweet {
			username: String::from("lalala"),
			content: String::from("Hello from the tweet"),
			reply: false,
			retweet: false
		};

		println!("1 new tweet, summary: {}", tweet.summarize());


		// Default implementations can call other methods in the same trait
		trait MegaSummary {
			fn summarize_author(&self) -> String;

			fn mega_summarize(&self) -> String {
				format!("Read more from {}...", self.summarize_author())
			}
		}

		impl MegaSummary for Tweet {
			fn summarize_author(&self) -> String {
				format!("@{}", self.username)
			}
		}

		println!("{}", tweet.mega_summarize());


		// Traits as arguments
		// You can enforce an argument of a certain type to have a certain trait.
		fn notify(item: impl Summary) {
			println!("Breaking news: {}", item.summarize());
		}

		notify(tweet);


		// That was a shorter version of:

		fn notify_longer<T: Summary>(item: T) {
			println!("Breaking news: {}", item.summarize());	
		}

		let another_tweet = Tweet {
			username: String::from("lalala"),
			content: String::from("Hello from the tweet"),
			reply: false,
			retweet: false
		};

		notify_longer(another_tweet);

		// Both versions work for multiple arguments:
		fn notify_both(item1: impl Summary, item2: impl Summary) {
			println!("{} {}", item1.summarize(), item2.summarize());
		}

		// But if you need to enforce that both parameters are the same type and have the trait 
		// you have the use the second version
		fn notify_one_type<T: Summary>(item1: T, item2: T) {
			println!("{} {}", item1.summarize(), item2.summarize());	
		}

		let tweet = Tweet { username: String::from("lalala"), content: String::from("Hello from the tweet"), reply: false, retweet: false,};

		notify_both(tweet, article);

		//notify_one_type(tweet, article);

		let tweet_1 = Tweet { username: String::from("lalala"), content: String::from("Hello from the tweet"), reply: false, retweet: false,};
		let tweet_2 = Tweet { username: String::from("lalala"), content: String::from("Hello from the tweet"), reply: false, retweet: false,};
		
		notify_one_type(tweet_1, tweet_2);

		// You can specify multiple traits with '+'
		// fn notify(item: impl Summary + Display) { ...
		// fn notify<T: Summary + Display>(item: T) { ...
		
	 	// When you have a lot of trait bounds there's a third way to declare them.
	 	// You can turn this:

	 	// fn some_func<T: Display + Clone, U: Clone + Debug>(t: T, u: U) -> i32 { ...

	 	// Into this:

	 	// fn some_func<T, U>(t: T, u: U) -> i32
	 	// 	where T: Display + Clone,
	 	// 		  U: Clone + Debug
	 	// {
	 	// 	// Implementation
	 	// }

	 	// Return traits
	 	// You can also use the impl Trait syntax in returns to return something that implements a specific trait.
	 	// Although you only can return a single type, that is you couldn't return both a Tweet or an Article

	 	fn gives_a_summarizable_thing() -> impl Summary {
			Tweet {
				username: String::from("summarizer"),
				content: String::from("Hello from the tweet"),
				reply: false,
				retweet: false
			}
	 	}
	 	println!("{}", gives_a_summarizable_thing().summarize());

	 	// You can use there trait bounds to implement methods according to their type and the traits they implement
	 	use std::fmt::Display;
	 	impl< T: Display + PartialOrd> Coord<T> {
	 		fn cmp_display(&self) {
	 			if self.x >=  self.y {
	 				println!("{} >= {}", self.x, self.y);
	 			} else {
	 				println!("{} < {}", self.x, self.y);
	 			}
	 		}
	 	}

	 	(Coord { x: 100, y: 10 }).cmp_display();

	 	// You can also implement a trait for any type that implements another trait.
	 	// The standard library uses these blanket implementations with ToString for us to call to_string in several types

	 	// impl<T: Display> ToString for T {...
	 	let s = 3.to_string();
	 	println!("{:?}", s);



		// // // // // // // // // // // // // // // 
		// Lifetimes
		// // // // // // // // // // // // // // // 

		// Validating references with lifetimes.

		// Lifetimes are used to prevent dangling references

		fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
			if x.len() > y.len() {
				x
			} else {
				y
			}
		}

		// In this case (which won't compile) the borrow checker prevents a dangling reference to str2.
		// If this compiled, str_result could have a str_2 reference after the value is dropped at the end of the scope
		// let str_1 = String::from("long string is long");
		// let str_result;
		// {
		// 	let str_2 = String::from("xyz");
		// 	str_result = longest(str_1.as_str(), str_2.as_str());
		// 	println!("longest string is {}", str_result);	
		// }

		println!("{:?}", longest("AAAAAAA", "BBBBBB"));


		// Lifetime annotations in Struct definitions:

		#[derive(Debug)]
		struct ImportantThing<'a> {
			part: &'a str
		}

		let novel = String::from("Call on me. aaah hhh...aaaa");
		let first_sentence = novel.split(".")
			.next()
			.expect("Could not find a '.'");
		
		let i = ImportantThing { part: first_sentence};
		println!("{:?}", i);

		
		// Lifetime Elision
		// In some occasions, the compiler can figure out the lifetimes and you can optionally skip defining the lifetimes.

		// The patterns of analysis of references of the compiler are called the lifetime elision rules.
		// You can consider three existing rules:
		// For example, by default each argument to a function gets it's own lifetime parameter.
		// If there's only one input lifetime parameter, that lifetime is assigned to all output parameters
		// If there's multiple lifetime parameters but one is &self or &mut self, all output lifetime parameters are assigned the lifetime of self

		// Here's two examples where you don't need implicit lifetime annotations in the methods:

		impl<'a> ImportantThing<'a> {
			fn level(&self) -> i32 {
				3
			}
		}

		// This is an example of the third rule written above
		// self and announcement get their own lifetimes, the return type gets the lifetime of &self, with that, all lifetimes have been accounted for.
		impl<'a> ImportantThing<'a> {
			fn announce_and_return_part(&self, announcement: &str) -> &str {
				println!("Attention! {}", announcement);
				self.part
			}
		}
		println!("{:?} {:?}", i.level(), i.announce_and_return_part("WARNING"));
		// The Static lifetime

		// This lifetime denotes the entire lifetime of the program.

		// For example string literals have a 'static lifetime
		let s1 = "I have a static lifetime";
		// which in turn could be annotated as:
		let s2: &'static str = "I have a static lifetime";

		println!("{:?} {:?}", s1, s2);


		// Generic Type parameters, Trait bounds and Lifetimes
		// Now, all together.

		fn longest_with_announcement<'a, T>(x: &'a str, y: &'a str, announcement: T) -> &'a str
		where T: Display {
			println!("{}", announcement);
			if x.len() > y.len() {
				x
			} else {
				y			
			}
		}

		println!("{:?}", longest_with_announcement("AAA", "BBBB", "ADASDASD"));




		// // // // // // // // // // // // // // // 
		// Automated tests
		// // // // // // // // // // // // // // // 

		// Use: cargo test
		// to run all tests in the project
		
		// Note: See the actual tests defined module below

		// You can also define Benchmark tests (rust nightly currently)

		// // // // // // // // // // // // // // // 
		// Building a command line program
		// // // // // // // // // // // // // // // 

		// See minigrep folder (does not really follow the book that much)



		// // // // // // // // // // // // // // // 
		// Functional language features: Iterators and Closures
		// // // // // // // // // // // // // // // 

		// Closures
		// Unlike functions, closures  can capture values from the scope they're defined.

		let a_number = 212;

		let expensive_closure = |num| {
			println!("Calculating... {}", num);

			num * 1111111
		};

		println!("Running.... {}", expensive_closure(a_number));
		
		// Sometimes you have to add type annotations

		let another_closure = |num: u32| -> u32 {
			num * 100000
		};

		println!("Running.... {}", another_closure(a_number));


		// Structs can hold closures too:

		#[derive(Debug)]
		struct Cacher<T>
			where T: Fn(u32) -> u32
		{
			calculation: T,
			value: Option<u32>,
		}

		impl<T> Cacher<T>
			where T: Fn(u32) -> u32
		{
			fn new(calculation: T) -> Cacher<T> {
				Cacher {
					calculation,
					value: None
				}
			}

			fn value(&mut self, arg: u32) -> u32 {
				match self.value {
					Some(v) => v,
					None => {
						let v = (self.calculation)(arg);
						self.value = Some(v);
						v
					}
				}
			}
		}

		// In some occasions you can ommit the brackets
		let mut multiplier_cacher = Cacher::new(|x| x * 2);
		let mut adder_cacher = Cacher::new(|x| {
			println!("Doing add calculation");
			x + 2
		});

		println!("Multipler: {}", multiplier_cacher.value(123123));
		println!("----");
		println!("Adder #1: {}", adder_cacher.value(1000));

		
		// Capturing environment with closures

		let x = 4;
		let equal_to_x = |z| z == x;
		let y = 4;
		assert!(equal_to_x(y));
		println!("{}", x);

		// If you want to force the closure to take ownership of the values you use the move keyword

		// (we're using a vector in the example since integers are copied instead of moved)
		let x = vec![1,2,3];
		let another_equal = move |z| z == x;

		let y = vec![1,2,3];
		println!("{}", another_equal(y));
		// println!("{:?}", x); // can't use x anymore since it was moved into the closure

	} // if do_first_section



	// // // // // // // // // // // // // // // 
	// Iterators
	// // // // // // // // // // // // // // // 


	let v1 = vec![1,2,3,4,5,6,7,8];

	for v in v1.iter() {
		println!("Got: {}", v);
	}

	let mut it = v1.iter();
	loop {
		// note: there's probably a better way to this 
		let next = match it.next() {
			Some(val) => val,
			None => break
		};
		println!("You can call next() directly. Got: {}", next);	
	}

	// Some methods can consume an iterator

	let sum: i32 = v1.iter().sum();
	println!("{:?}", sum);
	// (sum() takes ownership of iter)

	// Some methods can produce iterators from iterators

	// a call to map will take a closure that's called in each item and produces a new iterator

	let plus_one: Vec<_> = v1.iter().map(|x| x + 1).collect();
	println!("{:?}", plus_one);

	// Using closures that capture their environment

	// filter will run the closure, if it returns true, the item will be included in the next iterator

	#[derive(Debug)]
	struct Shoe {
		size: u32,
		brand: String,
	}
	let shoes = vec![
		Shoe {size: 10, brand: String::from("Nike")},
		Shoe {size: 5, brand: String::from("Adidas")},
		Shoe {size: 20, brand: String::from("Other")},
	];
	println!("Initial shoes {:?}", shoes);

	let mut big_shoes: Vec<Shoe> = shoes.into_iter().filter(|s| s.size >= 10).collect();
	println!("Big shoes {:?}", big_shoes);


	// Implementing your own iterator

	// note: this specific code does not do anything useful, is just an example:
	impl Iterator for Shoe {
		type Item = u32; // Set an associated type (the iterator will return u32 values)

		fn next(&mut self) -> Option<Self::Item> {
			self.size += 1;

			Some(self.size)
		}
	}

	println!("{}", big_shoes[0].next().unwrap());

	// Using our minigrep as an example, you could refactor how the arguments are read by using an iterator instead of indexing directly
	let args = vec!["name_of_program", "first_argument", "second_argument"];
	{
		let mut it = args.iter();
		it.next();

		let query = match it.next() {
			Some(arg) => arg,
			None => ""
		};

		let filename = match it.next() {
			Some(arg) => arg,
			None => ""
		};
		println!("{:?} {:?}", query, filename);


		// Making code clearer with Iterator Adaptors

		// We can remove the mutable state of the results variable:
		pub fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
		    let mut results = Vec::new();

		    for line in contents.lines() {
		        if line.contains(query) {
		            results.push(line);
		        }
		    }

		    results
		}
		println!("{:?}", search("aaaaa", "asdasdaaaaaaaaa"));

		// By using Iterator Adaptors. This way we remove the intermediate mutable state of the result variable.
		// Additionally we might enable a future enhancement by searching in parallel without managing concurrent access.

		fn search_with_the_filter_adaptor<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
			contents.lines()
			.filter(|line| line.contains(query))
			.collect()
		}		
		println!("{:?}", search_with_the_filter_adaptor("aaaaa", "asdasdaaaaaaaaa"));



		// Comparing performance of Loops vs Iterators
		// (In theory iterators are a zero cost abstraction, see the book for more details)	
	}



	// // // // // // // // // // // // // // // 
	// Customizing builds with release profiles
	// // // // // // // // // // // // // // // 

	// You can add multiple profiles and define an optimization level for each one
	

	// [profile.custom]
	// opt-level = 3

	// Rust defines default profiles for dev and release
	// (dev has default optimization level 0, maximum is 3 which is define for release by default)
	// use cargo build --release


	// // // // // // // // // // // // // // // 
	// Publishing a Crate to Crates.io
	// // // // // // // // // // // // // // // 

	// Documentation comments

	/// Ads one to the number given
	/// # Examples
	///
	/// ```
	/// let five = 5;
	/// assert_eq!(6, mycrate::add_one(5));
	/// ```

	fn add_one(x: i32) -> i32 {
		x + 1
	}

	// cargo doc --open
	// Will build the HTML for your current crate's documentation

	// For example you can add this to the beggining of src/libs.rs
	// to describe the crate in general
	// 			//! # My Crate
	// 			//!
	// 			//! `my_crate` is a collection of utilities to make performing certain
	// 			//! calculations more convenient.


	// See more details on how to publish your crate in the book

	

	// // // // // // // // // // // // // // // 
	// Cargo workspaces
	// // // // // // // // // // // // // // // 

	// Workspaces can be used to avoid recompiling other crates if they are shared between your multiple library crates.
	// In practice you will have a single target directory and you avoid unnecessary compiling
	
	// See more details in the book.

	

	// // // // // // // // // // // // // // // 
	// Installing binaries from Crates.io
	// // // // // // // // // // // // // // // 

	// You can use 
	// cargo install
	// To install binaries from crates.io.
	// For example to install the tool ripgrep:
	// cargo install ripgrep

	

	// // // // // // // // // // // // // // // 
	// Extending Cargo with custom commands
	// // // // // // // // // // // // // // // 

	// If a binary in your path is named cargo-something you can run it as it was a cargo subcommand by running:
	// cargo something
	// To list the available commands do: cargo --list


	
	// // // // // // // // // // // // // // // 
	// Smart Pointers
	// // // // // // // // // // // // // // // 

	// Use box to store data on the heap. This is equivalent to a smart pointer in C++
	// The contained data is freed at the end of scope

	let b = Box::new(5);

	println!("{:?}", b);

	// Recursive types.
	// Use Cons to define recursive types

	#[derive(Debug)]
	enum List {
		Cons(i32, Box<List>),
		Nil,
	}

 	let list = List::Cons(1,
        Box::new(List::Cons(2,
            Box::new(List::Cons(3,
                Box::new(List::Nil))))));
 	println!("{:?}", list);


 	// You can create your own smart pointers by implementing the Deref trait.

 	use std::ops::Deref;

 	#[derive(Debug)]
 	struct MyBox<T>(T);

 	impl<T> Deref for MyBox<T> {
 		type Target = T;

 		fn deref(&self) -> &T {
 			&self.0
 		}
 	}

 	let my_box = MyBox(123);
 	println!("{:?}", my_box);
 	println!("{:?}", *my_box);

 	// Deferencing using * is equivalent to *(y.deferef())


 	// Rust sometimes does deref coersion.

 	fn my_box_hello(name: &str) {
 		println!("Hello {}", name);
 	}

 	let m = MyBox(String::from("Rust"));
 	my_box_hello(&m);
 	// No need to implicitly dereference the value inside the box that is inside MyBox.
 	// This is equivalent to calling:
 	my_box_hello(&(*m));



 	// You can implement your custom Drop trait to control what happens when the variables go out of scope.

 	#[derive(Debug)]
 	struct Square {
 		data: String
 	}

 	impl Drop for Square {
 		fn drop(&mut self) {
 			println!("Dropping {}", self.data);
 		}
 	}

 	
 	{
 		let a = Square{data: String::from("HEllo A")};
	 	let b = Square{data: String::from("HEllo B")};

 		println!("Dropping a at the end of the scope: {:?}", a);
 		println!("Dropping b at the end of the scope: {:?}", b);

 		{
 			// You can drop values early by using:
			std::mem::drop(b);

			// explicit calls to a.drop() don't work to avoid double free calls at the end of the scope
	
 		}
 		
 		println!("END of scope");
 	}
 	


 	// Reference Counted Smart pointers RC<T>

 	// This enables multiple ownership in single threaded scenarios.
 	use std::rc::Rc;

 	// A better example would be a data structure with a recursive type (Cons).

 	let a = Rc::new(String::from("AAAAAAAAAAAAA"));
 	{
 		let b = Rc::clone(&a);
 		// It's better to use the explicit call to Rc::clone 
 		// The clone call increments the reference count.

 		println!("You can use strong_count to get the reference count: {:?}", Rc::strong_count(&a));
 		println!("{:?}", b);
 	}
 	println!("You can use strong_count to get the reference count: {:?}", Rc::strong_count(&a));

 	println!("{:?}", a);

 	// This is used to allocate data on the heap for multiple parts of the program but
 	// at compile time we can't be certain which part will finish first and which uses the data last.
 	// The value is dropped when the reference count goes to 0



 	// RefCell<T> and the Interior Mutability Pattern

 	// This allows you to get around borrowing rules at compile time. (In single thread scenarios)

 	// With Box<T> rules are enforced at compile time. With RefCell the rules are enforced at runtime.

 	// Rc<T> enables multiple owners of the same data.
 	// Box<T> and RefCell<T> have single owners.
 	// Box<T> allows immutable or mutable borrows; checked at compile time.
 	// Rc<T> only allows immutable borrows; checked at compile time.
 	// RefCell<T> allows immutable or mutable borrows; checked at runtime.
 	// With RefCell<T> you can mutate the value inside RefCell<T> even when RefCell<T> is immutable.

 	use std::cell::RefCell;
	#[derive(Debug)] 	
	struct MockMessage {
		messages: RefCell<Vec<String>>,
	}

	let message = MockMessage {
		messages: RefCell::new(vec![])
	};

	println!("Messages: {:?}", message);

	impl MockMessage {
		fn send(&self, message: &str) {
			// The reference to self is not mutable, but we can mutate messages
			self.messages.borrow_mut().push(String::from(message));

			let crash_in_runtime = false;
			if crash_in_runtime {

				// RefCell allows us to have many immutable borrows or one mutable borrow at any point in time

				let mut first_borrow = self.messages.borrow_mut();
				let mut second_borrow = self.messages.borrow_mut();
				
				// This compiles but it will crash in runtime since there's two mutable active references.

				first_borrow.push(String::from("Booom"));
				second_borrow.push(String::from("There it goes"));
			}
		}
	}

	message.send("HELLO");
	println!("Messages: {:?}", message);


	// Having multiple owners of mutable data by combining Rc<T> and RefCell<T>

	// Rc<T> to have multiple owners of the same data (immutable) and RefCell<T> to let us mutate it.

	// Preventing memory leaks is not one of Rust's guarantees.
	// It's possible that by using both in some situations you can create reference cycles leading to memory leaks.
	// Rc::clone increases the strong_count of Rc<T>. Rc<T> is only cleated if strong_count goes to zero.
	// You can use Rc::downgrade and get a Weak<T>, this will not increase the strong_count, instead it will
	// increase the weak_count. The main difference is that weak_count does not need to be 0 for that reference instance
	// to be cleaned.

	// Before using a Weak<T> you need to call upgrade(), this in turn will return an Option<Rc<T>>.
	// If Some the Rc<T> hasn't been dropped yet, None means that the value has been already dropped.

	// For more details: https://doc.rust-lang.org/book/ch15-06-reference-cycles.html

	

	// // // // // // // // // // // // // // // 
	// Fearless concurrency
	// // // // // // // // // // // // // // // 

	use std::thread;
	use std::time::Duration;

	let handle = thread::spawn(|| {
		let mut a = 0;
		for i in 1..1000 {
			a +=i;
		}
		println!("Thread -> {} {:?}", a, thread::current().id());	
		for i in 1..10 {
			thread::sleep(Duration::from_millis(2));
			println!("Thread -> {} {:?}", i, thread::current().id());	
		}
		

	});
	
	for i in 1..10 {
		thread::sleep(Duration::from_millis(2));
		println!("Main Thread -> {} {:?}", i, thread::current().id());
	}
	
	handle.join().unwrap();

	// Using move closures with threads
	// Using move will force the closure to take ownership of the values it uses from its external environment.

	let v = vec![1,2,3,4];

	let handle = thread::spawn(move || {
		println!("Here's the vector {:?} {:?}", v, thread::current().id());
	});

	// println!("{:?}", v); // v can no longer be used here, since it was moved into the closure and there's no guarantee that the reference is still valid.

	handle.join().unwrap();




	// Using message passing to transfer data between threads




	// Channels
	use std::sync::mpsc;

	let (tx, rx) = mpsc::channel();

	thread::spawn(move || {
		let val = String::from("Hello from the other thread");
		tx.send(val).unwrap();
		// At this point the ownership of val is transferred to the receiver and no longer can be used.
	});

	let received_value = rx.recv().unwrap(); // there's also try_recv that won't block this thread
	println!("Got: {:?}", received_value);


	// rx can also be treated as an iterator:
	

	let (tx, rx) = mpsc::channel();
	thread::spawn(move || {
		for i in 1..10 {
			println!("Sending {:?} from thread: {:?}", i, thread::current().id());
			tx.send(i).unwrap();
			thread::sleep(Duration::from_millis(16));
		}
	});	

	for received in rx {
		println!("Received: {:?} in thread: {:?}", received, thread::current().id());
	}


	// Creating multiple producers by cloning the transmitter


	let (tx, rx) = mpsc::channel();
	let tx2 = mpsc::Sender::clone(&tx);
	thread::spawn(move || {
		for i in 1..10 {
			println!("Sending {:?} from thread: {:?}", i, thread::current().id());
			tx.send(i).unwrap();
			thread::sleep(Duration::from_millis(16));
		}
	});	

	thread::spawn(move || {
		for i in 50..60 {
			println!("Sending {:?} from thread: {:?}", i, thread::current().id());
			tx2.send(i).unwrap();
			thread::sleep(Duration::from_millis(16));
		}
	});

	for received in rx {
		println!("Received: {:?} in thread: {:?}", received, thread::current().id());
	}	





	// Shared-state Concurrency



	// Mutex<T>
	// In the case where we need to share a mutex between two different threads we will need to use
	// Arc<T> that is a type like Rc<T> but safe for use in concurrent situations. It ensure that the reference counting is atomic.
	// We can't use simply a Mutex<T> and shared it directly between to threads since the move semantics will ensure the
	// ownership is transferred to only one of the threads.

	// Note: Rust can't protect you from all kinds of logic erros when using Mutex<T>

	use std::sync::{Mutex, Arc};
	let counter = Arc::new(Mutex::new(0));
	let mut handles = vec![];

	for _ in 0..3 {
		let counter = Arc::clone(&counter);
		let handle = thread::spawn(move || {
			let mut num = counter.lock().unwrap(); // a lock call might fail if the program is panicking.
			*num += 1; // As you can see, Mutex<T> also gives interior mutability.
			println!("Count is: {:?} (Thread:{:?})", *num, thread::current().id());
		});
		handles.push(handle);
	}

	for handle in handles {
		handle.join().unwrap();
	}

	println!("Final count is {:?}", *counter.lock().unwrap());

	// The Send Trait will allow transference of ownership between threads.
	// The Sync Trait will allow access from multiple threads.

	// You normally don't need to implement these traits manually. To do so you will need an unsafe block.
	// See more details in the book.



	// // // // // // // // // // // // // // // 
	// Object Oriented Programming features of Rust
	// // // // // // // // // // // // // // // 



	// You can implement object oriented patterns using Rust dialects.
	// Instead of relying on the compiler to generate nongeneric implementations of functions you can also
	// perform dynamic dispatch at the some cost of optimizations that the compiler won't be able to do at compile time.
	// There's also a runtime cost.
	// This is done using the dyn keyword.
	// struct Screen {
	// 	components: Vec<Box<dyn Draw>>,
	// }
	//
	// impl Screen {
	//	fn run(&self) {
	//		for component in self.components.iter() {
	//			component.draw();
	//		}
	// 	}
	//}
	// 
	// More details in the book.




	// // // // // // // // // // // // // // // 
	// Patterns and Matching
	// // // // // // // // // // // // // // // 



	let favorite_color: Option<&str> = None;
	let is_tuesday = false;
	let age: Result<u8,_> = "34".parse();

	if let Some(color) = favorite_color {
		println!("Favorite color {}", color);
	} else if is_tuesday {
		println!("Today is tuesday");
	} else if let Ok(age) = age {
		if age > 30 {
			println!("aahhh");
		} else {
			println!("eeehhh");
		}
	} else {
		println!("aaaaaaHHHHHH");
	}

	// While let

	let mut stack = Vec::new();
	stack.push(12);
	stack.push(112);
	stack.push(1112);
	stack.push(121112);

	while let Some(top) = stack.pop() {
		println!("pop until you stop: {}", top);
	}

	let v = vec!['a', 'b', 'c'];

	for (index, value) in v.iter().enumerate() {
		println!("{:?} -> {:?}", index, value);
	}

	// Destructuring a tuple
	let  (x,y,z) = (1,2,3);
	println!("{:?} {:?} {:?}", x,y,z);

	// Function parameters can also be patterns

	fn print_coordinates(&(x,y): &(i32,i32)) {
		println!("Current location {},{}", x, y);
	}

	let point = (100,200);
	print_coordinates(&point);

	// Refutability: Whether a pattern might fail to match.
	// Function parameters, let, for loops can only accept irrefutable patterns.
	// for example you can't to: let Some(x) = some_option_value;
	// but you can do: if let Some(x) = some_option_value
	// since they're intended to handle possible failures in matching the pattern.


	// Pattern syntax

	let x = 1;

	match x {
		1 => println!("One"),
		2 => println!("Two"),
		3 => println!("Three"),
		_ => println!("other"),
	}

	let x = Some(5);
	let y = 10;

	match x {
		Some(50) => println!("Got 50"),
		Some(y) => println!("Got {}, this is the y inside this scope ", y),
		_ => println!("Got other thing {:?}", x),
	}

	println!("This is the y in the outer scope: {:?}", y);

	// Multiple patterns
	let x = 2;
	match x {
		1 | 2 | 3 => println!("One Two Three"),
		_ => println!("other"),
	}

	// Ranges of values
	let x = 3;
	match x {
		1 ... 3 => println!("One Two Three"),
		_ => println!("other"),
	}

	let x = 'c';

	match x {
		'a' ... 'j' => println!("early ascii character"),
		'k' ... 'z' => println!("early ascii character"),
		_ => println!("something else")
	}	
		

	// Destructuring
	#[derive(Debug)]
	struct Point<T> {
		x: T,
		y: T,
	}
	let p = Point {x: 0, y: 333};


	let Point { x: a, y: b } = p;
	println!("Point-> a {:?} b {:?}", a, b);
	
	let Point { x, y } = p;
	println!("Point-> x {:?} y {:?}", x, y);

	match p {
		Point { x, y: 0 } => println!("Y is zero and x is {:?}", x),
		Point { x: 0, y } => println!("X is zero and y is {:?}", y),
		Point { x, y } => println!("X is {:?} and y is {:?}", x, y),
	}

	enum Message {
		Quit,
		Move { x: i32, y: i32 },
		Write(String),
		ChangeColor(i32,i32,i32),
	}

	let mut messages = vec![];
	messages.push(Message::ChangeColor(0, 100, 200));
	messages.push(Message::Quit);
	messages.push(Message::Move{ x: 100, y: 50 });
	messages.push(Message::Write(String::from("Write this")));

	for msg in messages {
		match msg {
			Message::Quit => println!("Quit!"),
			Message::Move { x, y } => println!("Move! {} {}", x, y),
			Message::Write(text) => println!("Write text: {}!", text),
			Message::ChangeColor(r, g, b) => println!("Change Color {} {} {}", r, g, b),
		}	
	}

	// Destructuring Nested Structs and Enums

	enum Color {
		Rgb(i32, i32, i32),
		Hsv(i32, i32, i32)
	}
	enum ColorMessage {
		Quit,
		ChangeColor(Color)
	}
	
	let _msg = ColorMessage::ChangeColor(Color::Rgb(0, 160, 255));
	let _msg = ColorMessage::Quit;
	let msg = ColorMessage::ChangeColor(Color::Hsv(0, 160, 255));

	match msg {
		ColorMessage::ChangeColor(Color::Rgb(r, g, b)) => {
			println!("Change color rgb: {:?} {:?} {:?}", r, g, b);
		},
		ColorMessage::ChangeColor(Color::Hsv(h, s, v)) => {
			println!("Change color Hsv: {:?} {:?} {:?}", h, s, v);
		},
		_ => ()
	}


	// Destructuring References

	let points = vec![
		Point {x: 0, y: 333},
		Point {x: 1, y: 33},
		Point {x: 2, y: 33}
	];

	let sum_of_squares: i32 = points.iter().map(| &Point { x, y } | x * x + y * y).sum();
	println!("Sum of squares: {}", sum_of_squares);

	// Destructuring Structs and Tuples

	let ((feet, meters), Point { x, y }) =((3, 10), Point {x: 23, y: -10});
	println!("feet: {} meters: {} x: {} y: {}", feet, meters, x, y);

	

	// Ignoring values


	// Ignoring an entire value

	fn foo(_: i32, y: i32) {
		println!("Only using the y value don't know why: y: {}", y);
	}

	foo(3,123123);

	// Ignoring parts of a value

	let mut first_value = Some(5);
	let another_value = Some(2123);

	match (first_value, another_value) {
		(Some(_), Some(_)) => println!("Both already have a value, ignoring"),
		_ => {
			first_value = another_value;
		},
	}

	println!("First value: {:?}", first_value);

	let numbers = (123, 1, 213);
	match numbers {
		(first, _ , third) => println!("{:?} {:?}", first, third),
	}

	// Note: if you create a variable starting with underscore, the warning about unused warnings will not be shown but a variable will still be created, differing of a single _
	let _unused = 12;

	

	// Ignoring Remaining Parts of a value with ..

	let point = Point {x: 0, y: 333};

	match point {
		Point {x, .. } => println!("{:?}", x),
	}

	let numbers = (2, 3, 3, 3, 4);
	match numbers {
		(first, .., last) => println!("{:?} {:?}", first, last),
	}



	// Extra conditionals with Match Guards


	let num = Some(5);
	match num {
		Some(x) if x < 5 => println!("less than five {}", x),
		Some(x) => println!("val {}", x),
		None => (),
	}

	let x = 4;
	let y = false;

	match x {
		4 | 5 | 6 if y => println!("The if y applies to 4, 5 and 6"),
		_ => println!("no")
	}

	// @Bindings

	enum Fact {
		Hello {id: i32},
	}

	let msg = Fact::Hello {id: 5};

	match msg {
		Fact::Hello {id: id_variable @ 3 ... 7} => {
			println!("id in range {:?}", id_variable);
		},
		_ => (),
	}


	// Legacy patterns: ref and ref mut
	// In older versions of Rust, match would assume that you want to move what is matched, but sometimes that's
	// not what you wanted. Current Rust no longer works like that but you might see ref being used in special cases:
	// More details in the book.

	let robot_name = &Some(String::from("Bors"));

	match robot_name {
		&Some(ref name) => println!("Found a name {}", name),
		None => (),
	}

	println!("Robot name is : {:?}", robot_name);

	println!(":::Without ref's :::");

	match robot_name {
		Some(name) => println!("Found a name {}", name),
		None => (),
	}
	
	println!("Robot name is : {:?}", robot_name);



	// // // // // // // // // // // // // // // 
	// Advanced features
	// // // // // // // // // // // // // // // 
	
	// (Will be a bit sparse, more details in the book)

	// Unsafe Rust
	// Dereferencing a Raw Pointer

	// You can create raw pointers in safe code, you just can't dereference it.
	// This might be used while interfacing with C code.1
	let mut address = 112312323i32;

	let r2 = &mut address as *mut i32;

	// At this arbitrary memory location there might be data or might not. This is undefined behavior, the compiler might remove the call, the program might error out; it's probably result in a segmentation fault.
	unsafe {
		println!("You can derefence the pointers inside an unsafe block {}", *r2);
		// Note (myself): Not sure what's happening here with the values that being printed, the first one is just printing the address
		*r2 = 122;
		println!("You can derefence the pointers inside an unsafe block {}", *r2);
	}

	// Caling an unsafe function or method.

	unsafe fn dangerous() {}
	unsafe {
		dangerous();
	}



	// Creating a Safe abstraction over unsafe code


	// Using unsafe blocks is a common pattern
	// Let's take split_at_mut from the standard library.

	let mut v = vec![1,2,3,4,5,6];

	{
		let r = &mut v[..];

		let (a, b) = r.split_at_mut(3);
		assert_eq!(a, &mut [1, 2, 3]);
		assert_eq!(b, &mut [4, 5, 6]);	
	}
	
	use std::slice;
	fn our_split_at_mut(slice: &mut [i32], mid: usize) -> (&mut [i32], &mut [i32]) {
		let len = slice.len();
		assert!(mid <= len);

		// This won't work for the borrow checker. 
		// We're borrowing the same slice mutably two times.
		// The borrow checker has no concept that it's two different parts of the slice.
		//(&mut slice[..mid],
		//	&mut slice[mid..])

		// This will work:

		let ptr = slice.as_mut_ptr();

		unsafe {
			(slice::from_raw_parts_mut(ptr, mid),
				slice::from_raw_parts_mut(ptr.offset(mid as isize), len - mid))
		}
	}
	
	let (a, b) = our_split_at_mut(&mut v[..], 3);
	assert_eq!(a, &mut [1, 2, 3]);
	assert_eq!(b, &mut [4, 5, 6]);


	// Using extern Functions to Call external code
	// externs facilitates the creation and use of a Foreign Function Interface (FFI).

	// This is an example how setup an integration the abs function from the C standard.

	// "C" part defines which application binary interface (ABI) the external function uses.
	extern "C" {
		fn abs(input: i32) -> i32;
	}

	unsafe {
		println!("Absolute value from C abs: {}", abs(-333));
	}


	// Calling Rust functions from other languages:
	// The extern keyboard is also used
	// #[no_mangle] annotation is used to the the Rust compiler to not mangle the name of the function so it's readable from other languages
	// More details in the book



	// Accessing or Modifying a mutable static variable


	println!("This is a not mutable static variable {}", HELLO_WORLD);

	// Accessing a mutable static variable is unsafe:

	// COUNTER += 123;
	// println!("{:?}", COUNTER);
	unsafe {
		COUNTER += 123;
		println!("COUNTER: {:?}", COUNTER);
	}

	// Implementing an Unsafe Trait.
	// Traits can also be marked as unsafe.
	// More details in the book



	// // // // // // // // // // // // // // // 
	// Advanced Lifetimes
	// // // // // // // // // // // // // // // 

	// Ensuring One Lifetime outlives another with lifetime subtyping
	// You can use 'b: 'a to declare that b lives at least as long as a
	// More details in the book

	// struct Parser<'c, 's: 'c> {
	// 	context: &'c Context<'s>,
	// }


	// It's possible to add lifetime constraints on generic types
	struct Stuff<'a, T: 'a>(&'a T);
	// T can be any type but if contains any references, the references must live as least as long as 'a
	// You can also use 'static to denote that if T contains any references the must have a 'static lifetime
	// 'static lifetime means that the reference must live as long as the entire program.



	// Inference of trait object lifetimes

	// You don't have to explicitly define lifetimes everytime:
	// 		The default lifetime of a trait object is 'static.
	// 		With &'a Trait or &'a mut Trait, the default lifetime of the trait object is 'a.
	// 		With a single T: 'a clause, the default lifetime of the trait object is 'a.
	// 		With multiple clauses like T: 'a, there is no default lifetime; we must be explicit.
	// More details in the book

	// The anonymous lifetime

	// You can use '_ in some occasions to avoid typing the lifetime everywhere:
	// verbose
	// impl<'a> fmt::Debug for StrWrap<'a> {
	// elided
	// impl fmt::Debug for StrWrap<'_> {
	// More details in the book


	// // // // // // // // // // // // // // // 
	// Advanced Traits
	// // // // // // // // // // // // // // // 


	// Associated types

	// This is an alternative to using generics while defining traits.
	// Using generics one could implement multiple traits implementation for the same struct
	// having to explicitly refer to type when calling,
	// for example an Iterator.
	// Using an associated type this is simplified and you don't have to specify the type everytime.

	trait MyIterator {
		type Item;
		fn next(&mut self) -> Option<Self::Item>;
	}

	#[derive(Debug)]
	struct Counter(u32, String);

	impl MyIterator for Counter {
		type Item = u32;
		fn next(&mut self) -> Option<Self::Item>{
			Some(self.0)
		}
	}

	let result = (Counter(123, String::from("CountMe"))).next();
	println!("{:?}", result);

	// Instead of:

	trait MyIteratorWithGenerics<T> {
		fn next_with_generics(&mut self) -> Option<T>;
	}

	impl MyIteratorWithGenerics<u32> for Counter {
		fn next_with_generics(&mut self) -> Option<u32> {
			return Some(self.0)
		}
	}

	impl MyIteratorWithGenerics<String> for Counter {
		fn next_with_generics(&mut self) -> Option<String> {
			return Some(self.1.to_owned())
		}
	}
	// In this case, you are allowed to have multiple implementations for different types
	// for that reason you have to specify a type.
	let result: Option<String> = (Counter(123, String::from("CountMe"))).next_with_generics();
	println!("{:?}", result);



	// Default Generic Type Parameters and Operator overloading

	// If you define a default concrete type for a generic type you don't have to 
	// specify a concrete type if the default type works for an implementation
	// This is done with the syntax:

	// <PlaceholderType=ConcreteType>

	// This is used for example with operator overloading:

	use std::ops::Add;

	#[derive(Debug, PartialEq)]
	struct Place {
		x: i32,
		y: i32,
		z: i32
	}

	// The trait std::ops::Add looks like this:

	// trait Add<RHS=Self> {
	// 	type Output;
	// 	fn add(self, rhs: RHS) -> Self::Output;
	// }

	// RHS is a default type parameter, in this case, if a type is not explicitly defined,
	// The type that will be used for the rhs parameter of add will Self (the same type that is implementing the trait) 

	impl Add for Place {
		type Output = Place;

		fn add(self, other: Place) -> Place {
			Place {
				x: self.x + other.x,
				y: self.y + other.y,
				z: self.z + other.z,
			}
		}
	}


	println!("{:?}", Place{x: 1,y: 2, z: 3} + Place{x: 1, y: 2, z: 3});

	// To overload the operator and return another type diferent than Self
	// you just need to set type type as "impl Add<AnotherThing>"



	// Fully Qualified Syntax for Disambiguation


	// It's possible to implement traits with the same method names as another one.
	// Sometimes you will need to use the fully qualified syntax to determine what method will be called.
	// If there's multiple implementations with the same method name,
	// the one implemented directly on the type will take precedence.

	trait Pilot {
		fn fly(&self);
	}

	trait Driver {
		fn fly(&self);
	}

	struct Human;

	impl Pilot for Human {
		fn fly(&self) {
			println!("Hello captain");
		}
	}

	impl Driver for Human {
		fn fly(&self) {
			println!("Drivers can't fly");
		}
	}

	impl Human {
		fn fly(&self) {
			println!("Just a Human after all");
		}
	}

	let person = Human;
	person.fly(); // This will print "Just a Human after all"

	// To call the other implementations you need to clarify:
	Pilot::fly(&person);
	Driver::fly(&person);

	// You can also do it for Human which is the equivalent of calling person.fly()
	Human::fly(&person);
	// person.fly() works because Rust knows the type to call from 'self'
	// But if there's not a self type you have to use 
	// the fully qualified syntax


	trait Animal {
		fn baby_name() -> String;
	}

	struct Dog;

	impl Dog {
		fn baby_name() -> String {
			String::from("Spot")
		}
	}

	impl Animal for Dog {
		fn baby_name() -> String {
			String::from("Puppy")
		}
	}

	// let dog = Dog;
	// println!("{:?}", dog.baby_name()); // Won't work
	println!("{:?}", Dog::baby_name());
	println!("{:?}", <Dog as Animal>::baby_name());



	// Using Supertraits to require on trait's functionality within another trait.

	use std::fmt;

	trait OutlinePrint: fmt::Display {
		fn outline_print(&self) {
			let text = self.to_string(); // To call to_string() on self you will need to ensure
			// self has a trait that implements it. 
			// This is why 'OutlinePrint: fmt::Display'
			let len = text.len();

			println!("* {} *", "*".repeat(len));
			println!("* {} *", text);
			println!("* {} *", "*".repeat(len));
		}
	}

	impl OutlinePrint for String {}

	(String::from("This is an example").outline_print());


	// this case looks like this for a custom type:

	impl fmt::Display for Dog {
		fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
			write!(f, "IMMA DOG")
		}
	}

	impl OutlinePrint for Dog {}

	let dog = Dog;
	dog.outline_print();



	// Using the Newtype pattern to implement external Traits on External Types

	// Basically to get around the limitation of not being allowed to implement a trait on external types
	// You can wrap the external type into a local type a do it.
	// This technique can also be used for type safety and abstraction.


	// Creating type synonyms with type aliases

	type Kilometers = i32;

	let x: i32 = 5;
	let y: Kilometers = 5;
	println!("x + y = {}", (x + y));
	// As you can see it's still treated as the same type.
	// This is mostly used to reduce repetition.

	// for example in std::io Result is a synonim of another type:
	// type Result<T> = Result<T, std::io::Error>;



	// The Never Type that nevers returns


	// This is used for functions that never return
	// More details in the book
	fn _bar() -> ! {
		loop {
			println!("Looping forever");
		}
	}



	// Dynamically Sized Types and the Size Trait
	// &str is used instead of std since it contains an address to the string and another value with it's length ( that is, a &str is 2 x usize)
	// More details in the book
	


	// // // // // // // // // // // // // // // 
	// Advanced Functions and Closures
	// // // // // // // // // // // // // // // 


	// Function Pointers

	fn add_one_number(x: i32) -> i32 {
		x + 1
	}

	fn do_twice(f: fn(i32) -> i32, arg: i32) -> i32 {
		f(arg) + f(arg)
	}

	let answer = do_twice(add_one_number, 5);
	println!("do_twice: {:?}", answer);

	let answer = do_twice(|x| { x + 1}, 5);
	println!("do_twice: {:?}", answer);

	// You can use a function pointer or a closure.
	// But in case of external code that doesn't have closures (like C) you have to use function pointers


	// There are cases where you can also use tuple struct enums as parameters:
	#[derive(Debug)]
	enum Status {
		Value(u32),
		Stop,
	}

	let list_of_statuses: Vec<Status> = (0u32..20).map(Status::Value).collect();
	println!("list_of_statuses: {:?}", list_of_statuses);
	println!("{:?}", Status::Stop);



	// Returning Closures


	// fn returns_fn() -> Fn(i32) -> i32 {
		//return |x| x + 1
		// returning directly won't work since closures are represented by traits
		// and you can't know the size of it at compile type.	
	//}

	// To do it you have to a Trait Object (Chapter 17)

	fn returns_closure() -> Box<dyn Fn(i32) -> i32> {
		Box::new(|x| x + 1)
	}



	// // // // // // // // // // // // // // // 
	// Macros
	// // // // // // // // // // // // // // // 

	// This is a metaprogramming utility.
	// It's used to implement traits; implementations etc. automatically.
	// It's run at compile time.




	// Declarative macros



	// Examples println!; vec! etc.

	// You create them by using #[macro_export] 

	// For example, a simpler version of vec! could be:

	#[macro_export]
	macro_rules! simple_vec {
		( $( $x: expr ),*) => {
			{
				let mut temp_vec = Vec::new();
				$(
					temp_vec.push($x);
				)*
				temp_vec
			}
		};
	}

	let v = simple_vec![12,23,42];
	println!("simple_vec: {:?}", v);



	// Procedural macros

	// These accept Rust code as input and operate over it to produce other rust code. (instead of matching patterns as declarative macros)

	// Commented it since you can't use a procedural macro from the same crate that defines it.
	// It needs to be implemented in a separate crate.
	
	//	extern crate proc_macro;
	//	use crate::proc_macro::TokenStream;
	//	use quote::quote;
	//	use syn;
	//
	//	#[proc_macro_derive(HelloMacro)]
	//	fn hello_macro_derive(input: TokenStream) -> TokenStream {
	//		let ast = syn::parse(input).unwrap();
	//
	//		impl_hello_macro(&ast)
	//	}
	//
	//	fn impl_hello_macro(ast: &syn::DeriveInput) -> TokenStream {
	//	    let name = &ast.ident;
	//	    let gen = quote! {
	//	        impl HelloMacro for #name {
	//	            fn hello_macro() {
	//	                println!("Hello, Macro! My name is {}", stringify!(#name));
	//	            }
	//	        }
	//	    };
	//	    gen.into()
	//	}
	//
	//	#[derive(HelloMacro)]
	//	struct Pancakes;
	//
	//  Pancakes::hello_macro();



	// Attribute-like macros


	// derive only works for structs and enums, attribute-like macros also can go into functions

	// For example:
	// #[route(GET, "/")]
	// fn index {}
	// More details in the book


	// Function-like macros

	// These are macros that look like function calls. 
	// For example:

	// let sql = sql!(SELECT * FROM posts WHERE id=1);
	// More details in the book

}

// // // // // // // // // // // // // // // 
// Automated tests
// // // // // // // // // // // // // // // 

fn hello_place(place: &str) -> String {
	if !place.contains("world") {
		panic!("Place did not contain world");
	}
	let message = format!("Hello {}", place);
	println!("{}", message);
	return message
}

#[cfg(test)]
mod tests {
	use super::*; // visibility rules apply, this is used to get access to hello_place

	#[test]
	fn sum_works() {
		assert_eq!(2+2, 4)
	}
	
	#[test]
	fn multiply_works() {
		assert_eq!(2*2, 4)
	}

	// Besides a wrong assert, a panic! will make the tests fail
	// There's multiple assert macros such as:
	// assert_eq!
	// assert_ne!
	// assert!

	#[test]
	fn message_works() {
		let message = String::from("Hello world");

		// You can define a message to show when the assert fails
		assert!(message.contains("world"), "Message did not contain world. Value was {}", message);
	}	

	// When you need to ensure a method method panics correctly:
	#[test]
	#[should_panic]
	fn hello_world_panics_correctly() {
		hello_place("sea");
	}

	#[test]
	#[should_panic(expected="Place did not contain world")]
	fn hello_world_panics_correctly_with_a_specific_panic() {
		hello_place("sea");
	}

	#[test]
	fn hello_world_works() {
		assert_eq!(hello_place("world"), "Hello world");
	}

	// You can also write tests using Result

	#[test]
	fn results_are_correct() -> Result<(), String> {
		if 2 + 2 == 4 {
			Ok(())
		} else {
			Err(String::from("Some kind of error"))
		}
	}

	// By default the tests are ran in parallel using threads.
	// You can control this using:
	// cargo test -- --test-threads=1
	// The first -- is used to separate arguments that go into cargo test and the resulting test binary
	// You can also enable println output from the tests with the --no-capture flag

	// You can choose which tests to run.
	// cargo test sum
	// cargo test hello
	// Tests that have that string in the name will run.

	// You can ignore tests by defaults while running:
	// cargo test
	// by adding [#ignore] to the test
	// that way, only if you invoke the test by name the test will run. It won't be part of the general cargo test list of tests.
	// if you want to run all ignored tests you can use --ignored


	// You can choose to test private private functions

	// For integration tests with a project that provides a binary, normally you use the src/main.rs that uses src/libs.rs
	// so the tests have access to the full libs.rs functionality. That way you can have a third tests directory.

}

// // // // // // // // // // // // // // // 



// This will work with String and str values
fn first_word_best(s: &str) -> &str {
	let bytes = s.as_bytes();

	for (i, &item) in bytes.iter().enumerate() {
		if item == b' ' {
			return &s[0..i];
		}
	}

	&s[..]
}

fn first_word(s: &String) -> &str {
	let bytes = s.as_bytes();

	for (i, &item) in bytes.iter().enumerate() {
		if item == b' ' {
			return &s[0..i];
		}
	}

	&s[..]
}

fn no_dangle() -> String {
	let s = String::from("HIII");
	// ownership will be moved out
	s
}

// The following code won't compile:
// let reference_to_nothing = dangle();
// fn dangle() -> &String {
// 	let s = String::from("Hello");
//	// s will go out of scope and dropped
// 	&s
// }
	
fn change_string(some_string: &mut String) {
	some_string.push_str(", World");
}
fn calculate_length(s: &String) -> usize {
	s.len()
}
fn takes_ownership(some_string: String) {
	println!("{:?}", some_string);
}

fn takes_ownership_ret(some_string: String) -> String{
	println!("{:?}", some_string);

	return some_string;
}

fn takes_ownership_ret2(some_string: String) -> (String, usize){
	println!("{:?}", some_string);
	let l = some_string.len();

	(some_string, l)
}

fn function_with_return_value() -> i32 {
	5
}
fn another_function() {
	println!("Another function");
}

fn yet_another_function(x: i32) {
	println!("yet_another_function: {:?}", x);
}

fn yet_yet_another_function(x: i32, y: i32) {
	println!("yet_yet_another_function: {:?} {:?}", x, y);	
}