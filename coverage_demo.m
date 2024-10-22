% coverage demo
% 2016/11/09
% yimeng.lu@kaust.edu.sa

% Program Outline
% step 1: set up, initiation
% generate a random matrix with different scores
% generate a number of agents in this map
% at t= 0, each agent has a random state of ON/OFF, should compute it's
% coverage areas and its score(under exclusive rule)

% Step 2: start the game! 
% at each time step, say, t_i
% Pick a random player
% compute this agent's coverage score **u** if it's on and off (careful : What's HIS coverage score)
% Change the status by the scores of this agent staying on it's status or changing to the other status 
% use T to adjust the tolerance of the benefit loss

% do this process on t vector (each time pick a different player) and plot *total* coverage

% Question need to answer
% 1. 0-1 scoring and value scoring different or same? 

% Assumptions
% 1. Now let Map all positive

%% step 1      
clear all; 
close all; 
clc; 

% convex one zone flag
con_1_f = true; 

%--------------------------------------
% Parameter settings
%--------------------------------------
% size of arena
M = 20; 
N = 16; 
% distribution for resource allocation
mu = 6; 
sigma = 4; 

% interpolated plot's accuracy
interpolation_accuracy = 5; 


% init, Map of interest, assigned values by a normal distribution
% Map = abs(normrnd(mu, sigma, [M, N])); % all positive abs()
Map = zeros(M,N);
Map = drifting_environment( Map, 1, 4, 3, 2, 24); 
% plot the score Map
% mesh(1:M, 1:N, Map); 
% setBigAreaResource_testversion;

% init, Agents and Status
% number of agents
nAgents = 6; 
% set up agents position and status
Agents = [randi(M,[nAgents,1]),randi(N,[nAgents,1])]; % Agents(k, 1) is x, Agents(k, 2) is y

% Status = randi(2,[nAgents, 1])-ones(nAgents, 1); 
Status =ones(nAgents, 1);
% nAgents = 4;
% Agents = [1 1
%     1 N
%     M 1
%     M N];
% Status = randi(2,[nAgents, 1]) - ones(nAgents, 1);

initAgents = Agents; 
initStatus = Status; 

% plot interpolated heatmap 'Map'
fig = figure;
plot_interpolated_Map( Map, interpolation_accuracy );
hold on; 

% plot agents and their status on heatMap 'Map'
plot_agents_and_status(initAgents, initStatus, interpolation_accuracy);
title('init positions'); 
%%

% recover init settings
Agents = initAgents; 
Status = initStatus; 

% set a CoverageMap for this, CoverageMap is defined in
% get_agentscore()
NEG = 1; 
CoverageMap = setCoverageMap(Map, Agents, Status, NEG); 

Coverage_score(1) = get_allscore(Map, CoverageMap, Agents, Status);
% figure, stem(1, Coverage_score(1)); % This Coverage_score(1) will be override then
% hold on; 

% simulation time
Time = 1000; 

% init Traj
Traj_x(:, 1) = Agents(:, 2); 
Traj_y(:, 1) = Agents(:, 1); 
% init Agent select counter
SelectedNum = zeros(nAgents, 1); 

% init Marcopolo status array
exchanged_info_status = zeros(nAgents, 1);

%% step 2
for kk = 1 : 10
    
    % plot init positions in this round
    fig = figure;
    subplot(2,2,1);
    plot_interpolated_Map( Map, interpolation_accuracy );
    hold on; 
    % plot agents and their status on heatMap 'Map'
    plot_agents_and_status(Agents, Status, interpolation_accuracy);
    title('start positions');
    
    drawSingleFlag = 0; 
    drawTrajFlag = 0;
    max_score = 0; 
    
    traj_x_draw_this_round=[];
    traj_y_draw_this_round=[];
    traj_x_draw_this_round(:, 1) = Agents(:, 2); 
    traj_y_draw_this_round(:, 1) = Agents(:, 1); 
    SelectedNum_this_round = zeros(nAgents, 1); 
    
    t = 1; 
    while t <= 1000
        % pick an Agent
        Picked = randi(nAgents, 1); 
        SelectedNum(Picked) = SelectedNum(Picked) + 1;
        SelectedNum_this_round(Picked) = SelectedNum_this_round(Picked) + 1; 
        % --------------------------------------
        % Strategies: 
        % A. ON/ OFF
        % B. move U/D/L/R
        % Only chose one strategy 
        % --------------------------------------
    %     % A. ON/ OFF
    %     % compute his score when ON/OFF 
    %     [V_ON, V_OFF] = get_agentscore(Map, CoverageMap, Agents, Picked); 
    %     % change the Status in probability, and update related data (Map and so
    %     % on) 
    %     T = 10; % parameter
    %     Z = exp(V_ON/T) + exp(V_OFF/T); 
    %     p_ON = exp(V_ON/T) / Z; 
    %     new_Status = binornd(1, p_ON); 
    %     if(Status(Picked) ~= new_Status)
    %         drawSingleFlag = 1; 
    %         Status(Picked) = new_Status; 
    %         CoverageMap = zeros(M, N);
    %         CoverageMap = setCoverageMap(Map, Agents, Status, NEG);
    %     end
    %     drawTrajFlag = 0;

        % B. move U/D/L/R
        % compute his score when going to U/D/L/R
        if(mod(t, 100) == 11)
            exchanged_info_status = zeros(nAgents, 1); 
        end
        [V_Up, V_Down, V_Left, V_Right, V_Stay, Agents, t, exchanged_info_status, Coverage_score] = get_agentscore_B(Map, CoverageMap, Agents, Status, Picked, NEG, con_1_f, t, exchanged_info_status, Coverage_score); 
        T = 10/(t^2)+1; 
        Z = exp(V_Up/T) + exp(V_Down/T) + exp(V_Left/T) + exp(V_Right/T) + exp(V_Stay/T);
        p = [exp(V_Up/T)/Z  exp(V_Down/T)/Z  exp(V_Left/T)/Z  exp(V_Right/T)/Z  exp(V_Stay/T)/Z];
        new_direction = mnrnd(1,p);
        new_Status = 1; 
        if(new_direction(5) ~= 1)% going somewhere
           drawSingleFlag = 1;
           move_direction_number = find(new_direction);
           switch move_direction_number
               case 1
                   Agents(Picked, 1) = Agents(Picked, 1) -1; 
               case 2
                   Agents(Picked, 1) = Agents(Picked, 1) +1;
               case 3
                   Agents(Picked, 2) = Agents(Picked, 2) -1;
               otherwise
                   Agents(Picked, 2) = Agents(Picked, 2) +1;
           end
           CoverageMap = zeros(M, N);
           CoverageMap = setCoverageMap(Map, Agents, Status, NEG);
        end
        % use matrix coordinate for Traj_x
        Traj_x(Picked, SelectedNum(Picked) + 1) = Agents(Picked, 2);
        Traj_y(Picked, SelectedNum(Picked) + 1) = Agents(Picked, 1);
        traj_x_draw_this_round(Picked, SelectedNum_this_round(Picked) + 1) = Agents(Picked, 2);
        traj_y_draw_this_round(Picked, SelectedNum_this_round(Picked) + 1) = Agents(Picked, 1);
        drawTrajFlag = 1;

        Coverage_score(t) = get_allscore(Map, CoverageMap, Agents, Status);

        % find the sensor locations when max score is reached and display it at
        % last
        if(max_score < Coverage_score(t))
            max_t = t; 
            max_score = Coverage_score(t); 
            maxCoverageMap = CoverageMap; 
            maxAgents = Agents; 
            maxStatus=  Status; 
        end

    %     % for debug
    %     subplot(2,2,1);
    %     stem(t+1, Coverage_score(t));
    %     hold on; 
    %     if(t > 1)
    %         stem(t, Coverage_score(t-1)); 
    %     end
    %      
    %     
    %     % plot interpolated heatmap 'Map'
    %     subplot(2,2,2);
    %     plot_interpolated_Map( Map, interpolation_accuracy );
    %     hold on; 
    % 
    %     % plot agents and their status on heatMap 'Map'
    %     plot_agents_and_status(Agents, Status, interpolation_accuracy); 
    %     if(drawSingleFlag == 1)
    %         drawSingleFlag = 0; 
    %         % plot picked agent at this round
    %         plot_single_agent_and_status(Agents(Picked, : ), new_Status, interpolation_accuracy); 
    %     end
    %     
    %     % plot coverage map
    %     subplot(2,2,3);
    %     plot_coverageMap(CoverageMap); 
    %     close all; 
    t = t + 1; 
    end

    %% step 3: plot

    % plt max Map
    % plot interpolated heatmap 'Map'
  
%     subplot(2,2,2);
%     plot_interpolated_Map( Map, interpolation_accuracy );
%     hold on; 
%     % plot agents and their status on heatMap 'Map'
%     plot_agents_and_status(maxAgents, maxStatus, interpolation_accuracy);
%     title('max positions'); 

    subplot(2,2,2);
    plot_interpolated_Map( Map, interpolation_accuracy );
    hold on; 
    % plot agents and their status on heatMap 'Map'
    plot_agents_and_status(Agents, Status, interpolation_accuracy);
    title('end positions'); 

    % plot interpolated heatmap 'Map' and Trajactory
%    fig = figure;
    subplot(2,2,3);
    plot_interpolated_Map( Map, interpolation_accuracy );
    hold on; 
    % draw Trajs
    if(drawTrajFlag == 1)
        for i = 1:nAgents
            drawTraj( traj_x_draw_this_round, traj_y_draw_this_round, i, interpolation_accuracy )
        end
    end
    % plot agents and their status on heatMap 'Map'
    plot_agents_and_status(Agents, Status, interpolation_accuracy);
    title('end positions with traj');

    % stem coverage scores
%    fig = figure;
    subplot(2,2,4);
    stem(Coverage_score);
    title('scores');
    
    % map changing
    % Map = abs(normrnd(mu, sigma, [M, N])); % all positive abs()
    Map = zeros(M,N); 
    Map = drifting_environment( Map, kk, 4, 3, 2, 24); 
end