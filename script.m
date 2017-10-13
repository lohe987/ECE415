[X,map] = imread('img.bmp');
Y=X;
newmap = rgb2gray(map);
imshow(X,newmap)
min=999;
max=0;

for x=1:948
    for y=1:1268
        if( X(x,y) >30 &  X(x,y)<70 |  X(x,y)>90) 
            X(x,y) = X(x,y)*4;
        end
        if (X(x,y) <min)
           min = X(x,y);
        end
        if( X(x,y) > max)
            max = X(x,y);
        end
        
    end
end
imshow(X,newmap) 
% Threshold (0-30)  and (70-90) will retain their values.  
% Every other pixel intensity will be 3 times brighter their original
% values








%% PART 2
hist = zeros(1,255);
for x=1:948
    for y=1:1268
        hist( Y(x,y)) =hist( Y(x,y)) +1;
    end
    
end
x = [1:255];
y = hist;
plot(x,y)    %% HISTORY OF IMAGE:

sum=0;
for i=1:255 %% total 1,081,857 pixels in image.
            %% 5% of total pixel = 60,000 pixels
    if(sum < 60000)        
    sum = sum + hist(i);
    begin_index = i;
    end    
end

%%for i=1:255
%%   if( i<7)
%%       hist(i) = 0;
%%   end
%%   if ( i > 94)
%%        hist(i) = 0;
%%   end
%%end
%%x=[1:255];
%%y=hist;
%%plot(x,y)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum=0;
for i=255:-1:1 %% find end_index cutoff for histogram
    if( sum< 60000)
        sum=sum+hist(i);
        end_index = i;
    end
end
for x=1:948
   for y=1:1268
      Y(x,y) = ((Y(x,y) -begin_index) /( end_index-begin_index)) *(254)+1;
   end
end
imshow(Y,newmap)



%% PART 2, METHOD 2  FIND MOST POPULAR COLOR INTENSITY AND HAVE CUTOFF K=1/3
max=0;
for i=1:255
   if (hist(i) > max)
       max = hist(i);
   end
end
cutoff = max/ 7;
begin_index=0;  end_index=255;
for i=1:255
   if( hist(i) < cutoff)
      begin_index=i;
   else 
        break;
     end
end
for i=255:-1:1
   if( hist(i) < cutoff)
       end_index=i;
   else
       break;
   end
end
for x=1:948
   for y=1:1268
      Y(x,y) = ((Y(x,y) -begin_index) /( end_index-begin_index)) *(254)+1;
   end
end
imshow(Y,newmap)
