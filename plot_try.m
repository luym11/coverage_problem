%% plot interpolated heatmap 'Map'

plot_interpolated_Map( Map, interpolation_accuracy );
hold on; 

%% plot agents and their status on heatMap 'Map'
plot_agents_and_status(Agents, Status, interpolation_accuracy); 

%% plot coverage map
plot_coverageMap(CoverageMap); 