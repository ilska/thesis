function [U,S,V] = alternative_svd( X )
opts.tol = 1e-3;

[m,n] = size(X);
if  m <= n
    C = X*X';
    [U,D] = eigs(C, size(X,1)-1, 'la', opts);
    clear C;

    [d,ix] = sort(abs(diag(D)),'descend');
    U = U(:,ix);    

    if nargout > 2
        V = X'*U;
        s = sqrt(d);
        V = bsxfun(@(x,c)x./c, V, s');
        S = diag(s);
    end
else
    C = X'*X; 
    [V,D] = eigs(C, size(X,1), 'la', opts);
    clear C;

    [d,ix] = sort(abs(diag(D)),'descend');
    V = V(:,ix);    

    U = X*V; % convert evecs from X'*X to X*X'. the evals are the same.
    %s = sqrt(sum(U.^2,1))';
    s = sqrt(d);
    U = bsxfun(@(x,c)x./c, U, s');
    S = diag(s);
end



end

