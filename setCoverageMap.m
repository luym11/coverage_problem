function coverageMap = setCoverageMap(Map, Agents, Status, NEG)
    
    ActiveAgents = Agents(find(Status), :); 
    m = size(Map, 1); 
    n = size(Map, 2); 
    A = size(ActiveAgents, 1);
    
    coverageMap = zeros(m, n); % value of CoverageMap is 2 for the agents, 1 for "covered area", 0 for uncover, -NEG for overlap
    
%     % Step 1, place all agents first
%     IND_Agents = sub2ind([M, N], ActiveAgents(:, 1), ActiveAgents(:, 2)); 
%     CoverageMap(IND_Agents) = 2; 
    
     
    for i = 1:A
        x = ActiveAgents(i ,1); 
        y = ActiveAgents(i ,2); 
        % step 1, place the agent
        if(coverageMap(x, y) == 0)
            coverageMap(x, y) = 2; 
        else
            coverageMap(x, y) = -NEG;
        end
        
        % step 2, compute surrounded 4 areas
        if(x + 1 < m + 1)
            if(coverageMap(x + 1, y) == 0)
                coverageMap(x + 1, y) = 1; 
            else
                coverageMap(x + 1, y) = -NEG;
            end
        end
        if(y + 1 < n + 1)
            if(coverageMap(x, y + 1) == 0)
                coverageMap(x, y + 1) = 1; 
            else
                coverageMap(x, y + 1) = -NEG;
            end
        end
        if(x - 1 > 0)
            if(coverageMap(x - 1, y) == 0)
                coverageMap(x - 1, y) = 1; 
            else
                coverageMap(x - 1, y) = -NEG;
            end
        end
        if(y - 1 > 0)
            if(coverageMap(x, y - 1) == 0)
                coverageMap(x, y - 1) = 1; 
            else
                coverageMap(x, y - 1) = -NEG;
            end 
        end
    end
    
end

