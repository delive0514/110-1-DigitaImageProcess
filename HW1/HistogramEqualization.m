function[] = HistogramEqualization(fileName)
    input =imread(fileName);
    input = rgb2gray(input);
    Cnt = zeros(256,1);
    P = zeros(256,1);
    [row ,column] = size(input);
    for i=1:row
        for j=1:column
             position=input(i,j);
             Cnt(position+1,1)=Cnt(position+1)+1; %for histogram
             P(position+1,1)=Cnt(position+1,1)/(row*column); %for probability
        end
    end
    subplot(2,2,1),imshow(input),title('Input');
    subplot(2,2,2),stem(Cnt);
    Cnts=zeros(256,1);
    sk=zeros(256,1);
    sum=0;
    for i=1:size(P)
        sum=sum+Cnt(i);
            s=sum/(row*column);
            sk(i,1)=round(s*255);
    end
    for k=1:256
        m=sk(k,1);
       Cnts(m+1,1)=Cnts(m+1,1)+Cnt(k,1);
    end
    new=uint8(zeros(row,column));
    for i=1:row
        for j=1:column
            new(i,j)=sk(input(i,j)+1,1);
        end
    end
    subplot(2,2,3),imshow(new),title('Output');
    subplot(2,2,4),stem(Cnts);
    set(gca,'XTickLabel',{'0','0.2','0.4','0.6','0.8','1.0'});
    axis([0 256 0 4000]);
    
end
