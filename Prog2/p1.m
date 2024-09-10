close all

file = 'frn-150.png'

img = imread(file);

figure(1)
imshow(img)

ss = size(img)
min(min(img))
max(max(img))

i0 = 570
j0 = 440
del = 7

imgN = img;
imgN((i0-del):(i0+del), (j0-del):(j0+del)) = 255;

figure(2)
imshow(imgN)

imgT = img((i0-del):(i0+del), (j0-del):(j0+del));

size(imgT)

vec = double(reshape(img, 15*15,1))

me = mean(vec)
sd1 = std(vec)

vx = [];
vy = [];

for i=(i0-2*del): (i0+2*del)
    for j=(j0-2*del): (j0+2*del)
        if abs(img(i,j) - me) < sd1
            vx = [vx, i];
            vy = [vy, j];
        end
    end
end

n = length(vx)

imgN2 = zeros(ss(1), ss(2),1);

for i = 1:n
    imgN2(vx(i), vy(i)) = 255;
end


figure(1)
imshow(imgN2)




