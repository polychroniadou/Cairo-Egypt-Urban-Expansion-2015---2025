load Cairo_15_3rd_Workspace.mat

inp_image=imread('C:/vasilakos/Cairo_2015/Cairo_Data_2015/Cairo_15_image.tif');

inp_image = double(inp_image); 
y=zeros(10980,10980);


for i = 1:10980
tst = reshape(inp_image(i, :, :), [10980, 9]); 
y(i, :) = results.Network(tst'); 
end


