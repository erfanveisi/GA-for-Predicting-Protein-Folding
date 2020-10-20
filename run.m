clc;

%% Start running
tic;
main;
elapsed = toc;

%% Results
fprintf('\nElapsed time = %.2f seconds\n', elapsed);

bestSol

fig = paintProtein(bestSol.s, model);
fig

figure;
plot(evals, bestCost, 'LineWidth', 2);
xlabel('Evaluations');
ylabel('Minimum Energy');