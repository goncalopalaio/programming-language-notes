say 'Hello';

'another way'.say;

say "Hello" if True;
say "World" if False;

say "# Blocks are collections of statements";

{
    say "1st";
    say "2nd";
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
