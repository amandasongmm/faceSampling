% Genearate the stimuli sequence txt file for around 900 subjects. 

%% Parameters to tune
face_num = 595; % total number of faces to go over
cover_ratio = 0.5; % cover_ratio of the full combination
pairs_per_HIT = 100; % number of different trials in one HIT, will repeat twice in experimental code.

%% Generate a full combination pair array 
pair_full_array = nchoosek(1:face_num, 2); % a pair-list [n,2] array
full_comb_num = size(pair_full_array, 1);

% switch the sequence within a pair from (A,B) to (B,A)
temp = pair_full_array;
switchSeed = rands(full_comb_num, 1)>0;
pair_full_array(switchSeed, 1) = temp(switchSeed, 2);
pair_full_array(switchSeed, 2) = temp(switchSeed, 1);

%% Take a subset from the full combination array
subset_comb_num = round(full_comb_num * cover_ratio);
subset_ind = randperm(full_comb_num, subset_comb_num); % which pairs will be chose in the 50% subset.
pair_subset_array = pair_full_array(subset_ind, :);

%% Assign each subject 100 pairs, save every 100-pair array in one file.
subject_num = floor(subset_comb_num/ 100); % subjects needed to finish the task.

% Generate one HIT_list for each subject
count = 1; 
for cur_sub = 1 : subject_num
    fileName = sprintf('../filesPublic/vicente_pair_jan/HIT%d.txt',cur_sub);
    fid = fopen(fileName, 'w');
    for curItr = 1 : pairs_per_HIT
        cur_pair_ind = count; 
        cur_pair = pair_subset_array(cur_pair_ind, :);
        str = sprintf('im%d.png,im%d.png',cur_pair(1), cur_pair(2));
        fprintf(fid, '%s\n',str);
        count = count + 1; 
    end
    fclose(fid);
end
save('../filesPublic/vicente_pair_jan/subsamplingInfo.mat','subset_ind','pair_subset_array'); % 235*210*2. #blocks, #trials #pair=2.
save('vicente_jan_pair_subsamplingInfo.mat','subset_ind','pair_subset_array'); 
