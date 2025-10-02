'''
To create a function, 'def' is used.
'''

def hello():
    print("Hello")

name = input("What's your name? ")
hello()
print(name)


'''
Can also add parameters to the functions
'''

def hello(to):
    print(f"Hello, {to}!")

name = input("What's your name? ")
hello(name)

'''
Can also add a default value to the parameters
'''

def hello(to="World"):
    print(f"Hello, {to}!")

name = input("What's your name? ")
hello(name)
hello()
