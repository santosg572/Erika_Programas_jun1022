function Despliega_Img(n, img)
img = double(img);
ma = max(max(img))
img = img/ma;
figure(n)
imshow(img)

