function [V_Up, V_Down, V_Left, V_Right, V_Stay] = get_agentscore_B(Map, CoverageMap, Agents, Status, Picked, NEG, convex_one_flag)
    %% compute picked agent's score at time t, using information of others at (t-1)
    x = Agents(Picked, 1); 
    y = Agents(Picked, 2); 
    m = size(Map, 1); 
    n = size(Map, 2); 
    % simulate different cost for different preference for cost weightings
    anisotropicEffect = [0.6 1 1 1 1]; % Ordered as: stay, up, down, left, right
    
    [V_Stay, ~] = get_agentscore(Map, CoverageMap, Agents, Picked);
    V_Stay  = V_Stay * anisotropicEffect(1);
    V_Up = -1000; 
    V_Down = -1000; 
    V_Left = -1000; 
    V_Right = -1000; 
    
    % need to set a virtual coverageMap for each calculation
    coverageMap = CoverageMap;
    
    
    
    agents = Agents; 
    if(x > 1)
        agents(Picked,1) = x-1; 
        coverageMap = setCoverageMap(Map, agents, Status, NEG); 
        [V_Up, ~] = get_agentscore(Map, coverageMap, [x-1,y], 1);
        V_Up = V_Up * anisotropicEffect(2); 
    end
    
    agents = Agents; 
    if(x < m)
        agents(Picked,1) = x+1; 
        coverageMap = setCoverageMap(Map, agents, Status, NEG); 
        [V_Down, ~] = get_agentscore(Map, coverageMap, [x+1,y], 1);
        V_Down = V_Down * anisotropicEffect(3); 
    end
    
    agents = Agents; 
    if(y > 1)
        agents(Picked,2) = y-1; 
        coverageMap = setCoverageMap(Map, agents, Status, NEG);
        [V_Left, ~] = get_agentscore(Map, coverageMap, [x,y-1], 1);
        V_Left = V_Left * anisotropicEffect(4); 
    end
    
    agents = Agents; 
    if(y < n)
        agents(Picked,2) = y+1; 
        coverageMap = setCoverageMap(Map, agents, Status, NEG);
        [V_Right, ~] = get_agentscore(Map, coverageMap, [x,y+1], 1); 
        V_Right = V_Right * anisotropicEffect(5); 
    end
    
    if(convex_one_flag == true)
        if(Map(x, y) ~= 0)
            if(x>1 && Map(x-1, y) == 0)
                V_Up = -1000; 
            end
            if(x<m && Map(x+1, y) == 0)
                V_Down = -1000; 
            end
            if(y>1 && Map(x, y-1) == 0)
                V_Left = -1000; 
            end
            if(y<n && Map(x, y+1) == 0)
                V_Right = -1000; 
            end
        end
    end
end


