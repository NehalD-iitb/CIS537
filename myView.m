function myView(image , spacing , crosshair , crange , cmap)
%{
myView: Display orthogonal slices through a 3D image
usage:
    myView(image, spacing, crosshair, crange, cmap)
required parameters:
    image 3D image volume
    spacing 3x1 vector of voxel spacings
optional parameters:
    crosshair 3x1 vector giving the crosshair position.
        Defaults to the center of the image.
    crange 1x2 vector giving the range of intensity to be displayed.
        Defaults to [imin imax], where imin and imax are the minimum and maximum
        intensity in the image.
    cmap String, giving the name of the color map
        to use(see colormap). Defaults to 'gray'.
%}

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
   
   slicex = squeeze(image(crosshair(1),:,:));
   slicey = squeeze(image(:,crosshair(2),:));
   slicez = squeeze(image(:,:,crosshair(3)));
   
   figure;
   colormap(cmap)

   subplot(2,2,1)
   imagesc(slicez')
   title(sprintf('z = %d', crosshair(3)), 'FontWeight', 'Normal')
   caxis(crange) 
   daspect([spacing(2), spacing(1), spacing(3)])
   set(gca,'XDir','reverse')
   set(gca,'YDir','normal')

   line(linspace(1, lenx, 2), crosshair(2) .* ones(2, 1), 'Color', 'blue')
   line(crosshair(1) .* ones(2, 1), linspace(1, leny, 2), 'Color', 'blue')
   
   subplot(2,2,2)
   imagesc(slicex')
   title(sprintf('x = %d', crosshair(1)), 'FontWeight', 'Normal')
   caxis(crange) 
   daspect([spacing(2), spacing(3), spacing(1)])
   set(gca,'XDir','reverse')
   set(gca,'YDir','normal')
   line(linspace(1, leny, 2), crosshair(3) .* ones(2, 1), 'Color', 'blue')
   line(crosshair(2) .* ones(2, 1), linspace(1, lenz, 2), 'Color', 'blue')
   
   
   
   subplot(2,2,3)
   imagesc(slicey')
   title(sprintf('y = %d', crosshair(2)), 'FontWeight', 'Normal')
   caxis(crange) 
   daspect([spacing(3), spacing(1), spacing(2)])
   set(gca,'XDir','reverse')
   set(gca,'YDir','normal')
   line(linspace(1, lenx, 2), crosshair(3) .* ones(2, 1), 'Color', 'blue')
   line(crosshair(1) .* ones(2, 1), linspace(1, lenz, 2), 'Color', 'blue')
   


   
   subplot(2,2,4)
   axis off
   caxis(crange)
   p = get(colorbar('southoutside'), 'Position');
   p(2) = 0.15;
   p(4) = 0.03;
   text(0.05, 0.9, sprintf('xhair=[%d %d %d]', crosshair), 'FontSize', 8, 'FontName', 'Courier')
   text(0.05, 0.8, sprintf('dimen=[%d %d %d]', size(image)), 'FontSize', 8, 'FontName', 'Courier')
   set(colorbar('southoutside'), 'Position', p)

