function transform = myTransformImage(fixed, moving, A, b, method)
 
 
%Use the command data=load(’-ascii’,’filename.txt’) to load the matrix A from the file.
 

    [vox_xcoord, vox_ycoord, vox_zcoord] = ndgrid(1:size(fixed,1), 1:size(fixed,2), 1:size(fixed,3));
   
    Xp = ([vox_xcoord(:), vox_ycoord(:), vox_zcoord(:)])';
    
    TXp = A *  Xp + b;
    
    Tvox_xcoord = reshape(TXp(1, :), size(fixed,1), size(fixed,2), size(fixed,3));
    
    Tvox_ycoord = reshape(TXp(2, :), size(fixed,1), size(fixed,2), size(fixed,3));
    
    Tvox_zcoord = reshape(TXp(3, :), size(fixed,1), size(fixed,2), size(fixed,3));
    
    transform = interpn(vox_xcoord, vox_ycoord, vox_zcoord, moving,Tvox_xcoord, Tvox_ycoord, Tvox_zcoord, method, 0);
end
