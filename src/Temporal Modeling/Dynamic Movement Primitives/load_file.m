

%% This function loads the data of the provided filepath.
% Depending of the filetype, load is not valid, and is has to be changed
% You may have to search over your code, the alternative to load has been
% used somewhere.


function [data]=load_file(file_basename);
data = load(file_basename);
%data =load(sprintf('%s.csv', file_basename));
clear file_basename;
