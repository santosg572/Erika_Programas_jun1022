
folder = 'R022-d1-c2'
patI = "/vagrant/";

patO = strcat(patI, folder, '-nuevo')
mkdir(patO)

j1 = 200
del = 450

numfiles =1798

for i = 1:numfiles
    file = strcat(patI, folder,'/frame-',num2str(i),'.png')
    I = imread(file);
    size(I)
    I = I(:,:,1);
    I = I(1:del,j1:(j1+del-1));
    J = histeq(I);
    fileo = strcat(patO, '/frn-',num2str(i),'.png');
    imwrite(J, fileo);
end

%figure
%subplot(1,2,1)
%imshow(J)
%subplot(1,2,2)
%imhist(J,64)
