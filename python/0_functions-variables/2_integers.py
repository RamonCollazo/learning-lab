'''
In Python, integers are reffered as 'int'

Use '+', '-', '*', '/', and '%' for math operations

No need to run a python code with a text editor, just type 'python' on the terminal to run code, so no need to use text editor to run '1 + 1'.
'''

# Declaring variables
x = 1
y = 2
# Adds x + y and the values it gives its z
z = x + y

# Print z value
print(z)

x = input("What's x? ")
y = input("What's y? ")
'''
Because the argument is given as a string, its needed to be changed ant an integer using 'int'
'''
z = int(x) + int(y)
z1 = x + y
print(z)
print(z1)

'''
Aslo, it's not necesarly to have the z variable in this case when only wanting to print the addition, but it wont save it to memory
'''
print(int(x) + int(y))
