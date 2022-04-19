
fprintf('Generating Gaussian Fuzzy Rules Using Coverage\n');

trainInputShuffled = trainInput;
mf = [];
if nDimensions == 1
    % Create a rule for first data
    mf = fismf('gaussmf',[ruleSigma, trainInputShuffled(1)]);
    for ii = 2:nData
       % Check Coverage
       membershipValue = evalmf(mf,trainInputShuffled(ii));
       membershipValueSUM = sum(membershipValue);
       if membershipValueSUM < coverageThreshold
           % Create new Rule
           mf = [mf ; fismf('gaussmf',[ruleSigma, trainInputShuffled(ii)])];
       end
    end
elseif nDimensions > 1
   % Create a rule for first data
    for ii = 1:nDimensions
        mf = [mf fismf('gaussmf',[ruleSigma, trainInputShuffled(1,ii)])];
    end
    for ii = 2:nData
        
       % Check Coverage
       membershipValue = [];
       for jj = 1:nDimensions
           membershipValue = [membershipValue evalmf(mf(:,jj),trainInputShuffled(ii,jj))];
       end
       membershipValueProduct = 1;
       for jj = 1:nDimensions
           membershipValueProduct = membershipValueProduct .* membershipValue(:,jj);
       end
       membershipValueSUM = sum(membershipValueProduct);
       if membershipValueSUM < coverageThreshold
          % Create new Rule
          newRuleMf = [];
          for jj = 1:nDimensions
             newRuleMf = [newRuleMf fismf('gaussmf',[ruleSigma, trainInputShuffled(ii,jj)])];
          end
          mf = [mf ; newRuleMf];
       end    
    end             
end

