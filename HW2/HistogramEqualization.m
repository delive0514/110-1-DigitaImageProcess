function[] = HistogramEqualization(fileName)
    inputPhoto =imread(fileName);
    inputPhoto = rgb2gray(inputPhoto);
    cnt = zeros(256,1);
    pr = zeros(256,1);
    [row ,column] = size(inputPhoto);
    for ii=1:row
        for jj=1:column
             pos=inputPhoto(ii,jj);
             cnt(pos+1,1)=cnt(pos+1)+1; %for histogram
             pr(pos+1,1)=cnt(pos+1,1)/(row*column); %for probability
        end
    end
    subplot(2,2,1),imshow(inputPhoto),title('Origin Image');
    subplot(2,2,2),stem(cnt);
   
    cnts=zeros(256,1);
    sk=zeros(256,1);
    sum=0;
    for i=1:size(pr)
        sum=sum+cnt(i);
            s=sum/(row*column);
            sk(i,1)=round(s*255);
        
    end
    for k=1:256
        m=sk(k,1);
       cnts(m+1,1)=cnts(m+1,1)+cnt(k,1);
    end
    hnew=uint8(zeros(row,column));
    for i=1:row
        for j=1:column
            hnew(i,j)=sk(inputPhoto(i,j)+1,1);
        end
    end

    subplot(2,2,3),imshow(hnew),title('Result');
    subplot(2,2,4),stem(cnts);
    set(gca,'XTick',0:51:256);
    set(gca,'XTickLabel',{'0','0.2','0.4','0.6','0.8','1.0'});
    axis([0 256 0 3000]);
    
end
