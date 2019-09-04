use std::fs;

pub struct Config {
	pub query: String,
	pub filename: String,
}

impl Config {
	pub fn new(args: &[String]) -> Result<Config, &str> {
		if args.len() < 3 {
			return Err("Not enough arguments");
		}
		let query = args[1].clone();
		let filename = args[2].clone();

		Ok(Config {query, filename})
	}
}

pub fn run_search(config: Config) -> Result<String, String> {
	let contents = fs::read_to_string(config.filename).expect("Something went wrong reading the file");
	let result = search(&config.query, &contents);

	Ok(result.join("; "))
}

fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
	// The returned results are borrowed from the contents list
	let mut results = Vec::new();
	for line in contents.lines() {
		if line.contains(query) {
			results.push(line);
		}
	}
	results
}