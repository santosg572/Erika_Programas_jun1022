folder = 'R022-d1-c2'
patI = "/vagrant/";

file = "/frame-1.png"

fileI = strcat(patI, folder, file)

img = imread(fileI);

ss = size(img);
nx = ss(1)
ny = ss(2)

j1 = 200
del = 450

img = img(1:del,j1:(j1+del));

image(img)
