
clear;
close all;

%% Model Parameters

model.y = [0 0 0 1 1 0 0 1 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 0 0 0 0 1 1 0 0 1 0 0]; % The protein
model.l = numel(model.y);
model.c_kmc =  2;   % Monte Carlo cooling coeff
model.c_kga = .3;   % G     A     cooling coeff

global EVALS
EVALS = 0;

%% Initialization 

maxGens = 30;      % Number of generations
N = 200;            % Population size of each generation
M = 1;              % Number of monte carlo steps befor GA
coolEvery = 5;      % Number of generations between cooling down
factor_mc = .97;    % Cooling factor for monte carlo step
factor_ga = .99;    % Cooling factor for G     A     step

empty_indiv.s	= zeros(1, model.l - 1);    % Protein Sequence
empty_indiv.e	= 0;                        % Protein Energy

pop = repmat(empty_indiv, N, 1);

% Generate the first population
for i = 1:N
    pop(i).s = rndProtein(model);
    pop(i).e = energy(pop(i).s, model);    
end

% Sort population
costs = [pop.e];
[costs, sortOrder] = sort(costs);
pop = pop(sortOrder);

% Update best solution ever found
bestSol = pop(1);

% Array to hold best cost values
bestCost = zeros(maxGens, 1);

% Array to hold number of evaluations
evals = zeros(maxGens, 1);

%% Main Loop

for g = 1:maxGens
    
  % MONTE CARLO STEP
    for m = 1:M
        for i = 1:N
            pop(i).s = monteCarlo(pop(i).s, model);
            pop(i).e = energy(pop(i).s, model);
        end
    end
        
  % GENETIC ALGORITHM STEP
    
    % Population for new offsprings
    popCross = repmat(empty_indiv, N - 1, 1);
    
    % Compute roulette wheel probabilities
    p = [pop.e] / sum([pop.e]);
    c = cumsum(p);
    
    k = 1; % popCross counter
    
    % Generate N - 1 new offsprings
    while (k <= N - 1)
        while 1
            % Choose two parents        
            i1 = find(rand() <= c, 1, 'first');
            i2 = find(rand() <= c, 1, 'first');
            p1 = pop(i1);
            p2 = pop(i2);

            % Apply crossover
            offspring = empty_indiv;
            [offspring.s, err] = crossover(p1.s, p2.s, model);
            offspring.e = energy(offspring.s, model);

            % If a valid confirmation found continue else, 
            % try two new parents
            if (err == 0)
                break;
            end
        end

        e_avg = (p1.e + p2.e) / 2;

        % Check for acceptance criterion 
        if ( (offspring.e <= e_avg) || ...
             (rand() < exp((e_avg - offspring.e) / model.c_kga)) )

            popCross(k) = offspring;    
            k = k + 1;
        end        
    end
    
    % Merge population
    pop = [pop 
           popCross];
       
    % Sort population
    costs = [pop.e];
    [costs, sortOrder] = sort(costs);
    pop = pop(sortOrder);
    
    % Truancate extra memebrs
    pop = pop(1:N);
    costs = costs(1:N);
    
    if (pop(1).e <= bestSol.e)
        % Update best solution ever found
        bestSol = pop(1);

        % Update best cost ever found
        bestCost(g) = bestSol.e;
    end
    
    % Cool down the cooling coefficients
    if ( mod(g, coolEvery) == 0 )
        model.c_kmc = factor_mc * model.c_kmc;
        model.c_kga = factor_ga * model.c_kga;
    end
    
    % Update number of evaluations
    evals(g) = EVALS;
    
    % Show generation information
    disp(['Generation ' num2str(g) ': Evals = ' num2str(evals(g)) ', Min Energy = ' num2str(bestCost(g))]);
end
