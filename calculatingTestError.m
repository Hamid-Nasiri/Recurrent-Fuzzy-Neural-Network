%% Calculate Cost of currentIndividual on Test Set

s = zeros(nStates,1);
s(1) = 1;

nDataTest = size(testInput,1);

muOutputTest = zeros(nFuzzySetsOutput, nDataTest, nDimensions);
muStateTest = zeros(nFuzzySetsState, nDataTest, nDimensions);
rOutputTest = zeros(nRules_Output, nDataTest);
rStateTest = zeros(nRules_State, nDataTest);

for ii=1:nDimensions
    muOutputTest(:,:,ii) = evalmf(mfOutput(:,ii),testInput(:,ii));
    muStateTest(:,:,ii) = evalmf(mfState(:,ii),testInput(:,ii));
end

% Compute Cartesian Product of Rules

if nDimensions == 2 && coverageRules == false
    for ii=1:nDataTest
        [R1,R2] = meshgrid(muOutputTest(:,ii,1),muOutputTest(:,ii,2));
        [S1,S2] = meshgrid(muStateTest(:,ii,1),muStateTest(:,ii,2));
        rOutputTest(:,ii) = R1(:) .* R2(:);
        rStateTest(:,ii) = S1(:) .* S2(:);
    end
elseif nDimensions == 3 && coverageRules == false
    for ii=1:nDataTest
        [R1,R2,R3] = meshgrid(muOutputTest(:,ii,1),muOutputTest(:,ii,2),muOutputTest(:,ii,3));
        [S1,S2,S3] = meshgrid(muStateTest(:,ii,1),muStateTest(:,ii,2),muStateTest(:,ii,3));
        rOutputTest(:,ii) = R1(:) .* R2(:) .* R3(:);
        rStateTest(:,ii) = S1(:) .* S2(:) .* S3(:);
    end 
elseif nDimensions == 4 && coverageRules == false
    for ii=1:nDataTest
        [R1,R2,R3,R4] = ndgrid(muOutputTest(:,ii,1),muOutputTest(:,ii,2),muOutputTest(:,ii,3),muOutputTest(:,ii,4));
        [S1,S2,S3,S4] = ndgrid(muStateTest(:,ii,1),muStateTest(:,ii,2),muStateTest(:,ii,3),muStateTest(:,ii,4));
        rOutputTest(:,ii) = R1(:) .* R2(:) .* R3(:) .* R4(:);
        rStateTest(:,ii) = S1(:) .* S2(:) .* S3(:) .* S4(:);
    end 
elseif nDimensions == 5 && coverageRules == false
    for ii=1:nDataTest
        [R1,R2,R3,R4,R5] = ndgrid(muOutputTest(:,ii,1),muOutputTest(:,ii,2),muOutputTest(:,ii,3),muOutputTest(:,ii,4),muOutputTest(:,ii,5));
        [S1,S2,S3,S4,S5] = ndgrid(muStateTest(:,ii,1),muStateTest(:,ii,2),muStateTest(:,ii,3),muStateTest(:,ii,4),muStateTest(:,ii,5));
        rOutputTest(:,ii) = R1(:) .* R2(:) .* R3(:) .* R4(:) .* R5(:);
        rStateTest(:,ii) = S1(:) .* S2(:) .* S3(:) .* S4(:) .* S5(:);
    end 
elseif nDimensions == 1 && coverageRules == false
    rOutputTest = muOutputTest;
    rStateTest = muStateTest;
elseif coverageRules == true
        rOutputTest(:,:) = 1;
        rStateTest(:,:) = 1;
        for ii=1:nDimensions
            rOutputTest = rOutputTest .* muOutputTest(:,:,ii);
            rStateTest = rStateTest .* muStateTest(:,:,ii);
        end
end

rbarOutputTest = rOutputTest ./ sum(rOutputTest);
rbarStateTest = rStateTest ./ sum(rStateTest);

stateHistory = [1];
RS_Big = zeros(nDataTest, nRules_Output*nStates);
for t=1:nDataTest
        
        %% Find Output
        % Compute Cartesian Product R x S
        [R, S] = meshgrid(rbarOutputTest(:,t),s);
        RS = R(:) .* S(:);
        RS_Big(t,:) = RS;
        y = RS' * currentIndividual.W(:);
        predictedOutput(t) = y;  
        
        %% Find Next State
        
        [R2, S2] = meshgrid(rbarStateTest(:,t),s);
        RS2 = R2(:) .* S2(:);
        nextState = RS2' * currentIndividual.V(:);
        nextState = (nextState*(nStates-1)) + 1;
        evaluateMFForStateNetworkOutput
        stateHistory = [stateHistory ; nextState];
        
end

predictedOutput = RS_Big * currentIndividual.W(:);
testMAE = mae(predictedOutput-testOutput);
testMSE = immse(predictedOutput,testOutput);
testRMSE =  sqrt(immse(predictedOutput,testOutput));
testSMAP = sum(abs(predictedOutput-testOutput))/sum(abs(testOutput)+abs(predictedOutput));

scaledPredicted = predictedOutput .* (max(tempdata(:,TargetDimension))-min(tempdata(:,TargetDimension))) + min(tempdata(:,TargetDimension));
scaledOutput = testOutput .* (max(tempdata(:,TargetDimension))-min(tempdata(:,TargetDimension))) + min(tempdata(:,TargetDimension));
scaledTestRMSE = sqrt(immse(scaledPredicted,scaledOutput));
scaledTestMAE = mae(scaledPredicted,scaledOutput);
scaledTestSMAP = sum(abs(scaledPredicted-scaledOutput))/sum(abs(scaledOutput)+abs(scaledPredicted));
stateHistoryOrginal = stateHistory;