% function treearraydata = convertbintreetolist(tree);
function  [leftchild,rightchild,parent,datacell,datalevel] = convertbintreetolist(tree);

% Transform tree to list data
%

% Find tree size
sizeoftree = tree.size;

% Initialize cell array
leftchild  = zeros(sizeoftree, 1);
rightchild = zeros(sizeoftree, 1);
parent     = zeros(sizeoftree, 1);
datalevel  = zeros(sizeoftree, 1);

datacell   = cell(sizeoftree,  1);

% Initialize
node = 0;
parentnode(1) = 0;

[leftchild,rightchild,parent,datacell,datalevel,node] = createdata(leftchild,rightchild,parent,datacell,tree,datalevel,node);

% treearraydata.leftchild = leftchild;
% treearraydata.rightchild = rightchild;
% treearraydata.parent     = parent;
% treearraydata.datacell   = datacell;
% treearraydata.datalevel  = datalevel;

function [leftchild,rightchild,parent,datacell,datalevel,node] = createdata(leftchild,rightchild,parent,datacell,tree,datalevel,node);

datacell{node + 1}  = tree.idxs;
datalevel(node + 1) = tree.currentdepth;

if isempty(tree.left) ~= 1 
    leftchild(node + 1) = tree.childleft;
end

if isempty(tree.right) ~= 1 
    rightchild(node + 1) = tree.childright;
end

% fprintf('node = %d \n',node);

if node > 0 
    parent(node + 1) = tree.parentnode;
end

node = node + 1;

% if length(tree.idxs)<=1; return; end;

if isempty(tree.left) && isempty(tree.right); return; end;

% fprintf('node = %d \n', node);
% if node == 15 keyboard; end;

[leftchild,rightchild,parent,datacell,datalevel,node] = createdata(leftchild,rightchild,parent,datacell,tree.left,datalevel,node);
[leftchild,rightchild,parent,datacell,datalevel,node] = createdata(leftchild,rightchild,parent,datacell,tree.right,datalevel,node);





