function myWriteNifti(filename, image, spacing)

voxel_size = spacing;
datatype = 16 ; %this option is also there 
nii = make_nii(img, voxel_size, [], datatype);

%OR 
nii.hdr.dime.datatype = 16;
nii.hdr.dime.bitpix = 32;
 
save_nii(nii, filename);
end