function CoverageMap = setCoverageMap(Map, Agents, Status, NEG)
    
    ActiveAgents = Agents(find(Status), :); 
    m = size(Map, 1); 
    n = size(Map, 2); 
    A = size(ActiveAgents, 1);
    
    CoverageMap = zeros(m, n); % value of CoverageMap is 2 for the agents, 1 for "cevered area", 0 for uncover
    
%     % Step 1, place all agents first
%     IND_Agents = sub2ind([M, N], ActiveAgents(:, 1), ActiveAgents(:, 2)); 
%     CoverageMap(IND_Agents) = 2; 
    
     
    for i = 1:A
        x = Agents(i ,1); 
        y = Agents(i ,2); 
        % step 1, place the agent
        if(CoverageMap(x, y) == 0)
            CoverageMap(x, y) = 2; 
        else
            CoverageMap(x, y) = -NEG;
        end
        
        % step 2, compute surrounded 4 areas
        if(x + 1 < m + 1)
            if(CoverageMap(x + 1, y) == 0)
                CoverageMap(x + 1, y) = 1; 
            else
                CoverageMap(x + 1, y) = -NEG;
            end
        end
        if(y + 1 < n + 1)
            if(CoverageMap(x, y + 1) == 0)
                CoverageMap(x, y + 1) = 1; 
            else
                CoverageMap(x, y + 1) = -NEG;
            end
        end
        if(x - 1 > 0)
            if(CoverageMap(x - 1, y) == 0)
                CoverageMap(x - 1, y) = 1; 
            else
                CoverageMap(x - 1, y) = -NEG;
            end
        end
        if(y - 1 > 0)
            if(CoverageMap(x, y - 1) == 0)
                CoverageMap(x, y - 1) = 1; 
            else
                CoverageMap(x, y - 1) = -NEG;
            end 
        end
    end
    
end

