function [left_idxs, right_idxs, threshold, split_dir, proj_data] = split_MD_KD(DATA, params)
if ~isfield(params,'spill')
    params.spill = 0;
end

dir = zeros(size(DATA,2),1);
vrs = var(DATA,0,1);
[~,v] = max(vrs);
dir(v)=1;

% disp('New Vector');
% disp(dir);


projDATA = DATA * dir;
thresh = 0.5;

idx_left  = projDATA <= thresh;
idx_right = projDATA > thresh;

split_dir = dir;
threshold = thresh;
left_idxs = idx_left;
right_idxs = idx_right;
proj_data = projDATA;