function [W,similarities] = build_similarity_graph(graph_type, graph_thresh, X, sigma2)
%  [W, similarities] = build_similarity_graph(graph_type, graph_thresh, X, sigma)
%      Computes the similarity matrix for a given dataset of samples.
%
%  Input
%  graph_type:
%      knn or eps graph, as a string, controls the graph that
%      the function will produce
%  graph_thresh:
%      controls the main parameter of the graph, the number
%      of neighbours k for k-nn, and the threshold eps for epsilon graphs
%  X:
%      (n x m) matrix of m-dimensional samples
%  sigma2:
%      the sigma value for the exponential function, already squared
%
%
%  Output
%  W:
%      (n x n) dimensional matrix representing the adjacency matrix of the graph
%  similarities:
%      (n x n) dimensional matrix containing
%      all the similarities between all points (optional output)


if nargin < 3
    error('build_similarity_graph: not enough arguments')
elseif nargin > 5
    error('build_similarity_graph: too many arguments')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  use similarity function to build full graph (similarities)   %
%  similarities: (n x n) matrix with similarities between       %
%              all possible couples of points                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

similarities = exponential_euclidean(X,sigma2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = size(X,1);

W = zeros(n,n);

% Avoid a node to be his own neighbour
similarities2 = similarities - eye(n);

if strcmp(graph_type,'knn') == 1

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  compute a k-nn graph from the similarities                   %
    %  for each node x_i, a k-nn graph has weights                  %
    %  w_ij = d(x_i,x_j) for the k closest nodes to x_i, and 0      %
    %  for all the k-n remaining nodes                              %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for i = 1:n
        [~, ind] = sort(similarities2(i,:),'descend');
        indKnn = ind(1:graph_thresh);
        W(i,indKnn) = 1;
        W(indKnn,i)= 1;
    end
    W = W .* similarities2;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elseif strcmp(graph_type,'eps') == 1

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  compute an epsilon graph from the similarities               %
    %  for each node x_i, an epsilon graph has weights              %
    %  w_ij = d(x_i,x_j) when w_ij > eps, and 0 otherwise           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    W(similarities2 >= graph_thresh) = similarities2(similarities2 >= graph_thresh);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

else

    error('build_similarity_graph: not a valid graph type')

end
