'''
In python, strings are represented as 'str'
'''
'''
    The 'input' function takes a prompt as an argument
    The '=' is used to assign what is on the right to what's on the left
    The '#' is used to make comments, usually used to say what the program is doing
'''

# Ask the user for their name
name = input("What's your name? ")

'''
    There's many ways to use the 'print' function and print the 'name'
'''

# Print Hello
print("Hello,")

# Print name inputted
print(name)

'''
The 'print' function can also take many arguments
The '+' is used to concatenate or add toghether arguments as one
The ',' is used to pass multimple arguments
'''

# Print output
print("Hello, " + name)

# Print output
print("Hello,", name)

'''
On the 'print' function documentation, some of it's default argument is "end='\n'" to automatically create a new line. 
To make it do another behavior, change the 'end' argument
'''

# Print output
print("Hello, ", end="")
print(name)

'''
For quotation marks, if its needed to use ' "" ' inside a ' "" ' or ' '' ' inside a ' '' ' when putting the argument, use '\' word \' ' to let it know that it's used as part of the string, avoiding errors
'''

# Print output
print("Hello, \"World\"!")

'''
If wanting 'name' to be inside the string argument, use special indicator 'f' before indicating the string and for the name put '{name}' where the name must be shown inside the ' "" '.
'''

# Print output
print(f"Hello, {name}")


'''
The 'strip' method is used to remove whitespaces on the left and/or right of a string like ' Name ' make it 'Name'
'''

# Ask user to add whitespace
name = input("Add name with left and/or right whitespace. ")

# Remove whitespace
name = name.strip()

# Print output
print(f"Hello, {name}")

'''
To make sure that the first letter of every word is capitalized, even if the user didn't, use the 'title' method.
'''

# Ask for name
name = input("Add name as before, but now with lower case only ")
# Remove whitespaces
name = name.strip()
# Capitalize first letter of the word
name = name.title()
# Print output
print(f"Hello, {name}")

'''
Can also add multiple methods when assigning values
'''

#Ask for name
name = input("Add name as before")
# Remove whitespaces from string and capitalize first letter of each word
name = name.strip().title()
# Print output
print(f"Hello, {name}")
