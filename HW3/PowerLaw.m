function[]= PowerLaw(imagePath, gamma)
    Image=imread(imagePath);
    photo=double(Image);
    [row_i,col_i]=size(photo);
    r=0:1:255
    c=1.5;
    s=c*r.^gamma
    output=zeros(row_i,col_i);
    for k=1:256
        for i=1:row_i
            for j=1:col_i
                if photo(i,j)==r(k) 
                    output(i,j)=s(k);
                end
            end
        end
    end
    figure(1)
    subplot(2,1,1);imshow(Image),title('Origin Image');
    subplot(2,1,2);imshow(output/255),title(['Power Law gamma =' num2str(gamma)]);
end
function[Out0, Out1]=HighBoost(imagePath)
    f = double(imagePath);
    [m, n]=size(f);
    Out0 = f;
    for i=3:m-2
        for j=3:n-2
            Out0(i,j) = (-8*f(i,j))+(1*f(i-1,j))+(1*f(i+1,j))+(1*f(i,j-1))+(1*f(i,j+1))...
        +(1*f(i-1,j-1))+(1*f(i+1,j+1))+(1*f(i-1,j+1))+(1*f(i+1,j-1)); 
        end
    end
    %Laplacian filter
    %
    % uint8_J0 = uint8(J0);
    % uint8_I1 = uint8(f) .* (A-1);
    % J1 = uint8_J0 + uint8_I1;
    %
    I1 = f .* (A-1);
    Out1  = Out0 + I1;
end