clear
clc
%% Institude: HuaZhong University of Science and Technology
% 机构： 华中科技大学电气与电子工程学院
%% Written by Xu Shouyu
% 作者： 徐首彧
% 指导老师： 叶才勇
%% 1.参数

Rsi=30;                % 转子轴承半径
R_ave=(55*2-3)/2;      % 平均半径，有限元中取磁密的半径 /m
Rs=57;                 % 定子内半径，Rs = R_ave + g/2, 气隙长度 g = 4/1000
Rm=55;                 % 磁极半径，Rm = R_ave - g/2
Rr=52;                 % 转子内半径，Rr = R_ave - hm, 磁极厚度 h = 4/1000
Rt=57+2.8;             % 定子槽顶部半径
Rsb=100-3.7;           % 定子槽底部半径
Rso=100;               % 定子外半径

% Rsi=0.030;                  % 转子轴承半径
% Rr=0.063;                   % 转子内半径，Rr = R_ave - hm, 磁极厚度 h = 4/1000
% Rm=0.0705;                  % 磁极半径，Rm = R_ave - g/2
% Rs=0.075;                   % 定子内半径，Rs = R_ave + g/2, 气隙长度 g = 4/1000
% Rt=0.0768;                  % 定子槽顶部半径
% Rsb=0.109;                  % 定子槽底部半径
% boa=0.0347;                 % boa是槽开口角
% bsa=0.0737;                 % bsa是槽宽角
% Rso=0.11;                   % 定子外半径
% ap=0.7;                     % 极弧系数

p=5;                   %极对数
ay=pi/p;               %永磁体极距,相邻永磁体的中心距,unit is 'rad'
a0=(Rr+Rm)*ay/2;       %p对极时永磁体的宽度
% a0=1.8367;           %永磁体宽度，单位为rad % R_ave=21/1000处的永磁体宽度，单位为rad
% ap=a0/ay;              %极弧系数 ap=tm/tp

Ns=12;                 %齿槽个数
theta_s=2*pi/Ns;       %定子齿槽极距，两个齿槽之间的间距，与选取半径无关，有槽数有关
theta0=0.05;           %齿槽槽口宽度，单位为rad, theta0 = b/R_ave = 1.05/21
alpha0=theta_s/2;      %第一个定子槽中心位置的角度
L=2*pi;                %电机展开长度 0--2*pi
bsa=0.8*(2*pi)/Ns;     %bsa是槽宽角
boa=0.213*bsa;         %boa是槽开口角

u0=4*pi*1e-7;  %真空磁导率
ur=1;          %PM的相对磁导率，解析模型的假设
Br=1.23;       %PM的剩磁/T，有限元中使用钕铁硼材料的剩磁密度
f=500;         %频率为500Hz
wr=2*pi*f;     %角频率
t=0;           %转子转动的时刻
%在这组参数下，最大谐波次数取值。减小Rr,Rm,Rs半径间的差别，影响不大
N=50;          %气隙及磁极谐波次
M=50;          %齿槽谐波次数取值数取值。在这组参数下，最大谐波次数取值。减小Rr,Rm,Rs半径间的差别，影响不大
k=1000;        %谐波次数

%% 画全部定子槽型
subplot(1,2,1);
hold on
axis square
for i = 1:Ns
    ty=(i-1)*theta_s;
    tooth1=linspace(0+ty,(theta_s-boa)/2+ty,100);
    tooth2=linspace((theta_s+boa)/2+ty,theta_s+ty,100);
    slot_shoulder1=linspace((theta_s-boa)/2+ty,(theta_s-bsa)/2+ty,100);
    slot_shoulder2=linspace((theta_s+bsa)/2+ty,(theta_s+boa)/2+ty,100);
    slot_bottom=linspace((theta_s-bsa)/2+ty,(theta_s+bsa)/2+ty,100);
    slot_range=linspace(theta_s+ty,0+ty,100);
    x_tooth1=Rs*cos(tooth1);
    y_tooth1=Rs*sin(tooth1);
    x_tooth2=Rs*cos(tooth2);
    y_tooth2=Rs*sin(tooth2);
    x_shoulder1=Rt*cos(slot_shoulder1);
    y_shoulder1=Rt*sin(slot_shoulder1);
    x_shoulder2=Rt*cos(slot_shoulder2);
    y_shoulder2=Rt*sin(slot_shoulder2);
    x_bottom=Rsb*cos(slot_bottom);
    y_bottom=Rsb*sin(slot_bottom);
    x_top=Rt*cos(slot_bottom);
    y_top=Rt*sin(slot_bottom);
    x_slot=Rso*cos(slot_range);
    y_slot=Rso*sin(slot_range);

    x_begin=Rs*cos(0+ty);
    y_begin=Rs*sin(0+ty);

    X1=[x_tooth1, x_shoulder1, x_bottom, x_shoulder2, x_tooth2];
    Y1=[y_tooth1, y_shoulder1, y_bottom, y_shoulder2, y_tooth2];
    plot(X1,Y1,'-k',x_slot,y_slot,'-k');
    plot(Rs*cos(linspace((theta_s-boa)/2+ty,(theta_s+boa)/2+ty,50)),Rs*sin(linspace((theta_s-boa)/2+ty,(theta_s+boa)/2+ty,50)),'k:')
    plot(Rt*cos(linspace((theta_s-boa)/2+ty,(theta_s+boa)/2+ty,50)),Rt*sin(linspace((theta_s-boa)/2+ty,(theta_s+boa)/2+ty,50)),'k:')
%   plot([Rs*cos((theta_s-boa)/2+ty), Rs*cos((theta_s+boa)/2+ty)], [Rs*sin((theta_s-boa)/2+ty), Rs*sin((theta_s+boa)/2+ty)],'k:');
%   plot([Rt*cos((theta_s-boa)/2+ty), Rt*cos((theta_s+boa)/2+ty)], [Rt*sin((theta_s-boa)/2+ty), Rt*sin((theta_s+boa)/2+ty)],'k:');

    X=[x_tooth1, x_shoulder1, x_bottom, x_shoulder2, x_tooth2, x_slot, x_begin];
    Y=[y_tooth1, y_shoulder1, y_bottom, y_shoulder2, y_tooth2, y_slot, y_begin];
    fill(X,Y,[1, 0, 0],EdgeColor='none')
    hold on
end

%% 画转子及转轴

th=linspace(0,2*pi,1000);
x_rotor_outter=Rm*cos(th);
y_rotor_outter=Rm*sin(th);
x_rotor_inner=Rr*cos(th);
y_rotor_inner=Rr*sin(th);
x_si=Rsi*cos(th);
y_si=Rsi*sin(th);
x1=[x_rotor_outter, x_rotor_inner, Rm*cos(0)];
y1=[y_rotor_outter, y_rotor_inner, Rm*sin(0)];
x2=[x_rotor_inner, x_si,Rr*cos(0)];
y2=[y_rotor_inner, y_si,Rr*sin(0)];
plot(x_rotor_outter,y_rotor_outter,'-k');
plot(x_rotor_inner,y_rotor_inner,'-k');
plot(x_si,y_si,'-k');
fill(x1, y1,[0, 1, 0],EdgeColor='none');
fill(x2, y2,[0, 1, 1],EdgeColor='none');
fill(x_si, y_si,[0.7451, 0.7451, 0.7451],EdgeColor='k');

xlim([-110,110]);
ylim([-110,110]);
title("电机径向切面图")
%% 画轴向电机剖面
subplot(1,2,2);
L=100;
x_total=[-L/2, -L/2, L/2, L/2];
x_winding=[-L/2-30, -L/2-30, -L/2, -L/2];
x_winding1=-x_winding;

y_spin=[-Rsi, Rsi, Rsi, -Rsi];

y_rotor=[Rsi,Rr,Rr,Rsi];
y_rotor1=-y_rotor;

y_PM=[Rr,Rm,Rm,Rr];
y_PM1=-y_PM;

y_stator=[Rs,Rso,Rso,Rs];
y_stator1=-y_stator;

y_winding=[Rt,Rsb,Rsb,Rt];
y_winding1=-y_winding;

% 画转轴截面
fill(x_total+[-50,-50,50,50], y_spin,[0.7451, 0.7451, 0.7451],'EdgeColor','k');
hold on
% 画转子截面
fill(x_total, y_rotor,[0, 1, 1],EdgeColor='k');
fill(x_total, y_rotor1,[0, 1, 1],EdgeColor='k');
hold on
% 画永磁体截面
fill(x_total, y_PM,[0, 1, 0],EdgeColor='k');
fill(x_total, y_PM1,[0, 1, 0],EdgeColor='k');
hold on
% 画定子截面
fill(x_total, y_stator,[1, 0, 0],EdgeColor='k');
fill(x_total, y_stator1,[1, 0, 0],EdgeColor='k');
hold on
% 画定子槽形及绕组
fill(x_winding, y_winding,[1, 1, 0],EdgeColor='k');
fill(x_winding, y_winding1,[1, 1, 0],EdgeColor='k');
fill(x_winding1, y_winding,[1, 1, 0],EdgeColor='k');
fill(x_winding1, y_winding1,[1, 1, 0],EdgeColor='k');
hold on
% 画横纵虚线
plot([-110,110],[0,0],':k',[0,0],[-110,110],':k');

axis square
xlim([-110,110]);
ylim([-110,110]);
title("电机切向切面图")