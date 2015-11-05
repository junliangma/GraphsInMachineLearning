function [] = plot_clustering_result(X,Y,W,spectral_labels,kmeans_labels)

    set(figure(), 'units', 'centimeters', 'pos', [0 0 30 10]);

    h(1) = subplot(1,3,1);
    plot_edges_and_points(X,Y,W,'ground truth');

    h(2) = subplot(1,3,2);
    plot_edges_and_points(X,spectral_labels,W,'spectral clustering');
    
    h(3) = subplot(1,3,3);
    plot_edges_and_points(X,kmeans_labels,W,'kmeans');

    %linkaxes(h,'y')

    %ylim([-2,2])
