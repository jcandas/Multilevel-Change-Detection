function partitions = get_partition_cells(TEST_DATA, tree, MAX_DEPTH)
%
%  function partitions = get_partition_cells(TEST_DATA, tree, MAX_DEPTH)
%
%
if nargin<3,
    MAX_DEPTH = inf;
end

partitions = traverse(TEST_DATA,tree,1,MAX_DEPTH);

function partitions = traverse(TEST_DATA,tree,curr_depth,MAX_DEPTH)

partitions(1:size(TEST_DATA,1),1) = tree;
if curr_depth >=MAX_DEPTH; return; end;
if ~isfield(tree,'left'); return; end;
if isempty(tree.left); return; end;

idx = TEST_DATA*tree.split_dir <= tree.threshold;

if sum(idx)>0
    lparts = traverse(TEST_DATA(idx,:),tree.left,curr_depth+1,MAX_DEPTH);
    partitions(idx) = lparts;
end

if sum(~idx)>0
    rparts = traverse(TEST_DATA(~idx,:),tree.right,curr_depth+1,MAX_DEPTH);
    partitions(~idx) = rparts;
end