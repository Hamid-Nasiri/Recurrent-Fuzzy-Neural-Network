
fprintf('Generating Triangle Fuzzy Rules Using Coverage\n');

trainInputShuffled = trainInput;
mf = [];
if nDimensions == 1
    % Create a rule for first data
    mf = fismf('trimf',[trainInputShuffled(1)-ruleSigma trainInputShuffled(1) trainInputShuffled(1)+ruleSigma]);
    for ii = 2:nData
       % Check Coverage
       membershipValue = evalmf(mf,trainInputShuffled(ii));
       membershipValueSUM = sum(membershipValue);
       if membershipValueSUM < coverageThreshold
           % Create new Rule
           mf = [mf ; fismf('trimf',[trainInputShuffled(ii)-ruleSigma trainInputShuffled(ii) trainInputShuffled(ii)+ruleSigma])];
       end
    end
elseif nDimensions > 1
   % Create a rule for first data
    for ii = 1:nDimensions
        mf = [mf fismf('trimf',[trainInputShuffled(1,ii)-ruleSigma trainInputShuffled(1,ii) trainInputShuffled(1,ii)+ruleSigma])];
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
             newRuleMf = [newRuleMf fismf('trimf',[trainInputShuffled(ii,jj)-ruleSigma trainInputShuffled(ii,jj) trainInputShuffled(ii,jj)+ruleSigma])];
          end
          mf = [mf ; newRuleMf];
       end    
    end             
end
    