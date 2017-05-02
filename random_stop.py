import random
import sys

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

if len(sys.argv)<2:
    exit(1)

if not is_number(sys.argv[1]):
    exit(1)

mycutoff = float(sys.argv[1])

if mycutoff>100 or mycutoff<0:
    exit(1)

myrandom = random.uniform(0,100)

if myrandom>mycutoff:
    exit(1)

