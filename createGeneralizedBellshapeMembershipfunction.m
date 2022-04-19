function mf = createGeneralizedBellshapeMembershipfunction(nMembership)
    
%% Create membership functions using a combination of two Gaussian membership functions
    mf = [];
    type = "gbellmf";
    if nMembership == 2
        params =  [0.5 2.5 0;
                   0.5 2.5 1];  
    elseif nMembership == 3
        params =  [0.25 2.5 0;
                   0.25 2.5 0.5;
                   0.25 2.5 1];
    elseif nMembership == 4
        params = [0.1667 2.5 0;
                  0.1667 2.5 0.3333;
                  0.1667 2.5 0.6667;
                  0.1667 2.5 1];
    elseif nMembership == 5
        params = [0.125 2.5 0;
                  0.125 2.5 0.25;
                  0.125 2.5 0.5;
                  0.125 2.5 0.75;
                  0.125 2.5 1];
    elseif nMembership == 6
        params = [0.1 2.5 0;
                  0.1 2.5 0.2;
                  0.1 2.5 0.4;
                  0.1 2.5 0.6;
                  0.1 2.5 0.8;
                  0.1 2.5 1]; 
    elseif nMembership == 7
        params = [0.08333 2.5 0;
                  0.08333 2.5 0.1667;
                  0.08333 2.5 0.3333;
                  0.08333 2.5 0.5;
                  0.08333 2.5 0.6667;
                  0.08333 2.5 0.8333;
                  0.08333 2.5 1]; 
    elseif nMembership == 8 
        params = [0.07143 2.5 0;
                  0.07143 2.5 0.1429;
                  0.07143 2.5 0.2857;
                  0.07143 2.5 0.4286;
                  0.07143 2.5 0.5714;
                  0.07143 2.5 0.7143;
                  0.07143 2.5 0.8571;
                  0.07143 2.5 1];  
    elseif nMembership == 9  
        params =  [0.0625 2.5 0;
                   0.0625 2.5 0.125;
                   0.0625 2.5 0.25;
                   0.0625 2.5 0.375;
                   0.0625 2.5 0.5;
                   0.0625 2.5 0.625;
                   0.0625 2.5 0.75;
                   0.0625 2.5 0.875;
                   0.0625 2.5 1];
    end
    for i = 1:nMembership
        mf = [mf ; fismf(type, params(i,:))];
    end
    
end
