say 'Hello';

'another way'.say;

say "Hello" if True;
say "World" if False;

say "# Blocks are collections of statements";

{
    say "1st";
    say "2nd";
    print "h";
    print "i";
    print "!\n";
}

# Expressions
# -> Terms
#   Variables
#   Literals
# -> Operators
#   Prefix          - Before the term                   ++1
#   Infix           - Between terms                     1+2
#   Postfix         - After the term                    1++
#   Circumfix       - Around the term                   (1)
#   Postcircumfix   - After one term, around another    Array[1]

say #`(This is an embedded comment) "Hello World";

=begin comment
This is a multiline comment
Thing 1
Thing 2
=end comment

# Strings need to be delimited by either double or single quotes
# Use double quotes when you need to use ' or an interpolated variable

say "Hello, isn't this lovely";
my $name = 'John Doe';
say 'hello $name'; # no interpolation
say "hello $name"; # this will work

say "# Common operators";

say 1 + 2;
say 1 - 2;
say 1 * 2;
say 2 ** 2;

say 3 / 2;
say 3 div 2;

say 7 % 4;
say 7 %% 4;

say 6 gcd 9;
say 6 lcm 9;

say 6 == 9;
say 6 != 9;

say 6 < 9;
say 6 > 9;
say 6 <= 9;
say 6 >= 9;

say "# Numeric three-way comparator";
say 1 <=> 1.0; 
say 1 <=> 2;
say 3 <=> 2;

say "John" eq "John";
say "John" ne "John";

say "a" lt "b";
say "a" gt "b";
say "a" le "b";
say "a" ge "b";

say "# String three-way comparator";
say "a" leg "a";
say "a" leg "b";
say "c" leg "b";

say "# Smart three-way comparator";
say "a" cmp "b";
say 3.5 cmp 2.6;

say "# Assignment is an infix operator";
my $var = 7;

say "# String concatenation";
say "hey " ~ 9 ~ 7;

say "# String replication";
say 13 x 3;
say "Hello" x 3;

say "# Smart match";
say 2 ~~ 2; # True
say 2 ~~ Int; # 2 is an Int
say "Raku" ~~ "Raku";
say "Raku" ~~ Str;
say "enlightenment" ~~ /light/; # ｢light｣

say "# Increment";
my $var1 = 2; ++$var1;
say $var1; # This is now 3

my $var2 = 2; $var2++;
say $var2; # This is now 3

say "# Coerce the operand to a numeric value";
say +"3";
say +True;

say "# Coerce the operand to a numeric value and return the negation";
say -"3"; # -3
say -True; # -1
say -False; # 0

say "# Coerce the operand to a boolean value";
say ?0; # False
say ?9.8; # True
say ?"Hello"; # True
say ?""; # False
my $var3; say ?$var3; # False
my $var4 = 7; say ?$var4; # True

say "# Coerce the operand to a boolean value and return the negation";
say !4; # False

say "# Range constructors";
say 0..5; # [0, 5]
say 1..^5; # [1, 5)
say 1^..5; # (1, 5]
say 1^..^5; # (1, 5)

say ^5; # Same as 0..^5;

say "# Lazy list constructor";
say 0...999; # Returns the elements only if requested

say "# Flattening";
say |(0..5); # (0 1 2 3 4 5)
say |(0^..^5); # (1 2 3 4)

say "# Reversed operators";
# Adding an R before any operator will have the effect of reversing its operands
say 2 / 3; # 0.666667
say 2 R/ 3; # 1.5

say 2 - 1; # 1
say 2 R- 1; # -1

say 6 Rgcd 9;
# say "Hello " Rx 3; # Doesn't work
say 13 x 3;
say 13 Rx 3;

say 3 R<=> 2;

say "# Variables";
# 3 Categories: Scalars, Arrays and Hashes
# A sigil is a character that is used as a prefix to categorize variables
# $ for scalars
# @ for arrays
# % for hashes

# A scalar holds one value or reference
{
    my $name = "John Doe";
    say $name;

    my $age = 99;
    say $age;
}
{
    # https://docs.raku.org/type/Str

    my $name = "John Doe";

    say $name.uc; # Uppercase
    say uc $name;

    say $name.chars; # Number of chars
    say $name.flip; # Reverse string
}

{
    # https://docs.raku.org/type/Int
    # https://docs.raku.org/type/Rat (Rational numbers)

    my $age = 2.3;
    say $age.numerator; # 23
    say $age.denominator; # 10
    say $age.nude; # Returns a list of the numerator and denominator, (23 10)
}

say "# Arrays";
{
    # https://docs.raku.org/type/Array

    my @animals = "camel", "llama", "owl";
    say @animals;
}

{
    my @vegetables = "potato", "carrot", "onion";
    my $rock = "Marble";

    say @vegetables;
    say $rock;

    say "1 - " ~ @vegetables ~ " and $rock";
    say "2 - @vegetables and $rock";
    {
        my @vegetables = "potato", "carrot", "onion";
        my $rock = "Marble";
        my $thing = @vegetables;

        say "3 - " ~ $thing ~ " and $rock";
        say "4 - $thing and $rock";
        say "5 - $@vegetables and $rock";
    }
}

{
    my @animals = "camel", "llama", "owl";
    say "Contains " ~ @animals.elems ~ " animals";
    @animals.push("dog");

    say "-> " ~ @animals;
    @animals.pop;
    say "-> " ~ @animals;
    say "-> " ~ @animals.splice(1, 2); # Will remove b elements starting at position a

}

say "# Fixed size arrays";
{
    # https://docs.raku.org/type/Array

    my @array[3];
    @array[0] = "first";
    @array[1] = "second";
    @array[2] = "third";
    # @array[3] = "fourth"; # Out of range error
    @array.say;
}

say "# Multidimentional arrays";
{
    my @tbl[3; 2];
    @tbl[0; 0] = 1;
    @tbl[0; 1] = "x";
    @tbl[1; 0] = 2;
    @tbl[1; 1] = "y";
    @tbl[2; 0] = 3;
    @tbl[2; 1] = "z";
    @tbl.say;
}

say "# Hashes";
{
    # https://docs.raku.org/type/Hash
    my %capitals = "UK", "London", "Germany", "Berlin";
    %capitals.say;

    # Another way:
    {
        my %capitals1 = "UK" => "London", "Germany" => "Berlin";
        %capitals1.say;

        my %capitals2 = UK => "London", Germany => "Berlin";
        %capitals2.say;
    }
}

{
    my %capitals = UK => "London", Germany => "Berlin";
    %capitals.push: (France => "Paris");
    say %capitals.kv;
    %capitals.kv.say;
    %capitals.keys.say;
    %capitals.values.say;

    say "Capital of France: " ~ %capitals<France>;
}

say "# Types";
{
    # Raku is classified as gradually typed. It allows both static and dynamic typing
    {
        # Dynamic typing
        my $var = "Text";
        say $var;
        say $var.WHAT; # Returns type
        $var = 1234;
        say $var;
        say $var.WHAT;
    }
    {
        # Static typing
        my Int $var1 = 1234;
        say $var1;
        say $var1.WHAT;

        # my Int $var2 = "Text"; # This fails

        # Arrays and hashes can also be statically typed
        my Int @array = 1, 2, 3;
        say @array.WHAT;

        my Str @multilingual = "Hello","Salut","Hallo","您好","안녕하세요","こんにちは";
        say @multilingual.WHAT;

        my Str %capitals = UK => 'London', Germany => 'Berlin';
        say %capitals.WHAT;

        # Other commonly used types:
        # Mu - root of the Raku type hierarchy
        # Any - Default base class for new classes and for most built-in classes
        # Cool - Value that can be treated as a string or a number interchangeably
        my Cool $var = 31; say $var.flip; say $var * 2;
        # Str - String of characters
        # Int - Integer (arbitrary-precision)
        # Rat - Rational number (limited-precision)
        # Bool - Boolean
    }
}

say "# Introspection";
{
    my Int $var;
    say $var.WHAT;

    my $var2;
    say $var2.WHAT; # Any
    $var2 = True;
    say $var2.WHAT; # Boolean
    $var2 = Nil;
    say $var2.WHAT; # Any

}

say "# Assignment vs Binding";
{
    # https://docs.raku.org/language/variables

    # Assignment is done with the = operator
    # The value can be changed
    my Int $var = 123;
    $var = 999;
    say $var;

    # A value bound to a variable cannot be changed
    my Int $var2 := 1234;
    # $var = 999; # This fails
    say $var2;

    # Variables can also be bound to other variables
    my $a;
    my $b;
    $b := $a;
    $a = 7;
    say $a; # 7
    say $b; # 7
    $b = 8;
    say $a; # 8
    say $b; # 8
    # Binding variables is bi-directional - $a := $b and $b := $a have the same effect
}

say "# Functions and mutators";
{
    # Functions do not change the state of the object they were called on
    # Mutators modify the state of the object

    my @numbers = [1, 4, 2, 0];
    @numbers.push(99); # push is a mutator
    say @numbers;
    @numbers.sort; # sort is a function, it returns the sorted array but it doesn't modify the state of the initial array
    say @numbers;

    # To enforce a function to act as a mutator, .= is used instead of .
    @numbers.=sort;
    say @numbers;
}

say "# Loops and conditions";

{
    say "# if";

    my $age = 19;

    if $age > 18 {
        say "Welcome";
    }

    # You can also invert the body and condition
    say "Welcome" if $age > 18;

    my $number-of-seats = 9;
    if $number-of-seats <= 5 {
        say "I am a sedan";
    } elsif $number-of-seats <= 7 {
        say "I am a 7 seater";
    } else {
        say "I am a van"
    }

    say "# unless";

    my $clean-shoes = False;
    if not $clean-shoes { # Negation is done either with ! or not
        say "Clear your shoes"
    }

    unless $clean-shoes {
        say "Clean your shoes"
    }

    say "# with";
    # behaves like an if statement but checks if the variable is defined
    my Int $var = 1;
    with $var {
        say "Hello";
    }

    my $var0 = 1;
    my $var1;
    with $var1 {
        say "1 - Hello";
    } orwith $var0 {
        say "2 - Hi?";
    } else {
        say "3 - What?";
    }

    my Int $var2;
    with $var2 {
        say "Bye"; # This will not be called
    }

    say "# without";
    without $var2 {
        say "Hi!"; # without is the negated version of with
    }
}

{   
    # https://docs.raku.org/language/control

    say "# for";
    my @array = 1, 2, 3;
    for @array -> $array-item {
        say $array-item * 100;
    }

    say "# loop";
    loop (my $i = 0; $i < 5; $i++) {
        say "Number is $i";
    }

    say "# repeat while";
    my $x = -42;
    repeat {
        $x++;
    } while $x < 5;
    $x.say;

    repeat {
        $x++;
    } until $x >= 5;
    $x.say;

    until $x > 10 {
        say $x++;
    }
}

{
    say "# given";
    my $var = 42;

    given $var {
        when 0..50 { say "<= 50" } # Stops at first match
        when Int { say "It's an Int" }
        when 42 { say 42 }
        default { say "huh?" }
    }

    # proceed can be used to continue matching
    given $var {
        when 0..50 { say "<= 50"; proceed }
        when Int { say "It's an Int"; proceed }
        when 42 { say 42 }
        default { say "huh?" }
    }
}

say "# Basic I/O using the terminal";
{
    say "Hello";
    print "hi\n";

    # get is used to capture input from the terminal
    my $name;
    $name = "";
    # $name = get;
    $name.say;

    # prompt is a combination of print and get
    # $name = prompt "Hi, what's your name? ";
    say "Hi $name";
}

say "# Running shell commands";
{
    # run runs an external command without involving a shell
    # shel runs a command through the system shell.

    my $name = "Neo";
    run 'echo', "Hello $name";
    shell "ls";
}

say "# File I/O";
{
    # slurp to read data from a file
    my $data = slurp "README.md";
    say $data;

    # spurt to write data to a file
    my $newdata = "New scores:
    Potato 10
    Orange 10
    Carrot 20
    \n";
    spurt "example.txt", $newdata;
}

say "# Working with files and directories";
{
    # https://docs.raku.org/type/IO

    # Contents of a directory can be listed without resorting to shell command
    say dir;
    say dir "../";

    my $folder = "newfolder";
    my $file = "example.txt";
    my $moved-file = "$folder/$file";
    rmdir $folder;
    mkdir $folder;
    move $file, $moved-file;

    if $folder.IO.e {
        say "$folder exists";
    }

    say $folder.IO.f; # Checks if it's a file
    say $moved-file.IO.f;

    say $folder.IO.d; # Checks if it's a directory
    say $moved-file.IO.d;


}