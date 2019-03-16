#!/bin/bash
export LD_LIBRARY_PATH="/u/rshah:$LD_LIBRARY_PATH"
python3 /u/rshah/github/CS378-Architecture/hw3/my_program.py /u/matthewp/traces/branches/bzip2_183B.txt > /u/rshah/github/CS378-Architecture/hw3/output/my_program/bzip2_183B.txt
