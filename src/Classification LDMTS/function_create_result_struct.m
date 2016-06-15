function [ final_struct ] = function_create_result_struct( statistics_cell, experiment_name )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
final_struct = struct('experiment',experiment_name,'mean_accuracy',statistics_cell.mean_accuracy,'mean_sensitivity',statistics_cell.mean_sensitivity,'mean_specificity',statistics_cell.mean_specificity,'mean_precision',statistics_cell.mean_precision,'mean_recall',statistics_cell.mean_recall,'mean_Fscore',statistics_cell.mean_Fscore);

end

