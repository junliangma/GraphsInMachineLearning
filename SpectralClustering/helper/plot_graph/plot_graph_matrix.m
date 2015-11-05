function [] = plot_graph_matrix(X,W)

    set(figure(), 'units', 'centimeters', 'pos', [0 0 30 10]);

    h(1) = subplot(1,3,1);
    plot_edges_and_points(X,ones(size(X,1),1),W,'graph');

    h(2) = subplot(1,3,2);
    imagesc(W);
    title('weight magnitude')
    
    h(3) = subplot(1,3,3);
    spy(W);
    if is_connected(W)
        title('non zero elements: the graph is connected');
    else
        title('non zero elements: the graph is not connected');
    end

