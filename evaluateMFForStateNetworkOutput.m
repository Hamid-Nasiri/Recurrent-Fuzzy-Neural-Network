if nStates == 1
    s(1) = 1;
elseif nStates == 2
    s(1) = trapmf(nextState,[0 0 1 2]);
    s(2) = trapmf(nextState,[1 2 3 3]);
elseif nStates == 3
    s(1) = trapmf(nextState,[0 0 1 2]);
    s(2) = trimf(nextState, [1 2 3]);
    s(3) = trapmf(nextState,[2 3 4 4]);
elseif nStates == 5
    s(1) = trapmf(nextState,[0 0 1 2]);
    s(2) = trimf(nextState, [1 2 3]);
    s(3) = trimf(nextState, [2 3 4]);
    s(4) = trimf(nextState, [3 4 5]);
    s(5) = trapmf(nextState,[4 5 6 6]); 
elseif nStates == 10
    s(1) = trapmf(nextState,[0 0 1 2]);
    s(2) = trimf(nextState, [1 2 3]);
    s(3) = trimf(nextState, [2 3 4]);
    s(4) = trimf(nextState, [3 4 5]);
    s(5) = trimf(nextState, [4 5 6]);
    s(6) = trimf(nextState, [5 6 7]);
    s(7) = trimf(nextState, [6 7 8]);
    s(8) = trimf(nextState, [7 8 9]);
    s(9) = trimf(nextState, [8 9 10]);
    s(10) = trapmf(nextState,[9 10 11 11]); 
else
    s(1) = trapmf(nextState, [0 0 1 2]);
    for i = 2:nStates-1
        s(i) = trimf(nextState, [i-1 i i+1]);
    end
    s(nStates) = trapmf(nextState,[nStates-1 nStates nStates+1 nStates+1]);
end