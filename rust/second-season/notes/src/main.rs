fn main() {
    println!("Hello!");
    variables();
    data_type_exploration();
}


fn variables() {
    let a_number; // You can bound it later
    let b_number = 5;
    a_number = 6;
    let c_number = "Seven";

    println!("Formatting with placeholders, {}, {}, {}", a_number, b_number, c_number);
    
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
    
}
