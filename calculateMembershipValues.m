
muOutput = zeros(nFuzzySetsOutput, nData, nDimensions);
muState = zeros(nFuzzySetsState, nData, nDimensions);
rOutput = zeros(nRules_Output, nData);
rState = zeros(nRules_State, nData);

for ii=1:nDimensions
    muOutput(:,:,ii) = evalmf(mfOutput(:,ii),trainInput(:,ii));
    muState(:,:,ii) = evalmf(mfState(:,ii),trainInput(:,ii));
end

% Compute Cartesian Product of Rules

if nDimensions == 2  && coverageRules == false
    for ii=1:nData
        [R1,R2] = meshgrid(muOutput(:,ii,1),muOutput(:,ii,2));
        [S1,S2] = meshgrid(muState(:,ii,1),muState(:,ii,2));
        rOutput(:,ii) = R1(:) .* R2(:);
        rState(:,ii) = S1(:) .* S2(:);
    end
elseif nDimensions == 3 && coverageRules == false
    for ii=1:nData
        [R1,R2, R3] = meshgrid(muOutput(:,ii,1),muOutput(:,ii,2),muOutput(:,ii,3));
        [S1,S2, S3] = meshgrid(muState(:,ii,1),muState(:,ii,2),muState(:,ii,3));
        rOutput(:,ii) = R1(:) .* R2(:) .* R3(:);
        rState(:,ii) = S1(:) .* S2(:) .* S3(:);
    end
elseif nDimensions == 4 && coverageRules == false
    for ii=1:nData
        [R1,R2, R3, R4] = ndgrid(muOutput(:,ii,1),muOutput(:,ii,2),muOutput(:,ii,3),muOutput(:,ii,4));
        [S1,S2, S3, S4] = ndgrid(muState(:,ii,1),muState(:,ii,2),muState(:,ii,3),muState(:,ii,4));
        rOutput(:,ii) = R1(:) .* R2(:) .* R3(:) .* R4(:);
        rState(:,ii) = S1(:) .* S2(:) .* S3(:) .* S4(:);
    end     
elseif nDimensions == 5 && coverageRules == false
    for ii=1:nData
        [R1,R2, R3, R4, R5] = ndgrid(muOutput(:,ii,1),muOutput(:,ii,2),muOutput(:,ii,3),muOutput(:,ii,4),muOutput(:,ii,5));
        [S1,S2, S3, S4, S5] = ndgrid(muState(:,ii,1),muState(:,ii,2),muState(:,ii,3),muState(:,ii,4),muState(:,ii,5));
        rOutput(:,ii) = R1(:) .* R2(:) .* R3(:) .* R4(:) .* R5(:);
        rState(:,ii) = S1(:) .* S2(:) .* S3(:) .* S4(:) .* S5(:);
    end    
elseif nDimensions == 1 && coverageRules == false
    rOutput = muOutput;
    rState = muState;
elseif coverageRules == true
        rOutput(:,:) = 1;
        rState(:,:) = 1;
        for ii=1:nDimensions
            rOutput = rOutput .* muOutput(:,:,ii);
            rState = rState .* muState(:,:,ii);
        end
end

rbarOutput = rOutput ./ sum(rOutput);
rbarState = rState ./ sum(rState);
