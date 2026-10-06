clear all

load y_out.mat
y_100=y*100;
A=int32(y_100);

t=Tiff('Cairo_15_urban_map.tif', 'W');
tagstruct.ImageLength=size(A,1);
tagstruct.ImageWidth=size(A,2);
tagstruct.Compression=Tiff.Compression.None;
tagstruct.SampleFormat=Tiff.SampleFormat.Int;
tagstruct.Photometric=Tiff.Photometric.MinIsBlack;
tagstruct.BitsPerSample=32;
tagstruct.SamplesPerPixel=1;
tagstruct.PlanarConfiguration=Tiff.PlanarConfiguration.Chunky;
t.setTag(tagstruct);
t.write(A);
t.close ();