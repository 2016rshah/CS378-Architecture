#!/bin/bash

# Check that we are logged into streetpizza
HOST="$(hostname)"
if [ "${HOST}" != "streetpizza" ]; then
    echo "You must be logged into streetpizza.cs.utexas.edu for this script to work!"
    echo "First, ssh utcsid@streetpizza.cs.utexas.edu, then run the script."
    exit
fi

# Check that args are correct
if [ "$#" -ne 1 ]; then
    echo "Incorrect # of arguments: expected a python program"
    echo "Usage: ./run_cluster.sh name_of_program.py"
    exit
fi

PROGRAM=$1

# Make sure program exists
if test ! -f ${PROGRAM}; then
    echo "${PROGRAM} does not exist!"
    echo "Usage: ./run_cluster.sh name_of_program.py"
    exit
fi

PROGRAM=$(echo "${PROGRAM}" | cut -d'.' -f 1)
PY_DIR=$(pwd)

OUTPUT_DIR="${PY_DIR}/output/${PROGRAM}"
CONDOR_DIR="${PY_DIR}/output/${PROGRAM}"

# Ensure output dir exists
if test ! -d ${OUTPUT_DIR}; then
    mkdir ${OUTPUT_DIR}
fi

USER=$(whoami)

while read line ;
do
    BENCHMARK=$line
    SCRIPT_FILE="${CONDOR_DIR}/${BENCHMARK}.sh"
    CONDOR_FILE="${CONDOR_DIR}/${BENCHMARK}.condor"
    OUTPUT_FILE="${OUTPUT_DIR}/${BENCHMARK}.txt"
    
    # create script file
    echo "#!/bin/bash" > $SCRIPT_FILE
    echo "export LD_LIBRARY_PATH=\"/u/${USER}:\$LD_LIBRARY_PATH\"" >> $SCRIPT_FILE
    echo "python3 $PY_DIR/${PROGRAM}.py /u/matthewp/traces/branches/${BENCHMARK}.txt > $OUTPUT_FILE" >> $SCRIPT_FILE
    chmod +x $SCRIPT_FILE
    
    # create condor file
    /u/matthewp/research/scripts/condorize.sh false $CONDOR_DIR $BENCHMARK

    # submit the condor file
    /lusr/opt/condor/bin/condor_submit $CONDOR_FILE
done < traces.txt
