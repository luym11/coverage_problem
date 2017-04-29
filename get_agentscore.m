function [V_ON, V_OFF] = get_agentscore(Map, CoverageMap, Agents, Picked)
%% compute randomly picked agent's score at time t, using information of others at (t-1)
x = Agents(Picked, 1); 
y = Agents(Picked, 2); 

V_ON = Map(x, y) * CoverageMap(x, y);

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

% Agent knows all
if( x + 1 < 11)
    V_ON = V_ON + Map(x+1, y) * CoverageMap(x+1, y);
end
if( y + 1 < 11)
    V_ON = V_ON + Map(x, y+1) * CoverageMap(x, y+1);
end
if( x - 1 > 0)
    V_ON = V_ON + Map(x-1, y) * CoverageMap(x-1, y); 
end
if( y - 1 > 0)
    V_ON = V_ON + Map(x, y-1) * CoverageMap(x, y-1);
end

V_OFF = 0; 

end

