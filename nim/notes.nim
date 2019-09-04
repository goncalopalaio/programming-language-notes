import strutils


#[ 
Multiline comment

  https://nim-by-example.github.io/for_iterators/


  How to run:
  nim c -r --verbosity:0 notes.nim

 ]#
echo "Hello World"

proc get_alphabet(): string = 
  var acc = ""
  for l in 'a'..'z':
    acc.add(l)
  return acc

# computed at compile time
const alphabet = get_alphabet()
echo alphabet

proc mutable_variables_example() = 

  var a = "foo"
  var b = 0

  var 
    c = 10.0
    d = 20.0

mutable_variables_example()

proc immutable_variables_example() = 
  let d = "bar"
  let e = 5

immutable_variables_example()

proc changing_mutable_variables_example() = 
  var 
    a = "foo"
    b = 5.0

  a.add("bar")
  b += 1.0

  echo a
  echo b

changing_mutable_variables_example()

proc using_result_for_return_example(): string = 
  # result is a special variable that is returned
  # it's declared automatically if the procedure has an automatic return type
  result = ""
  for l in 'b'..'g':
    result.add(l)

proc getting_result() = 
  let return_value = using_result_for_return_example()
  echo return_value

getting_result()

proc control_flow_example() = 
  let answer = 1

  echo "Write the number one"

  while true:
    #let guess = parseInt(stdin.readLine)
    let guess = 1
    echo "Your guess was: "
    echo guess

    if guess < 1:
      echo "Lower than 1"
    elif guess > 1:
      echo "Higher than 1"
    else:
      echo "Just right"
      break

  # block statement can be created to break out of nested loops
  block busyloops:
    while true:
      while true:
        break busyloops

  # case statements must cover all cases
  let name = "charlie"
  case name:
    of "alpha":
      echo "A"
    of "bravo":
      echo "B"
    of "charlie":
      echo "C"
    else:
      echo "Unrecognized letter"

  let letter = 'a'
  case letter: 
  of 'a', 'e', 'i', 'o', 'u':
    echo "Vowel"
  of '\127'..'\255':
    echo "Unknown"
  else:
    echo "Consonant"

  # the result can be returned directly from the case
  let num = -1000
  let res = case num:
    of low(int).. -1:
      "negative"
    of 0:
      "zero"
    of 1..high(int):
      "positive"
    else:
      "impossible"

  echo "res"
  echo res

control_flow_example()