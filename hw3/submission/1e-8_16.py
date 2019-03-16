import sys
from sklearn.svm import LinearSVC
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_validate
from sklearn.model_selection import GridSearchCV

HISTORY_LENGTH = 16
C_PARAM = 1e-8

clf = LinearSVC(C = C_PARAM)
filename = sys.argv[1]
trace_file = open(filename, 'r')

pcs = []
outcomes = []

histories = []
labels = []

def parseFile():
    for line in trace_file:
        if(line):
            (p, o) = line.rstrip().split(" ")
            pc = int(p)
            outcome = int(o)
            pcs.append([pc])
            outcomes.append(outcome)

parseFile()
# initialize the initial history array
history = []
for i in range(0, HISTORY_LENGTH):
    history.append(outcomes[i])
ind = HISTORY_LENGTH
# calculate the histories and their labels
while ind < len(outcomes):
    history.pop(0);
    history.append(outcomes[ind - 1])
    labels.append(outcomes[ind])
    histories.append(list(history)) # need to copy the list so it isn't passed by reference
    ind += 1

clf.fit(histories, labels)

scores = cross_validate(clf, histories, labels)
print("History length, C: " + str(HISTORY_LENGTH) + ", " + str(C_PARAM))
print(scores["test_score"])
