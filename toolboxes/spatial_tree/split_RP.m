function [left_idxs, right_idxs, threshold, split_dir, proj_data] = split_RP(DATA, params)
if ~isfield(params,'spill')
    params.spill = 0;
end

if ~isfield(params,'boost')
    params.boost = 1;
end


% Unit random vectors boost times
dirs = randn(size(DATA,2),params.boost);
dirs = dirs ./ repmat(sqrt(sum(dirs.*dirs,1)),size(DATA,2),1);

projDATA = DATA * dirs;

% Mean RP Threshold
thresh = median(projDATA,1);

cost = inf;
for i = 1:params.boost
    
    prc = prctile(projDATA(:,i),[0.5-params.spill, 0.5+params.spill]*100);
    
    comm_idx = projDATA(:,i)>prc(1) & projDATA(:,i)<prc(2);
    idx_left = projDATA(:,i) <= thresh(i);
    idx_right = projDATA(:,i) > thresh(i);
    
    ml = median(projDATA(comm_idx|idx_left,i));
    mr = median(projDATA(comm_idx|idx_right,i));
    
    curr_cost = mean([abs(projDATA(comm_idx|idx_left,i) - ml); abs(projDATA(comm_idx|idx_right,i) - mr)]);
    
    if(curr_cost<cost)
        cost = curr_cost;
        split_dir = dirs(:,i);
        threshold = thresh(i);
        left_idxs = idx_left | comm_idx;
        right_idxs = idx_right | comm_idx;
        proj_data = projDATA(:,i);
    end
end

