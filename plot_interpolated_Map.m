function plot_interpolated_Map( map )

% plot interpolated heatmap "Map"
% x,y axises are fakeX and fakeY

fig = figure;
 
interpolation_accuracy = 5; % 2^5-1 points between every two values in Map

m = size(map, 1);
n = size(map, 2);

interpolated_Map = interp2(map, interpolation_accuracy, 'cubic');
bigM = (m-1)*(2^interpolation_accuracy - 1) + m;
bigN = (n-1)*(2^interpolation_accuracy - 1) + n;


colormap('hot');

y = 1:2^interpolation_accuracy - 1 : bigM; 
fakeY = 1:m;
x = 1:2^interpolation_accuracy - 1 : bigN; 
fakeX = 1:n;

imagesc(interpolated_Map);
colorbar;

set(gca,'xtick',x);
set(gca,'ytick',y);
set(gca,'xticklabel',fakeX);
set(gca,'yticklabel',fakeY);


end

