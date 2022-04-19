%% Calculate Cost of currentIndividual and Update Its W

s = zeros(nStates,1);
s(1) = 1;

RS_Big = zeros(nData, nRules_Output*nStates);

for t=1:nData
        
        %% Find Output
        % Compute Cartesian Product R x S
        [R, S] = meshgrid(rbarOutput(:,t),s);
        RS = R(:) .* S(:);
        RS_Big(t,:) = RS;

        %% Find Next State
        
        [R2, S2] = meshgrid(rbarState(:,t),s);
        RS2 = R2(:) .* S2(:);
        nextState = RS2' * currentIndividual.V(:);

        nextState = (nextState*(nStates-1)) + 1;
        % This Script Calculate S
        evaluateMFForStateNetworkOutput;
        
end

lastState = nextState;
W = lsqminnorm(RS_Big, targetOutput);
currentIndividual.W = reshape(W,nStates,nRules_Output);
predictedOutput = RS_Big * currentIndividual.W(:);
currentIndividual.Cost =  sqrt(immse(predictedOutput,targetOutput));
