close all

file = 'frn-150.png'

img = imread(file);
ss = size(img);

Despliega_Img(1, img);

i0 = 570
j0 = 440
del = 7

imgT = img((i0-del):(i0+del), (j0-del):(j0+del));


size(imgT)

vec = double(reshape(imgT, 15*15,1))

me = mean(vec)
sd1 = std(vec)

imgG = zeros(ss(1), ss(2));

for i=(i0-5*del): (i0+5*del)
    for j=(j0-5*del): (j0+5*del)
        if abs(img(i,j) - me) < sd1/2
            imgG(i,j) = 1;
        end
    end
end

img3 = zeros(ss(1), ss(2),3);

img3(:,:,1) = img/ma;


img3(:,:,2) = imgG;

figure(5)
image(img3)