function newMap = drifting_environment( Map, k, distance_to_edge, area_size,decrease_size,Max)

% This function is used to
% 1. Set am area contains important information (decrease from MAX)
% 2. Let it move by the edge within distance_to_edge, with time step k(k starts with 1, then increase)
% 3. Add this area to the original Map

M = size(Map, 1); 
N = size(Map, 2); 

% generate a traj, now trangular shaped
[trajx, trajy] = rect_traj(M,N,distance_to_edge); % distance_to_edge is typically bigger than area_size considering the size of important area

% generate important area based on the trajactory of its center (eg. area_size = 3)
%     *
%   * * *
% * * * * *
%   * * *
%     * 
time_step = mod(k, size(trajx,2)); 
if(time_step == 0)
    time_step = 76; 
end

imct_x = trajx(time_step); 
imct_y = trajy(time_step); 
important_area_map = important_area_generate_function(M,N,imct_x, imct_y, area_size, decrease_size, Max);

Map(important_area_map ~= 0) = 0; 
newMap = Map + important_area_map; 
% newMap = important_area_map; 

end

