function [V_Up, V_Down, V_Left, V_Right, V_Stay, a_Agents, a_t, a_exchanged_info_status, a_Coverage_score] = get_agentscore_B(Map, CoverageMap, Agents, Status, Picked, NEG, convex_one_flag, t, exchanged_info_status, Coverage_score)
    %% compute picked agent's score at time t, using information of others at (t-1)
    x = Agents(Picked, 1); 
    y = Agents(Picked, 2); 
    m = size(Map, 1); 
    n = size(Map, 2); 
    a_Agents = Agents; 
    a_t = t; 
    a_exchanged_info_status = exchanged_info_status;
    a_Coverage_score = Coverage_score; 
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
    
    % add info sharing process
    if(Map(x, y) < 5 && exchanged_info_status(Picked) == 0 && mod(t, 100) > 0 && mod(t, 100) < 10 )
        a_exchanged_info_status(Picked) = 1; 
        all_agents_current_scores = get_agent_scores_array(  Map, CoverageMap, Agents, Status );
        [maxScore, maxIndex] = max(all_agents_current_scores); 
        if(maxScore > 3)% not too small
            % global changes
            a_Agents(Picked, 1) = Agents(maxIndex, 1); 
            a_Agents(Picked, 2) = Agents(maxIndex, 2);
            add_t = round(norm(Agents(Picked) - Agents(maxIndex)));
            a_t = t + add_t; 
            end_scores = ones(1, add_t)*Coverage_score(end); 
            a_Coverage_score =[a_Coverage_score end_scores];
        end
    end
    
    
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


