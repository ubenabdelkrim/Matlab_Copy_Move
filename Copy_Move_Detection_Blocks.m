function error = Copy_Move_Detection_Blocks(file)
I=imread(file);
file=file(1:end-4);
file=strcat(file,'_Block_duplicated.tif');
[r c n] = size(I);
block_size = 16;
overlapp = 16;
disp([r c n]);
%% To Do
A = [];
k = 1;

s=8; %half of the size of the block
m=zeros(r, c); % definint the image
b=255*ones(2*s); % definint the block
    
if n > 1
    img=rgb2gray(I);
else
    img=I; % It's already gray.
end
figure, imshow(img);
for i=1:overlapp:(c-block_size)+1
    for j=1:overlapp:(r-block_size)+1
        A(k).block = img(j:j+block_size-1,i:i+block_size-1);
        A(k).position = [j i];
        k = k+1;
    end
end
sz = size(A, 2);
disp(sz);
for i=1:sz
    disp(A(i).position(1));
    for j=1:sz
        if i ~= j
            h = imhist(A(i).block);
            h1 = imhist(A(j).block);
            if sqrt(sum((h-h1).^2)) <= 23
                x=A(i).position(1); y=A(i).position(2); % Position of the centre of the block
                if x-s >0
                    if y-s > 0
                        m(x-s:x+s-1,y-s:y+s-1)=b;
                    end
                end
            end
        end
    end
end
error=0;
%% End To Do
	figure
    imshow(m)
imwrite(I,file);
end

