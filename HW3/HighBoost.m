function[]=HighBoost(imagePath)
    f = imread(imagePath);
    k = uint8(50);
    H = fspecial('gaussian',[31 31],5);
    blur = imfilter(f,H,'replicate');    
    Out1  = f - blur;
    Out2  = f + 1*(Out1);
    Out3  = f + k*(Out1);
    figure(1)
    subplot(2,3,1),imshow(f),title('orginal image');    
    subplot(2,3,2),imshow(blur),title('blurred image');
    subplot(2,3,3),imshow(Out1,[-255,255]),title('mask');
    subplot(2,3,4),imshow(Out2),title('k=1');
    subplot(2,3,6),imshow(Out3),title('k=4.5');
    class(Out1)
end