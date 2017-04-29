function plot_coverageMap( coverageMap )

% fig = figure; 
  
colormap('hot');
imagesc(coverageMap);
axis equal
colorbar('Ticks', [-2, -1, 0, 1, 2]);

end

