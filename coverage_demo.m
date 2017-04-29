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

%--------------------------------------
% Parameter settings
%--------------------------------------
% size of arena
M = 10; 
N = 16; 
% distribution for resource allocation
mu = 10; 
sigma = 4; 

% interpolated plot's accuracy
interpolation_accuracy = 5; 


% init, Map of interest, assigned values by a normal distribution
Map = abs(normrnd(mu, sigma, [M, N])); % all positive abs()
% plot the score Map
% mesh(1:M, 1:N, Map); 

% init, Agents and Status
% number of agents
nAgents = 12; 
% set up agents position and status
Agents = [randi(M,[nAgents,1]),randi(N,[nAgents,1])]; % Agents(k, 1) is x, Agents(k, 2) is y
Status = randi(2,[nAgents, 1])-ones(nAgents, 1); 
% nAgents = 4; 
% Agents = [1 1
%     1 N
%     M 1
%     M N];
% Status = randi(2,[nAgents, 1]) - ones(nAgents, 1);

% set a CoverageMap for this, CoverageMap is defined in
% get_agentscore()
NEG = 2; 
CoverageMap = setCoverageMap(Map, Agents, Status, NEG); 

Coverage_score(1) = get_allscore(Map, CoverageMap, Agents, Status);
figure, stem(1, Coverage_score(1)); % This Coverage_score(1) will be override then
hold on; 

%% step 2
Time = 100; 
for t = 1 : Time
    % pick an Agent
    Picked = randi(nAgents, 1); 
    % compute his score when ON/OFF 
    [V_ON, V_OFF] = get_agentscore(Map, CoverageMap, Agents, Picked); 
    % change the Status in probability, and update related data (Map and so
    % on) 
    T = 10; % parameter
    Z = exp(V_ON/T) + exp(V_OFF/T); 
    p_ON = exp(V_ON/T) / Z; 
    new_Status = binornd(1, p_ON); 
    if(Status(Picked) ~= new_Status)
        Status(Picked) = new_Status; 
        CoverageMap = setCoverageMap(Map, Agents, Status, NEG);
    end
    Coverage_score(t) = get_allscore(Map, CoverageMap, Agents, Status);
    stem(t+1, Coverage_score(t)); 
end

%% step 3: plot
% plot interpolated heatmap 'Map'

plot_interpolated_Map( Map, interpolation_accuracy );
hold on; 

% plot agents and their status on heatMap 'Map'
plot_agents_and_status(Agents, Status, interpolation_accuracy);
