
fig = figure;

interpolation_accuracy = 5; % 2^5-1 points between every two values in Map

M = size(Map, 1); 
N = size(Map, 2);

interpolated_Map = interp2(Map, interpolation_accuracy, 'cubic');
interpolated_M = 1:(M-1)*(2^interpolation_accuracy - 1) + M;
interpolated_N = 1:(N-1)*(2^interpolation_accuracy - 1) + N;

% mesh(interpolated_M, interpolated_N, interpolated_Map);

colormap('hot');
imagesc(interpolated_Map);
colorbar;

%%
% fig = figure; 
%  
% colormap('hot');
% imagesc(CoverageMap);
% colorbar;