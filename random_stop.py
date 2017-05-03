import random
import sys

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

if len(sys.argv)<2:
    sys.stderr.write('no arguments passed to random_stop.py\n')
    exit(1)

if not is_number(sys.argv[1]):
    sys.stderr.write('argument passed to random_stop.py is not a number\n')
    exit(1)

mycutoff = float(sys.argv[1])

if mycutoff>100 or mycutoff<0:
    sys.stderr.write('argument passed to random_stop.py is not a number in range [0,100]\n')
    exit(1)

myrandom = random.uniform(0,100)

if myrandom>mycutoff:
    sys.stderr.write('random_stop.py filtered process out\n')
    exit(1)

