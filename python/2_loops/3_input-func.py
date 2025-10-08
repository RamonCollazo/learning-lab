def main():
    number = get_number()
    woof(number)

def get_number():
    while True:
        n = int(input("What's the number? "))
        if n > 0:
            return n

def woof(n):
    for _ in range(n):
        print("woof")

main()
