#!/usr/bin/python3

print('Branch Predictor Performance')
print('(accuracy, MPKI, IPC, name of benchmark)')
print('----------------------------------------')
accuracy_list = []
mpki_list = []
ipc_list = []
trace_list = open('sim_list/traces.txt', 'r')
for trace in trace_list:
    trace = trace[:-1]
    trace_output = open('output/'+trace+'.txt', 'r')
    for line in trace_output:
        if line.startswith('CPU 0 Branch Prediction Accuracy'):
            accuracy = float(line.split()[5][:-1])
            accuracy_list.append(accuracy)
            mpki = float(line.split()[7])
            mpki_list.append(mpki)
            print('%.1f %.1f' % (accuracy, mpki) , end=' ')
        elif line.startswith('CPU 0 cumulative IPC'):
            ipc = float(line.split()[4])
            ipc_list.append(ipc)
            print('%.3f %s' % (ipc, trace))

avg_accuracy = sum(accuracy_list)/len(accuracy_list)
avg_mpki = sum(mpki_list)/len(mpki_list)
avg_ipc = sum(ipc_list)/len(ipc_list)
print('%.1f %.1f %.3f Average' % (avg_accuracy, avg_mpki, avg_ipc))

