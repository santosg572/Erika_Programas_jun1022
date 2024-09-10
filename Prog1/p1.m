file = 'R022-d1-c2'
patO = strcat("/vagrant/", file)
mkdir(patO)

patI = strcat("/vagrant/Erika_may3122_VIDEOS_LAM/", file, ".mp4")

obj = VideoReader(patI);
vid = read(obj);
frames = obj.NumberOfFrames

file = strcat(patO, '/frn-',num2str(7),'.png')

for x = 1 : frames
    imwrite(vid(:,:,:,x),strcat(patO,'/frame-',num2str(x),'.png'));
end






