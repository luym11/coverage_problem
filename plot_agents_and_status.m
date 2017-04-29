function plot_agents_and_status( agents, status, interpolation_a)

    for i = 1 : size(agents, 1)
        Agents_plot(i, :) = agents(i, :) + (agents(i, :)-[1 1]) .* ( 2^interpolation_a - 1 );
        if(status(i) == 1)
            plot(Agents_plot(i, 2), Agents_plot(i, 1), ... % ! plotting matrix is different from plotting points. x y def are different
            '--gs',...
            'LineWidth',2,...
            'MarkerSize',10,...
            'MarkerEdgeColor','b',...
            'MarkerFaceColor',[0.5,0.5,0.5]); 

            % draw a circle to show coverage area by that agent
            theta = linspace(0,2*pi);
            r = 1 + ( 2^interpolation_a - 1 ); 
            xc = Agents_plot(i,2); 
            yc = Agents_plot(i,1); 
            x = r*cos(theta) + xc;
            y = r*sin(theta) + yc;
            plot(x,y, ...
                '-k',...
                'LineWidth',2);
        else
            plot(Agents_plot(i, 2), Agents_plot(i, 1), ... % ! plotting matrix is different from plotting points. x y def are different
            '--gs',...
            'LineWidth',2,...
            'MarkerSize',10,...
            'MarkerEdgeColor','g',...
            'MarkerFaceColor',[0.2,0.2,0.2]); 

    %         % draw a circle to show coverage area by that agent
    %         theta = linspace(0,2*pi);
    %         r = 1 + ( 2^interpolation_accuracy - 1 ); 
    %         xc = Agents_plot(i,2); 
    %         yc = Agents_plot(i,1); 
    %         x = r*cos(theta) + xc;
    %         y = r*sin(theta) + yc;
    %         plot(x,y, ...
    %             '-y',...
    %             'LineWidth',2);
        end

    end

end

