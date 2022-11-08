clc
clear all
close all

[file,path]=uigetfile('./Dataset/*.tif','Open image');
file_path=(strcat(path,file));
disp(file_path);
%error=Copy_Move_Detection_Blocks(file_path);
error=Copy_Move_Detection_KeyPoints(file_path);
