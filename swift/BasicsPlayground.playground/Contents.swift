import Cocoa



// Follows the 'Develop in Swift Fundamentals' book



// Constants
let greeting = "Hello"

// Variables
var str = "Person"

print(greeting + " " + str)

let anInt = 4
let aDouble = 14.34
let aBool = true
let exampleString = "AA"

let aLargeNumber = 1_000_000_000

var calculation = aLargeNumber
calculation *= (4 / 2) + 20 - 10
calculation = calculation % 33
print(calculation)

// Numeric type conversion
let x1 = 3
let x2 = 0.411
let x3 = Double(x1) + x2
print(x3)



// Logical and Comparison operators
// == != > >= < <= && || !



if x2 >= x3 {
    print("x1 >= x3")
} else if x2 == 3 {
    print("x1 == x2")
} else {
    print("else case")
}

let isPluggedIn = false
let hasBatteryPower = true

if isPluggedIn || hasBatteryPower {
    print("You can use your laptop")
} else {
    print("😱")
}



// Switch statement



let numberOfWheels = 3
switch numberOfWheels {
case 0:
    print("Missing something?")
case 2:
    print("Bicycle?")
case 3...8:
    print("So many wheels")
default:
    print("Another vehicle")
}



// Ternary conditional operator



var x4 = 10
let largest = 100 > x4 ? "larger" : "smaller"
print(largest)
let largest2 = max(100, x4)
print(largest2)



// Multiline strings



var longText = """
    Q: Hello?
    A: "Hi"
"""
print(longText)

// Escaping characters in single quoted strings
let escapingCharacters = "\"Hey\""
print(escapingCharacters)

// Boolean property:
if !escapingCharacters.isEmpty {
    print("The string is not empty")
}

// Use type annotation for characters
let aString = "a"
let aCharacter: Character = "a"

// String concatenation and interpolation
let s1 = "Hi"
let s2 = " world"
let s1s2 = s1 + s2
print(s1s2)

var concatWithOperator = "a"
concatWithOperator += "b"
print(concatWithOperator)

print("Using interpolation: \(s1) ->\(s2)")



// String equality and comparison



if s1 != s2 {
    print("Strings are not the same")
}

let s3 = "AAAA"
let s4 = "aaaa"

if s3.lowercased() == s4.lowercased() {
    print("These are the same after lowercased")
}

let s5 = "abcFDA"
print("hasPrefix: \(s5.hasPrefix("abc"))")
print("hasSuffix: \(s5.hasSuffix("FDA"))")
print("contains: \(s5.contains("FDA"))")
print("count: \(s5.count)")



// Pattern match with multiple values of strings



let characterPattern: Character = "e"
switch characterPattern {
case "a", "e", "i", "o", "u":
    print("\(characterPattern) is a vowel")
default:
    print("\(characterPattern) is not a vowel")
}



// Unicode



let cow = "🐮"
let credentials = "résumé"
print("Unicode character have the character count you expected even though they are composed of multiple extended grapheme clusters: count will give one.\n\(cow).count = \(cow.count)")
print("\(credentials).count = \(credentials.count)")



// Functions



func thisIsAFunction() {
    print("thisIsAFunction")
}
thisIsAFunction()

func thisIsAFunctionWithParameters(value: Int) {
    print("thisIsAFunctionWithParameters: \(value)")
}
thisIsAFunctionWithParameters(value: 10) // the argument label (value) is required in this case.

func sayHello(to: String, and: String) {
    print("Hello \(to) and \(and)")
}
sayHello(to: "Patricia", and: "Tó")

// You can have the parameter have a different name different from the label that is used to call it.
func sayHello2(to person: String, and anotherPerson: String) {
    print("Hello \(person) and \(anotherPerson)")
}
sayHello2(to: "Patricia", and: "Tó")

// You can omit the argument label by using _
func add(_ firstNumber: Int, to secondNumber: Int) -> Int {
    return firstNumber + secondNumber
}

let addResult = add(10, to: 40)
print(addResult)

// Default parameter values
func displayScore(teamName: String, score: Int = 0) {
    print("\(teamName): \(score)")
}

displayScore(teamName: "Benfica")
displayScore(teamName: "Benfica", score: 20)

// Return values
func multiply(firstNumber: Int) -> Int {
    return firstNumber * 200
}
print("multiply result: \(multiply(firstNumber: 100))")

// You can omit the return keyword
func multiply2(firstNumber: Int) -> Int {
    firstNumber * 200
}



// Structs



struct Person {
    var name: String
}

let p1 = Person(name: "Jas")
print(p1.name)

// Structs can have methods

struct Person2 {
    var name: String
    func sayHello() {
        print("Hello \(name)")
    }
}

let p2 = Person2(name: "Anto")
p2.sayHello()


enum Size {
    case m
    case xl
}

struct Shirt {
    var size: Size
    var model: String
}

let shirt = Shirt(size: .m, model: "Model 1")
let shirt2 = Shirt(size: .xl, model: "Model 2")
print(shirt)
print(shirt2)

// Initializers
// All types have an initializer. Instances created from the default initializer use the type default value.
var s6 = String.init()
var i1 = Int.init()
var b1 = Bool.init()
print("|\(s6)|\(i1)|\(b1)|")

// There's a shorthand for the default initializer
var s7 = String()
var i2 = Int()
var b2 = Bool()

// Default values in structs

struct Odometer {
    var count: Int = 10
}
let odometer = Odometer()
print("odometer: \(odometer.count)")
let odometer2 = Odometer(count: 40)
print("odometer2: \(odometer2.count)")

// Custom initializers
struct Temperature {
    var celsius: Double
    init(celsius: Double) {
        self.celsius = celsius
    }
    
    init(fahrenheit: Double) {
        celsius = (fahrenheit - 32) / 1.8
    }
}

let currentTemperature = Temperature(celsius: 18.5)
let boiling = Temperature(fahrenheit: 212.0)
print(currentTemperature.celsius)
print(boiling.celsius)

// Instance methods
struct Size2 {
    var w: Double
    var h: Double
    
    func area() -> Double {
        w * h
    }
}
let size = Size2(w: 10.1, h: 20.5)
let area = size.area()



// Mutating methods



struct Odometer2 {
    var count: Int = 0
    
    mutating func increment() {
        count += 1
    }
}
var o1 = Odometer2()
o1.increment()
print(o1.count)



// Computed properties



struct Temp1 {
    var celsius: Double
    
    var fahrenheit: Double {
        celsius * 1.8 + 32
    }
    
    var kelvin: Double {
        celsius + 273.15
    }
}

let temp1 = Temp1(celsius: 0.0)
print(temp1.fahrenheit)
print(temp1.kelvin)



// Property observers



struct StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

var sc = StepCounter()
sc.totalSteps = 40
sc.totalSteps = 100



// Type properties and methods



struct Temp2 {
    static var boilingPoint = 100
    static func myName() -> String {
        "Temp2"
    }
}

let bp = Temp2.boilingPoint
let n1 = Temp2.myName()
let smallerNumber = Double.minimum(100.0, -1000.0)
print(smallerNumber)



// Copying



// Assigning a struct to a variable or passing an instance as a parameter into a function makes a copy by default
var someSize = Size2(w: 10, h: 10)
var anotherSize = someSize
someSize.h = 30
print("some \(someSize.h)")
print("another \(anotherSize.h)")



// Self



// note: self is optional
struct Car {
    var color: String
    
    var description: String {
        return "This is \(self.color) car."
    }
    
    init(color: String) {
        self.color = color
    }
}

print(Car(color: "Red").description)

// Variable properties
// Even though struct members are declared as var, if they are instanciated with let they are immutable (but don't forget about mutating func's).



// Classes and Inheritance



class Person3 {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func sayHello() {
        print("Hello there")
    }
}

let p3 = Person3(name: "Jasmine")
print(p3.name)
p3.sayHello()

// The biggest difference between structures and classes is that classes can have hierarchical relationships

class Vehicle {
    var currentSpeed = 0.0
    
    var description: String {
        "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // Do nothing
    }
}

let v1 = Vehicle()
print("v1: \(v1.description)")

class Bicycle: Vehicle {
    var hasBasket = false
    
    override func makeNoise() {
        print("A bicycle doesn't make much noise")
    }
}

let b3 = Bicycle()
b3.currentSpeed = 15.0 // Note that you can modify this member. members are mutable internally (which doesn't happen with structs)
print("b3: \(b3.description)")
b3.makeNoise()

// you can also override properties when there's a getter/computed property
class SportsCar: Vehicle {
    var gear = 1
    override var description: String {
        "This is a really fast car: \(currentSpeed)"
    }
}

// initializers can also be overridden
class Subject {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Student: Subject {
    var favoriteSubject: String
    
    init(name: String, favoriteSubject: String) {
        self.favoriteSubject = favoriteSubject
        super.init(name: name)
    }
}

let s10 = Student(name: "Yag", favoriteSubject: "Math")



// References



// classes have the ability to references values assined to constants or variables.
// Contrary to structs where a copy is made, when you assign a class instance to multiple variables, each variable will reference, or point to, the same address in memory.
let s11 = Student(name: "Fae", favoriteSubject: "Geology")
let s12 = s11
s12.favoriteSubject = "Math"
print(s11.favoriteSubject)
print(s12.favoriteSubject)



// Collections



var arr0: [String] = ["Geq", "Teq"]
var arr1 = ["Tammy", "Cole"]
arr1.removeFirst()
print(arr1)

// There might situations where you want to specify the array type even though the type inference takes care of it.
// for example if you want a collection of 8 bit integers (-127 to 128 range)
var arr3: [Int8] = [1, -3, 50, 72, -95, 115]

let arr4 = [4, 5, 6]
if arr4.contains(5) {
    print("There is a 5")
}

// There other ways to declare the array type
var arr5: [Int] = []
var arr6: Array<Int> = []
var arr7 = [Int]()

// Working with arrays

// Using an initializer to create an array with 100 zeros
var arr8 = [Int](repeating: 0, count: 100)

if (!arr8.isEmpty) {
    print("The array is not empty. First value is \(arr8[0])")
    arr8[0] = 1000
    print("First value is now \(arr8[0])")
}

var arr9 = ["Afe"]
arr9.append("Joe")
arr9 += ["Fae", "Simon"]
arr9.insert("Ed", at: 0) // Insert at the beginning
print(arr9)
let aName1 = arr9.remove(at: 2)
let aName2 = arr9.removeLast()
arr9.removeAll()
print("\(aName1) \(aName2) \(arr9)")

let arr10 = [1, 2, 3]
let arr11 = [4, 5, 6]
let containerArray = [arr10, arr11]
let firstArray = containerArray[0]
let firstElement = containerArray[0][0]



// Dictionaries



var scores = ["Cheryl": 500, "Luke": 100, "Big Luke": 500]
// Empty dictionaries:
var dict1 = [String: Int]()
var dict2 = Dictionary<String, Int>()
var dict3: [String: Int] = [:]

scores["Oli"] = 399
scores["Oli"] = 400

let oldValues = scores.updateValue(5, forKey: "Luke")

// if-let syntax lets you run code if a value returned from the method.
if let oldValue = scores.updateValue(100, forKey: "Oli") {
    print("Oli old value was \(oldValue)")
}

// To remove a value you can set the value to nil or use removeValue()
scores["Oli"] = nil
if let removedValue = scores.removeValue(forKey: "Luke") {
    print("Luke's score was \(removedValue) before he stopped playing")
}
print(scores)

// You can convert the keys or values into arrays
let players = Array(scores.keys)
let points = Array(scores.values)

// To look up a particular value within a dictionary, use the if-let syntax

if let lukeScore = scores["Luke"] {
    print("Luke's score will not be shown because it isn't in the dictionary: \(lukeScore)")
}

if let cherylScore = scores["Cheryl"] {
    print("Cheryl's score: \(cherylScore)")
}



// Loops



for index in 1...5 {
    print("closed range operator: \(index)")
}

for index in 1..<5 {
    print("half-open range operator: \(index)")
}

for _ in 1...3 {
    print("Hello")
}

let names1 = ["Simon", "Fae", "Makoto"]
for name in names1 {
    print("Hello \(name)")
}

// String is a collection type
for letter in "ABCD" {
    print("Letter: \(letter)")
}

for (index, letter) in "ABCD".enumerated() {
    print("\(index): \(letter)")
}

for index in 0..<names1.count {
    print("\(index): \(names1[index])")
}

// for-in generates a tuple for dictionaries. The loop doesn't guarantee the order of the items in this case.

let vehicles = ["unicycle": 1, "bicycle": 2, "tricycle": 3, "quad bike": 4]
for (vehicleName, wheelCount) in vehicles {
    print("A \(vehicleName) has \(wheelCount) wheels")
}



// While loops



var numberOfLives = 3
var stillAlive = true

while stillAlive {
    numberOfLives -= 1
    if numberOfLives == 0 {
        stillAlive = false
        print("Not alive")
    }
}



// Repeat-while loops
// Similar to while but executes the block once before checking the condition



var steps = 0
let wall = 2
repeat {
    print("Step")
    
    steps += 1
    
    if steps == wall {
        print("You've hit a wall")
        break
    }
} while steps < 10

struct P3 {
    var age = 0
}

let people = [P3(age: 10), P3(age: 17), P3(age: 21), P3(age: 41)]
for person in people {
    if person.age < 18 {
        continue
    }
    print(person)
}



// Optionals



struct Book {
    var name: String
    var publicationYear: Int?
}

let book1 = Book(name: "Ere", publicationYear: nil)
let book2 = Book(name: "Fav", publicationYear: 1900)

var serverResponseCode: Int? = nil

// force-unwrap operator !
if serverResponseCode != nil {
    let actualResponse = serverResponseCode!
    print(actualResponse)
}

if let actualResponse = serverResponseCode {
    print(actualResponse) // Already unwrapped
}



// Functions and Optionals



let s20 = "123"
let possibleNumber = Int(s20)
if let number = possibleNumber {
    print(number)
}

func formattedText(url: String) -> String? {
    if url.count < 10 {
        return nil
    }
    return "heyy \(url)"
}

if let formattedText = formattedText(url: "") {
    print(formattedText)
}



// Failable Initializers



struct Toddler {
    var name: String
    var monthsOld: Int
    
    init?(name: String, monthsOld: Int) {
        if monthsOld <= 12 || monthsOld > 36 {
            return nil
        } else {
            self.name = name
            self.monthsOld = monthsOld
        }
    }
}

let toddler = Toddler(name: "Afe", monthsOld: 8)
if let myToddler = toddler {
    print("\(myToddler.name) -> \(myToddler.monthsOld)")
} else {
    print("Invalid age")
}



// Optional Chaining



struct Person5 {
    var age: Int
    var residence: Residence?
}

struct Residence {
    var address: Address?
}

struct Address {
    var buildingNumber: String
    var streetName: String
    var apartmentNumber: String?
}

let a10 = Person5(age: 10, residence: Residence(address: Address(buildingNumber: "A", streetName: "Foe", apartmentNumber: nil)))

if let theApartmentNumber = a10.residence?.address?.apartmentNumber {
    print("Apartment number: \(theApartmentNumber)")
} else {
    print("No apartment number")
}



// Implicitly Unwrapped Optionals
// To initialize a value later use ! (similar to kotlin lateinit)



var label: String!
// label.count // runtime error
label = "This will be still an optional but it will automatically unwrapped when accessed"
print(String(label))
print(label.lowercased())

class Test1 {
    var content: String
    init(content: String) {
        self.content = content
    }
}

var t1: Test1!
t1 = Test1(content: "Hey")
print(t1.content)



// Type casting and inspection



class Animal {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Dog: Animal {
    func waggle() {
        print("Waggling my tail")
    }
}

class Cat: Animal {
}

class Bird: Animal {
}

func getAllAnimals() -> [Animal] {
    return [Dog(name: "Bud"), Cat(name: "Elf"), Bird(name: "Archie")]
}

func walk(dog: Dog) {
    print("Walk \(dog.name)")
}

func petCat(cat: Cat) {
    print("Pet \(cat.name)")
}

func singWith(bird: Bird) {
    print("Sing with \(bird.name)")
}

let pets = getAllAnimals()

// Use as? to try to downcast the value to a more specific type
for pet in pets {
    if let dog = pet as? Dog {
        walk(dog: dog)
    } else if let cat = pet as? Cat {
        petCat(cat: cat)
    } else if let bird = pet as? Bird {
        singWith(bird: bird)
    }
}

// Use the forced form of the type cast operator as! to downcast to a specific type. If the type is incorrect the program will crash.
let alansDog = pets.first(where: {$0.name == "Bud"}) as! Dog
alansDog.waggle()



// Any - nonspecific types



// Any represents an instance of any type.
// AnyObject represents an instance of any class but not a structure
var items: [Any] = [5, "Bill", 6.7, true]
if let firstItem = items[0] as? Int {
    print(firstItem + 5)
}


// Guard



// Use guard to better manage control flow.
// It can be used to get around nested if statements and simplify early return style if statements.

func singHappyBirthday0(birthDayIsToday: Bool, invitedGuests: [String]) {
    if !birthDayIsToday {
        print("No birthday today")
        return
    }
    
    if invitedGuests.isEmpty {
        print("No guests")
        return
    }
    
    print("Happy birthday")
}

func singHappyBirthday1(birthDayIsToday: Bool, invitedGuests: [String]) {
    guard birthDayIsToday else {
        print("No birthday today")
        return
    }
    
    guard !invitedGuests.isEmpty else {
        print("No guests")
        return
    }
    
    print("Happy birthday")
}



// Guard with optionals
// 'guard let' makes all unwrapped values available throughout the rest of the function instead of the within control flow braces


class Goose {
    var eggs: Int?
    init(eggs: Int?) {
        self.eggs = eggs
    }
}

func eggTest() {
    let goose = Goose(eggs: 10)
    guard let eggs = goose.eggs else { return }
    // eggs is accessible hereafter
    print("The goose laid \(eggs) eggs")
}

eggTest()

func processBook(title: String?, price: Double?, pages: Int?) {
    if let theTitle = title,
       let thePrice = price,
       let thePages = pages {
        print("\(theTitle) \(thePrice) \(thePages)")
    }
}

func processBook2(title: String?, price: Double?, pages: Int?) {
    guard let theTitle = title,
       let thePrice = price,
       let thePages = pages else {
        return
    }
    print("\(theTitle) \(thePrice) \(thePages)")
}



// Constant and Variable Scope



// You can use the 'if let' syntax and just reuse the original name within the scope of 'if let'
// Shadowing the optional with the unwrapped value is common in Swift code.
var name1: String? = "Brady"
if let name1 = name1 {
    print("My name is \(name1)")
}

func exclaim(name: String?) {
    guard let name = name else {
        return
    }
    
    print("Exclaim \(name)")
}

exclaim(name: "Hello")



// Enumerations



enum CompassPoint0 {
    case north
    case east
    case south
    case west
}

enum CompassPoint {
    case north, east, south, west
}

var compassHeading = CompassPoint.east
compassHeading = .west
var compassHeading2: CompassPoint = .west
compassHeading2 = .north

switch compassHeading {
case .north:
    print("Going north")
case .east:
    print("Going east")
case .south:
    print("Going south")
case .west:
    print("Going west")
}

enum AnimalType: Character {
 case dog = "🐶", cat = "🐱"
    
    var definition: String {
        switch self {
        case .dog:
            return "What's up dog"
        default:
            return "Other animal"
        }
    }
}

if compassHeading == .west {
    print("I am heading west")
}

enum Genre {
    case animated, action, romance, documentary, biography, thriller
}

struct Movie {
    var name: String
    var releaseYear: Int?
    var genre: Genre
}

let movie = Movie(name: "Finding Dory", releaseYear: 2016, genre: .animated)
