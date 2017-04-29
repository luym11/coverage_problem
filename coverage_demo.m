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

% init, Map of interest, assigned values by a normal distribution
Map = abs(normrnd(10, 4, [10, 10])); % all positive abs()
% plot the score Map
% mesh(1:10, 1:10, Map); 

% init, Agents and Status
Agents = [randperm(10,10)',randperm(10,10)']; % Agents(k, 1) is x, Agents(k, 2) is y
Status = randi(2,[10, 1])-ones(10, 1); 

% set a CoverageMap for this, CoverageMap is defined in
% get_agentscore()
CoverageMap = setCoverageMap(Map, Agents, Status); 

Coverage_score(1) = get_allscore(Map, CoverageMap, Agents, Status);
figure, stem(1, Coverage_score(1)); % This Coverage_score(1) will be override then
hold on; 

%% step 2
Time = 100; 
for t = 1 : Time
    % pick an Agent
    Picked = randi(10, 1); 
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
        CoverageMap = setCoverageMap(Map, Agents, Status);
    end
    Coverage_score(t) = get_allscore(Map, CoverageMap, Agents, Status);
    stem(t+1, Coverage_score(t)); 
end

