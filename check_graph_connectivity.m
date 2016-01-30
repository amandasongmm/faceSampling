% check_graph_connectivity.m

% first, generate a connection matrix. 

load('vicente_jan_pair_subsamplingInfo.mat'); % get the pair_subset_array

% find the max index in the array. 
max_ind = max(pair_subset_array(:));

% make an adjacency matrix.
adjacency_matrix = zeros(max_ind);
for curItr = 1 : size(pair_subset_array, 1)
    cur_pair = pair_subset_array(curItr, :);
    adjacency_matrix(cur_pair(1),cur_pair(2)) = 1;
    adjacency_matrix(cur_pair(2),cur_pair(1)) = 1;
end

% check connectivity.
conncheckie=checkc(adjacency_matrix);
if conncheckie == 1
    fprintf('connected');
else fprintf('Not connected, needs attention.')
end