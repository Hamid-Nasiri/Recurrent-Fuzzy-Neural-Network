global nStates;
global nData;
global nRules_Output;
global rbarOutput;
global rbarState;
global currentIndividual;
global targetOutput;

rngrnd = 1; 
rng(rngrnd);

%% Load Air Quality Index NO2 Dataset
fprintf("Loading Air Quality Index NO2 Dataset...\n");
load('Benchmarks\\NO2_10step.mat');
tempdata = data;
TargetDimension = 5;
data = (data - min(data)) ./ (max(data)-min(data)) ;
%data = data * 2 - 1;
trainInput = data(1:24000,1:4);
targetOutput = data(1:24000,5);
testInput = data(24001:end,1:4);
testOutput = data(24001:end,5);


%%
% ****************************************************
% *                  Parameters                      *
% ****************************************************
coverageRules = false; % Generating Fuzzy Rules Using Coverage ?
ruleSigma = 0.3;
coverageThreshold = 0.2;
nFuzzySetsOutput = 2;
nFuzzySetsState = 2;
nStates = 2;
nRules_Output = nFuzzySetsOutput ^ 4;
nRules_State = nFuzzySetsState ^ 4;
mfType = "trimf";  
PSO_SwarmSize = 20;
PSO_MaxIteration = 10;

nData = size(trainInput,1);
nDimensions = size(trainInput,2);
finalResults = [];

%% Create Fuzzy Rules
if ~coverageRules
    if mfType == "gaussmf" 
        mfOutput = createGaussianMembershipFunction(nFuzzySetsOutput);
        mfState = createGaussianMembershipFunction(nFuzzySetsState);
    elseif mfType == "trimf"
        mfOutput = createMembershipFunction(nFuzzySetsOutput);
        mfState = createMembershipFunction(nFuzzySetsState);
    elseif mfType == "gauss2mf"
        mfOutput = createGaussian2MembershipFunction(nFuzzySetsOutput);
        mfState = createGaussian2MembershipFunction(nFuzzySetsState);
    elseif mfType == "gbellmf"
        mfOutput = createGeneralizedBellshapeMembershipfunction(nFuzzySetsOutput);
        mfState = createGeneralizedBellshapeMembershipfunction(nFuzzySetsState);    
    end
    mfOutput = repmat(mfOutput,1,nDimensions);
    mfState = repmat(mfState,1,nDimensions);
else
    if ~exist('mf','var')
        if mfType == "gaussmf"
            generateGaussianFuzzyRulesUsingCoverage;
        elseif mfType == "trimf"
            generateTriangleFuzzyRulesUsingCoverage;
        end
    end
    mfOutput = mf;
    mfState = mf;
    nFuzzySetsOutput = length(mf);
    nFuzzySetsState = length(mf);
    nRules_Output = nFuzzySetsOutput;
    nRules_State = nFuzzySetsState;
end

fprintf("Calculating Membership Values...\n");
calculateMembershipValues;

%% Initialization

% W -> Weight of Output Network
% V -> Weight of State Network
currentIndividual.V = rand(nStates,nRules_State);
currentIndividual.W = rand(nStates,nRules_Output);
costCalculation02;

%% Training Network
fprintf("Training Network Using PSO..."); 
fun = @(x) costCalculation03(x);
lb = zeros(1,nRules_State*nStates);
ub = ones(1,nRules_State*nStates);
options = optimoptions('particleswarm','SwarmSize',PSO_SwarmSize,'Display','iter','MaxIterations',PSO_MaxIteration); 
[x, fval] = particleswarm(fun,nRules_State*nStates,lb,ub,options);    
    
currentIndividual.V = x;   
costCalculation02    
calculatingTestError;   
finalResults = [scaledTestRMSE scaledTestSMAP testRMSE];

fprintf("Ten Step Ahead Prediction Results:\n");
fprintf("RMSE = %e\n",testRMSE);
fprintf("MAE = %e\n",testMAE);
fprintf("SMAPE = %e\n",testSMAP);
