function [V_ON, V_OFF] = get_agentscore(Map, CoverageMap, Agents, Picked)
%% compute picked agent's score at time t, using information of others at (t-1)
x = Agents(Picked, 1); 
y = Agents(Picked, 2); 
m = size(Map, 1); 
n = size(Map, 2); 

V_ON = Map(x, y) * CoverageMap(x, y);

sidecoverCoeff = 0.5; % consensus with Gazebo, where 2 and 1 are used



% % Agent only knows himself
% if( x + 1 < 11)
%     V_ON = V_ON + Map(x+1, y);
% end
% if( y + 1 < 11)
%     V_ON = V_ON + Map(x, y+1);
% end
% if( x - 1 > 0)
%     V_ON = V_ON + Map(x-1, y); 
% end
% if( y - 1 > 0)
%     V_ON = V_ON + Map(x, y-1);
% end

% Agent knows all neighbours (in 2 hops)
if( x  < m)
    V_ON = V_ON + Map(x+1, y) * CoverageMap(x+1, y) * sidecoverCoeff;
end
if( y  < n)
    V_ON = V_ON + Map(x, y+1) * CoverageMap(x, y+1) * sidecoverCoeff;
end
if( x - 1 > 0)
    V_ON = V_ON + Map(x-1, y) * CoverageMap(x-1, y) * sidecoverCoeff; 
end
if( y - 1 > 0)
    V_ON = V_ON + Map(x, y-1) * CoverageMap(x, y-1) * sidecoverCoeff;
end

V_OFF = 0; 

end

