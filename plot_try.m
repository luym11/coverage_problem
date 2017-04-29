%% plot interpolated heatmap 'Map'

plot_interpolated_Map( Map );

%%
fig = figure; 
 
colormap('hot');
imagesc(CoverageMap);
colorbar;