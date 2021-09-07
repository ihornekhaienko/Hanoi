from copy import deepcopy

class Node:
  def __init__(self):
    self.state=[[],[],[]]
    self.nodeNumber=0
    self.parent=None
    self.children=[]
    self.point=10

numberPegs = 4
numberDisks = 4
initState = []
finalState = []

def generatedTowers(initState, finalState):
    initState.append(list(reversed([i for i in range(0, numberDisks)])))
    for _ in range(1, numberPegs):
        initState.append([])
    finalState = list(reversed(initState))
    return initState, finalState

def move(st1,st2):
    s1=st1[:]
    s2=st2[:]
    if len(s1)>0:
        topDisc=s1[len(s1)-1]
        lastofS2=len(s2)-1

        if len(s2)==0 or s2[lastofS2]>topDisc:
            s2.append(topDisc)
            s1.pop()
            return s1,s2
        else:
            return None
    else:
        return None

def moveDisk(n, nodeNumber):
    stacks=[]
    for x in range(0,numberPegs):
        for y in range(0,numberPegs):
            stacks=move(n.state[x],n.state[y])

            if stacks!=None:
                nextnode=Node()
                nextnode=deepcopy(n)
                nextnode.state[x]=deepcopy(stacks[0])
                nextnode.state[y]=deepcopy(stacks[1])

                if nextnode.state not in states:
                    states.append(nextnode.state)
                    return nextnode
    return None

def breadthFirst(node,parentList,childList,step,nodeNumber):
    print('\nSTEP : ',step)
    step+=1
    for node in parentList:
        print('Parent node:',node.nodeNumber,' State :',node.state)
        exhausted=False
        parent=deepcopy(node)

        while exhausted==False :
            childnode=moveDisk(node,nodeNumber)

            if childnode!=None:
                nodeNumber+=1
                childnode.nodeNumber=nodeNumber
                childnode.parent=node
                parent.children.append(childnode)
                childList.append(childnode)
                print('     Child node:',childnode.nodeNumber,'State:', childnode.state)

                if childnode.state==finalState:
                    print('\nThe final state was achieved in: ', step-1, ' steps')
                    printPath(childnode)
                    return
            else:
                exhausted=True
            
    parentList=deepcopy(childList)
    childList=[]
    breadthFirst(parentList,parentList,childList,step,nodeNumber)

def evalFunc(node):
    largest=0
    l=[]
    for peg in initState:
        if len(peg)>0:
            l.append(max(peg))

    largest=max(l)
    node.point=10
    setPoints(node,largest)

def setPoints(node,largest):
    if largest>0: 
        for fpeg in finalState:
            if largest in fpeg:
                pos=finalState.index(fpeg)
                if largest in node.state[pos]:
                    node.point=node.point-1
                    setPoints(node,largest-1)

def bestFirst(parentList,childList,step,nodeNumber):
    print('\nSTEP : ',step)
    step+=1
    leastPoint=10
    for node in parentList:
        evalFunc(node)

        if node.point<leastPoint:
            leastPoint=node.point
    for node in parentList: 
        if node.point == leastPoint:
            print('Parent node:',node.nodeNumber,' State :',node.state, 'Cost = ', node.point)
            exhausted=False
            parent=deepcopy(node)

            while exhausted==False :
                childnode=moveDisk(node, nodeNumber)
                if childnode!=None:
                    nodeNumber+=1
                    childnode.nodeNumber=nodeNumber
                    childnode.parent=node
                    parent.children.append(childnode)
                    childList.append(childnode)
                    print('     Child node:',childnode.nodeNumber,'State:', childnode.state)

                    if childnode.state==finalState:
                        print('\nThe final state was achieved in: ', step-1, ' steps')
                        printPath(childnode)
                        return
                else:
                    exhausted=True
    parentList=deepcopy(childList)
    childList=[]
    bestFirst(parentList,childList,step,nodeNumber)

def printPath(node):
    print('\nInitial state : ',initState)
    print('Final statе  : ',finalState)
    print('Path:')
    while True:
        print('  ', node.state)
        if node.parent!=None:
            node=node.parent
        else:
            break

initState, finalState = generatedTowers(initState, finalState)

print('\nInitial state : ',initState)
print('Final statе  : ',finalState)

states=[initState]

node=Node()
node.state=initState
parentList=[node]
childList=[]
parentList=[node]
childList=[]
nodeNumber=1
step = 1

breadthFirst(node, parentList, childList, step, nodeNumber)
#bestFirst(parentList, childList, step, nodeNumber)