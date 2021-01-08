function [tree,DATA] = make_tree(DATA,split_function,params)
%
%  function [tree] = make_tree(DATA,split_function,params)
%  Create Random Projection Tree
%  Reorganizes tree also

if nargin < 2;  split_function = @split_PCA; end
if nargin < 3;  params = []; end
if ~isfield(params,'MAX_DEPTH'); params.MAX_DEPTH = 15; end
if ~isfield(params,'split_fxn_params');
    split_fxn_params.spill = 0;
    params.split_fxn_params = split_fxn_params;
end

% Initialize first node
node = 0;

% Create tree
[tree, node,DATA] = create_tree(DATA,1:size(DATA,1),split_function,params.indexsetsize,params.split_fxn_params, params.MAX_DEPTH,1,node);
tree.size = node;


function [tree, node, DATA] = create_tree(DATA,idxs,split_function,indexsetsize,split_fxn_params, MAX_DEPTH,curr_depth,node)

% disp(['ixds = ',num2str(idxs)]);

tree.idxs = idxs;
tree.left = [];
tree.right = [];
tree.threshold = NaN;
tree.split_dir = NaN;
tree.proj_data = [];
tree.center = mean(DATA(idxs,:));
tree.idxsmax = max(DATA(idxs,:));
tree.idxsmin = min(DATA(idxs,:));

% Add depth to each node
tree.currentdepth = curr_depth - 1;

% Add node numbering
tree.node = node;
parentnode = node;
% fprintf('Current node = %d \n',tree.node);

% increase node
node = node + 1;
cellinfo = cell(1);

if curr_depth >= MAX_DEPTH; 
    %cellinfo{1} = tree; 
    %treelist = [treelist; cellinfo]; 
    return; end;
if length(idxs)<= (ceil(indexsetsize + 1 )); 
    %cellinfo{1} = tree;
    %treelist = [treelist; cellinfo]; 
    return; 
end;

[idx_left, idx_right, threshold, split_dir, proj_data] = split_function(DATA(idxs,:), split_fxn_params);

left_idxs = idxs(idx_left);
right_idxs = idxs(idx_right);

% Reorder nodes and data
% size_left  = length(left_idxs);
% size_right = length(right_idxs);
% 
% startnum = min(idxs);
% endnum = max(idxs);
% 
% DATA(startnum : endnum, :) = [DATA(left_idxs,:); DATA(right_idxs,:)]; 
% left_idxs = startnum : startnum + size_left - 1;
% right_idxs = startnum + size_left : endnum;


% Test
if length(left_idxs) < indexsetsize  || length(right_idxs) < indexsetsize return; end


% Split
tree.childleft = node;
[tree.left, node]  = create_tree(DATA,left_idxs ,split_function,indexsetsize,split_fxn_params,MAX_DEPTH,curr_depth+1,node);

tree.childright = node;
[tree.right, node] = create_tree(DATA,right_idxs,split_function,indexsetsize,split_fxn_params,MAX_DEPTH,curr_depth+1,node);



tree.threshold = threshold;
tree.split_dir = split_dir;
tree.proj_data = proj_data;

% Add information on parent node
tree.left.parentnode  = parentnode;
tree.right.parentnode = parentnode;






