function [] = LowPassFilter(path,radius)
    image = imread(path);
    image = double(image);
    [M, B]=size(image); 
    R=radius;  
    x=0:B-1;
    y=0:M-1;
    
    tx = -(B/2):B/2-1;
    ty = -(M/2):M/2-1;
    [tX, tY] = meshgrid(tx,ty);
    
    [X, Y]=meshgrid(x,y);
    LowPath2 = tX.* tY;
    Cx=0.5*B;
    Cy=0.5*M;
    LoPath =(R-sqrt((X-Cx).^2+(Y-Cy).^2))/R;
    
    for i=1:M
        for j=1:B
            if (LoPath(i,j)<0)
                LoPath(i,j) =0;
            end
        end
    end
    LowPath2 = LowPath2.* 0;
    LowPath2 = LowPath2 + 1;
    LowPath2 = LowPath2 .* LoPath;
    freImageTran = fftshift(fft2(image));
    LoFre = fftshift(fft2(LoPath)); 
    
    filterImage = freImageTran .* LoPath;
    final = ifftshift(filterImage);
    final = ifft2(final);
    
    subplot(2,3,1);
    imshow(image/255);
    subplot(2,3,2);   
    imshow(log(1+abs(freImageTran)),[]);
    subplot(2,3,3);
    imshow(LoPath);
    subplot(2,3,4);
    imshow(abs(final)/255);
    subplot(2,3,5);
    surf(tX, tY, LowPath2);
    xlim([-300 300]) 
    ylim([-300 300])
    subplot(2,3,6);
    imshow(log(1+abs(LoFre)),[]);
end