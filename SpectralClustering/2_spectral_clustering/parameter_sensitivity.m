function [] = parameter_sensitivity()
%  [] = parameter_sensitivity()
%     a skeleton function to test spectral clustering
%     sensitivity to parameter choice

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choose the type of the graph to build and the respective      %
% threshold candidates and similarity function options          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%graph_type = 'knn';
%parameter_candidate = 1:5:50; % the number of neighbours for the graph

 graph_type = 'eps';
 parameter_candidate = 0.05:0.05:0.9 ;% the epsilon threshold

sigma2 = 1; % exponential_euclidean's sigma^2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% the number of samples to generate
num_samples = 500;

%%%%%%%%%%% the sample distribution function with the options necessary for
%%%%%%%%%%% the distribution
sample_dist = @two_moons;
dist_options = [1, 0.02] ; % two moons: radius of the moons, variance of the moons



for i = 1:length(parameter_candidate)

    [X, Y] = get_samples(sample_dist, num_samples, dist_options);
    num_classes = length(unique(Y));
    
    graph_thresh = parameter_candidate(i); 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % use the build_similarity_graph function to build the graph W  %
    % W: (n x n) dimensional matrix representing                    %
    %    the adjacency matrix of the graph                          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    W = build_similarity_graph(graph_type,graph_thresh,X,sigma2);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % build the laplacian                                          %%
    % L: (n x n) dimensional matrix representing                    %
    %    the Laplacian of the graph                                 %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    L = diag(sum(W,1)) - W;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute clustering                                        %%%%%
    % Y_rec = (n x 1) cluster assignments [1,2,...,c]               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Y_rec = spectral_clustering_adaptive(L,num_classes);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    parameter_performance(i) = ari(Y,Y_rec);

end

plot(parameter_candidate, parameter_performance);
title('parameter sensitivity')



