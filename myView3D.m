function myView3D(image, spacing, crosshair, crange, cmap)
   [lenx,leny,lenz] = size(image);
     
   if ~exist('crosshair','var')| isempty(crosshair)
       crosshair = [lenx/2;leny/2;lenz/2];
   end

   if ~exist('crange','var') | isempty(crange)
      imin = min(image(:));
      imax = max(image(:));
      crange = [imin, imax];
   end

   if ~exist('cmap','var') | isempty(cmap)
      cmap = 'gray';
   end

    
    figure
    colormap(cmap)
    h = slice(image,  crosshair(2), crosshair(1),crosshair(3));
    daspect([spacing(1)*spacing(3),spacing(2)*spacing(3), spacing(1)*spacing(2)])
    caxis(crange)
    set(h, 'EdgeColor', 'none')
    set(colorbar('eastoutside'));
    title(sprintf('Crosshair = [%d, %d, %d]', crosshair(1),  crosshair(2),  crosshair(3)))
   
end
