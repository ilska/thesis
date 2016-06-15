

function result_data = change_data_format(data)

the_normalized_they_store = data;
iras_final_normalize_joint = zeros(size(the_normalized_they_store,3),60);
for ira_frame=1:size(the_normalized_they_store,3)
    iras_frame = the_normalized_they_store(:,:,ira_frame);
    contador = 1;
    for ira_col=1:20
        col = iras_frame(:,ira_col);
        transformed = col';
        iras_final_normalize_joint(ira_frame,contador:contador+2) = transformed;
        contador = contador +3;
    end
end
result_data = iras_final_normalize_joint;


