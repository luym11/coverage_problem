function drawTraj( Traj_x, Traj_y, i, interpolation_a )

    % Change Traj to plotable scale
    Traj_plot_x = Traj_x + (Traj_x-ones(size(Traj_x))) .* ( 2^interpolation_a - 1 );
    Traj_plot_y = Traj_y + (Traj_y-ones(size(Traj_y))) .* ( 2^interpolation_a - 1 );
    Traj_plot_x(Traj_plot_x < 0)=0;
    Traj_plot_y(Traj_plot_y < 0)=0;

    color='bgrcmyk';
    if( size(Traj_x(i, :), 2) > 1)
        plot(Traj_plot_x(i, 1),Traj_plot_y(i, 1),...
                    '--gs',...
                    'LineWidth',1,...
                    'MarkerSize',10,...
                    'MarkerEdgeColor',color(mod(i, 7)+1),...
                    'MarkerFaceColor',[0,1,0]);
        hold on;
        for j = 2: size(Traj_plot_x(i, :), 2)
            if(Traj_plot_x(i, j) == 0)
                break;
            end
            plot([Traj_plot_x(i, j-1),Traj_plot_x(i, j)], [Traj_plot_y(i, j-1),Traj_plot_y(i, j)],color(mod(i, 7)+1),'LineWidth',2);
            % j
        end
    end
end

