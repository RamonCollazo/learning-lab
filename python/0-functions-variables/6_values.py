'''
If you want values of a function to be returned to another part of the program, use 'return'. This is also called "passing back".
'''
def main():
    x = int(input("What number you want to know it's square? "))
    print(f"The square of {x} is", square(x))

def square(n):
    return n * n

main()
