#!/usr/bin/python3
import sys

if len(sys.argv) < 2:
    print('Need to specify a cache replacement policy!')
    print('Example usage: ./print_results.py my_policy')
    sys.exit(0)

policy = sys.argv[1]

print('Replacement Policy Performance')
print('(IPC, MPKI, name of benchmark)')
print('------------------------------')
mpki_list = []
ipc_list = []
trace_list = open('sim_list/traces.txt', 'r')
for trace in trace_list:
    trace = trace[:-1]
    trace_output = open('output/'+policy+'/'+trace+'.txt', 'r')
    for line in trace_output:
        if line.startswith('LLC TOTAL'):
            mpki = float(line.split()[7])/100000.0
            mpki_list.append(mpki)
            print('%.1f %s' % (mpki, trace))
        elif line.startswith('CPU 0 cumulative IPC'):
            ipc = float(line.split()[4])
            ipc_list.append(ipc)
            print('%.3f' % (ipc), end=' ')

avg_mpki = sum(mpki_list)/len(mpki_list)
avg_ipc = sum(ipc_list)/len(ipc_list)
print('%.3f %.1f Average' % (avg_ipc, avg_mpki))

