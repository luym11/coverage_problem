function CoverageMap = updateCoverageMap(Agents, Status, CoverageMap, changedIndex)
% RULE: 
% 1. Single coverage : get the points on the Map
% 2. Double coverage : both/all of the agents get a (vertain) minus value at that area
% 3. CoverageMap valuation : Agent for 2, single cover for 1, double/more
% cover for -1

x = Agents(changedIndex, 1); 
y = Agents(changedIndex, 2); 
S = Status(changedIndex); 

if(S == 1)
    % step 1, place the agent
    if(CoverageMap(x, y) == 0)
        CoverageMap(x, y) = 2; 
    else
        CoverageMap(x, y) = -1;
    end
    % step 2, compute surrounded 4 areas
    if(CoverageMap(x + 1, y) == 0)
        CoverageMap(x + 1, y) = 1; 
    else
        CoverageMap(x + 1, y) = -1;
    end
    if(CoverageMap(x, y + 1) == 0)
        CoverageMap(x, y + 1) = 1; 
    else
        CoverageMap(x, y + 1) = -1;
    end
    if(CoverageMap(x - 1, y) == 0)
        CoverageMap(x - 1, y) = 1; 
    else
        CoverageMap(x - 1, y) = -1;
    end
    if(CoverageMap(x, y - 1) == 0)
        CoverageMap(x, y - 1) = 1; 
    else
        CoverageMap(x, y - 1) = -1;
    end
else
    ActiveAgents = Agents(find(Status), :);
    CoverageMap = initCoverageMap(ActiveAgents, Status, CoverageMap); 
end



end

