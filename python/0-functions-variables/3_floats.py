'''
Floats are numbers with decimal points
'''
x = float(input("What's x? "))
y = float(input("What's y? "))

print (x + y)

'''
Can also use 'round' function for rounding to the nearest integer point.
'''
x = float(input("What's x? "))
y = float(input("What's y? "))

z = round(x + y)
print(z)

'''
If wanting the value to print a ',' if it's equal or bigger than 1,000 the 'f' indicator on the 'print' function can be used
'''
x = float(input("Make x bigger than 1,000 "))
y = float(input("Make y bigger than 1,000 "))
z = round(x + y)

print(f"{z:,}")

'''
The 'round' function takes arguments 'round(number[, ndigits])', square brackets indicating that the argument it's optional. Helpfull to modify where to round
'''

x = float(input("Make x be 2 "))
y = float(input("Make y be 3 "))
z = round(x / y, 2)
print(z)

'''
If not wanting to round the value but wanting to round when printing it, the 'f' indicator can be used.  
'''
x = float(input("Make x be 2 again "))
y = float(input("Make y be 3 again "))
z = x / y

print(f"{z:.2f}")


