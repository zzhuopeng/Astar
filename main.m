%% Astar�㷨ʹ�ã�����mapͨ��excel��á�
clc;clear;
%��ȡ��ͼ��numΪdouble���ͣ�txtΪcell���ͣ�rawΪcell���ͣ�ͬʱ��ȡnum��txt��
[num, txt, raw] = xlsread('map');
%·���滮
[open, close]=Astar(num);