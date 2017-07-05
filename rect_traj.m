function [ trajx, trajy ] = rect_traj( M, N, d )

trajx1 = d:M-(d-1);
trajx2 = (M-(d-1)) * ones(1,N-2*d);
trajx3 = fliplr(d:(M-(d-1))); 
trajx4 = d*ones(1,N-2*d);
trajx = [trajx1, trajx2, trajx3, trajx4]; 


trajy1 = d * ones(1, M-2*(d-1));
trajy2 = (d+1):N-d;
trajy3 = (N-(d-1)) * ones(1, M-2*(d-1)); 
trajy4 = fliplr((d+1):(N-d));
trajy = [trajy1, trajy2, trajy3, trajy4]; 

end

