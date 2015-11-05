function [] = plot_similarity_graph()
%  [] = plot_similarity_graph()
%      a skeleton function to analyze the construction of the graph similarity
%      matrix, needs to be completed

%%%%%%%%%%% the number of samples to generate
num_samples = 150;

%%%%%%%%%%% the sample distribution function with the options necessary for
%%%%%%%%%%% the distribution
sample_dist = @blobs;
dist_options = [1, 1, 0]; % blobs: number of blobs, variance of gaussian
%                                    blob, surplus of samples in first blob

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  choose the type of the graph to build and the respective     %
%  threshold and similarity function options                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%graph_type = 'knn';
%%%graph_thresh = 3 ; % the number of neighbours for the graph

graph_type = 'eps';
graph_thresh = 0.3; % the epsilon threshold

sigma2 = 1 ; % exponential_euclidean's sigma^2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X, Y] = get_samples(sample_dist, num_samples, dist_options);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use the build_similarity_graph function to build the graph W  %
% W: (n x n) dimensional matrix representing                    %
%    the adjacency matrix of the graph                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W = build_similarity_graph(graph_type,graph_thresh,X,sigma2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot_graph_matrix(X,W);

