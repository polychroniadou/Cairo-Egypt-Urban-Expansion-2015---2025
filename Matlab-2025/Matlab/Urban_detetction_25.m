clear all

load Cairo_25_workspace.mat

inp_image=imread('C:/vasilakos/Caior_2025/Cairo_25_image.tif');

inp_image = double(inp_image); 
y=zeros(10980,10980);


for i = 1:10980
tst = reshape(inp_image(i, :, :), [10980, 9]); 
y(i, :) = results.Network(tst'); 
end

