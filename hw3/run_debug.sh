#!/bin/bash

# Check that we are logged into streetpizza
HOST="$(hostname)"
if [ "${HOST}" == "streetpizza" ]; then
    echo "You should not be logged into streetpizza.cs.utexas.edu when debugging!"
    echo "ssh into a different lab machine first"
    exit
fi

# Check that args are correct
if [ "$#" -ne 1 ]; then
    echo "Incorrect # of arguments: expected a python program"
    echo "Usage: ./run_debug.sh name_of_program.py"
    exit
fi

PROGRAM=$1

# Make sure program exists
if test ! -f ${PROGRAM}; then
    echo "${PROGRAM} does not exist!"
    echo "Usage: ./run_debug.sh name_of_program.py"
    exit
fi

# Run your program on astar
echo "Running ${PROGRAM} on astar_163B ..."
python3 ${PROGRAM} /u/matthewp/traces/branches/astar_163B.txt

