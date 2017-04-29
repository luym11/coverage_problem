function CoverageMap = setCoverageMap(Map, Agents, Status)
    
    
    ActiveAgents = Agents(find(Status), :); 
    M = size(Map, 1); 
    N = size(Map, 2); 
    A = size(ActiveAgents, 1);
    
    CoverageMap = zeros(M, N); % value of CoverageMap is 2 for the agents, 1 for "cevered area", 0 for uncover
    
%     % Step 1, place all agents first
%     IND_Agents = sub2ind([M, N], ActiveAgents(:, 1), ActiveAgents(:, 2)); 
%     CoverageMap(IND_Agents) = 2; 
    
    NEG = 2; 
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
        if(x + 1 < 11)
            if(CoverageMap(x + 1, y) == 0)
                CoverageMap(x + 1, y) = 1; 
            else
                CoverageMap(x + 1, y) = -NEG;
            end
        end
        if(y + 1 < 11)
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

