#!/bin/bash
export LD_LIBRARY_PATH="/u/rshah:$LD_LIBRARY_PATH"
python3 /u/rshah/github/CS378-Architecture/hw3/1_64.py /u/matthewp/traces/branches/perlbench_53B.txt > /u/rshah/github/CS378-Architecture/hw3/output/1_64/perlbench_53B.txt
