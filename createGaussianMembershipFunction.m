function mf = createGaussianMembershipFunction(nMembership)
    
    mf = [];
    type = "gaussmf";
    if nMembership == 2
        params =  [0.4247 0 ; 0.4247 1];  
    elseif nMembership == 3
        params =  [0.2123 0; 0.2123 0.5; 0.2123 1];
    elseif nMembership == 4
        params = [0.1416 0; 0.1416 0.3333; 0.1416 0.6667; 0.1416 1];
    elseif nMembership == 5
        params = [0.1062 0; 0.1062 0.25; 0.1062 0.5; 0.1062 0.75; 0.1062 1];
    elseif nMembership == 6
        params = [0.08493 0; 0.08493 0.2; 0.08493 0.4; 0.08493 0.6; 
                  0.08493 0.8; 0.08493 1]; 
    elseif nMembership == 7
        params = [0.07078 0; 0.07078 0.1667; 0.07078 0.3333; 0.07078 0.5;
                  0.07078 0.6667; 0.07078 0.8333; 0.07078 1]; 
    elseif nMembership == 8 
        params = [0.06067 0;0.06067 0.1429; 0.06067 0.2857; 
                  0.06067 0.4286; 0.06067 0.5714; 0.06067 0.7143; 
                  0.06067 0.8571; 0.06067 1];  
    elseif nMembership == 9  
        params =  [0.05308 0; 0.05308 0.125; 0.05308 0.25; 0.05308 0.375;
                   0.05308 0.5; 0.05308 0.625; 0.05308 0.75; 0.05308 0.875;
                   0.05308 1];
        
    end
    for i = 1:nMembership
        mf = [mf ; fismf(type, params(i,:))];
    end
    
end
