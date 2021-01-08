

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  load data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PTS = 3000;

DATA = rand(PTS,2);
TEST_DATA = DATA(1:round(PTS*0.1),:);
TRAIN_DATA = DATA(round(PTS*0.1)+1:end,:);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  construct PCA tree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

treeparams.MAX_DEPTH = 8;
treeparams.split_fxn_params.spill = 0.05;

fprintf('Creating PCA partition tree using training data...');
tree = make_tree(TRAIN_DATA,@split_PCA,treeparams);
fprintf('done.\n');

fprintf('Getting partition cells for test data...');
partitions = get_partition_cells(TEST_DATA,tree);
fprintf('done.\n');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  visualize top two levels of the tree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
hold on;
plot(TRAIN_DATA(tree.left.left.idxs,1),TRAIN_DATA(tree.left.left.idxs,2),'r.');
plot(TRAIN_DATA(tree.left.right.idxs,1),TRAIN_DATA(tree.left.right.idxs,2),'go');
plot(TRAIN_DATA(tree.right.left.idxs,1),TRAIN_DATA(tree.right.left.idxs,2),'b+');
plot(TRAIN_DATA(tree.right.right.idxs,1),TRAIN_DATA(tree.right.right.idxs,2),'kx');
title('Visualization of top four cells (two levels)');
xlabel('Press enter to see a query point (and its predicted closest neighbors)');
pause;


for test_point_idx=1:10
    
    hold off;
    
    plot(TRAIN_DATA(tree.left.left.idxs,1),TRAIN_DATA(tree.left.left.idxs,2),'r.');
    hold on;
    
    plot(TRAIN_DATA(tree.left.right.idxs,1),TRAIN_DATA(tree.left.right.idxs,2),'go');
    plot(TRAIN_DATA(tree.right.left.idxs,1),TRAIN_DATA(tree.right.left.idxs,2),'b+');
    plot(TRAIN_DATA(tree.right.right.idxs,1),TRAIN_DATA(tree.right.right.idxs,2),'kx');
    
    title('Visualization of top four cells (two levels)');
    
    plot(TRAIN_DATA(partitions(test_point_idx).idxs,1),TRAIN_DATA(partitions(test_point_idx).idxs,2),'s','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',5);
    plot(TEST_DATA(test_point_idx,1),TEST_DATA(test_point_idx,2),'o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);

    if test_point_idx<10
        xlabel(sprintf('O is a query %d/%d (press enter for next)',test_point_idx,10));
    else
        xlabel(sprintf('O is a query %d/%d',test_point_idx,10));
    end
    pause;
end
