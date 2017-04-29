function Coverage_score = get_allscore( Map, CoverageMap, Agents, Status)
    %% compute the coverage according to Map, Agents and their Status under the exclusive rule
    M = size(Map, 1); 
    N = size(Map, 2); 
    
    ActiveAgents = Agents(find(Status), :); 
    A = size(ActiveAgents, 1); 

    for i = 1:A
        [Agents_score(i), Agents_scoreOFF] = get_agentscore(Map, CoverageMap, ActiveAgents, i);
    end
    
    Coverage_score = sum(Agents_score); 

end

