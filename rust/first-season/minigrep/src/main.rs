use std::env;
use std::process;

use minigrep;
use minigrep::Config;

fn main() {
	let args: Vec<String> = env::args().collect();

	println!("Arguments: {:?}", args);

	let config = Config::new(&args).unwrap_or_else(|err| {
		eprintln!("Problem parsing arguments: {}", err);
		process::exit(1);
	});

	// if query.is_empty() {
	// 	query = &"hello".to_owned().to_string();
	// }

	println!("Searching for:\n {}", config.query);
	println!("In file:\n {}", config.filename);
    
    let contents = minigrep::run_search(config).expect("Some error occurred");

   	println!("\nSearch results: \n{}", contents);
}
