'''
There's no need to add the function at the beginning of the program, just put a 'main' function at the beggining thena 'hello' function.
Then at the end, call the 'main' function
'''
def main():
    name = input("What's you name? ")
    hello(name)
    hello()

def hello(to="World"):
    print(f"Hello, {to}!")

main()
