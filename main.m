%% Astar算法使用，其中map通过excel获得。
clc;clear;
%读取地图：num为double类型，txt为cell类型，raw为cell类型（同时读取num和txt）
[num, txt, raw] = xlsread('map');
%路径规划
[open, close]=Astar(num);