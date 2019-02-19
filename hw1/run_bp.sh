#!/bin/bash
TRACE_DIR="/u/matthewp/traces"
WARM_INS=1
SIM_INS=50
BRANCH=${1}

# Build the executable (with no prefetchers, LRU replacement, 1 core)
./build_champsim.sh ${BRANCH} no no lru 1

BINARY="bin/${BRANCH}-no-no-lru-1core"

# Run our branch predictor on each trace
while read TRACE; do
    echo "Running ${BRANCH} on ${TRACE} ..."
    (${BINARY} -warmup_instructions ${WARM_INS}000000 -simulation_instructions ${SIM_INS}000000 -hide_heartbeat -traces ${TRACE_DIR}/${TRACE}.trace.gz) &> output/${TRACE}.txt
done < sim_list/traces.txt

# Print the results
echo ""
./print_results.py

