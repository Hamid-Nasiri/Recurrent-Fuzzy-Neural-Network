function fsb = createMembershipFunction02 (nMembership) 

    fsb = linspace (0, 1, nMembership);
    step = fsb(2);
    fsb = [-step fsb 1+step];

end