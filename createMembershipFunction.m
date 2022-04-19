function mf = createMembershipFunction (nMembership) 

    type = 'trimf' ;
    mf = [];
    fsb = linspace (0, 1, nMembership);
    step = fsb(2);
    fsb = [-step fsb 1+step];
    for i = 1:nMembership
        param = [fsb(i) fsb(i+1) fsb(i+2)];
        mf = [mf ; fismf(type, param)];
    end

end