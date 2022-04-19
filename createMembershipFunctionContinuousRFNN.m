function mf = createMembershipFunctionContinuousRFNN(nMembership)
    
    mf = [];
    
    if nMembership == 2
        type = "trapmf";
        params =  [0 0 1 2]; 
        mf = [mf ; fismf(type, params)];
        params =  [1 2 3 3];
        mf = [mf ; fismf(type, params)];
    elseif nMembership == 3
        type = "trapmf";
        params =  [0 0 1 2];
        mf = [mf ; fismf(type, params)];
        type = "trimf";
        params =  [1 2 3];
        mf = [mf ; fismf(type, params)];
        type = "trapmf"; 
        params =  [2 3 4 4];
        mf = [mf ; fismf(type, params)];
    end

end
