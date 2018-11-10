function myViewInSNAP(image, spacing)

    
    tmpName = [tempname ,'.nii'];
    myWriteNifti(tmpName, image, spacing);
    command = sprintf('%s -g %s', 'C:\Program Files\ITK-SNAP 3.6\bin\ITK-SNAP.exe', tmpName);
    system(command);
    delete(tmpName);
end