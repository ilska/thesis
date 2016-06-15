

% sax_demo();
multivariate_time_serie = actiona1subjects1i1;
alphabet_size = 10 ; % el número de palabras que quiero tener, cuantas divisiones en la amplitud

n = 15; %nseg          = 8;
N = size(multivariate_time_serie,1);%data_len = length(data);
SAX_activity = zeros(n,size(multivariate_time_serie,2));
for i = 1:size(multivariate_time_serie,2)
    data = multivariate_time_serie(:,i);
    [symbolic_data, pointers] =  timeseries2symbol(data, N, n, alphabet_size);
    SAX_vector = symbolic_data';
    SAX_activity(:,i) = SAX_vector;
end
