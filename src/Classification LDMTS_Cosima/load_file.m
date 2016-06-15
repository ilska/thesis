% function to load the file from the filename
function [data]=load_file(file_basename);
data = load(file_basename);
%data =load(sprintf('%s.csv', file_basename));
clear file_basename;
