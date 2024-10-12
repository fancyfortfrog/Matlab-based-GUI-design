%%
%%1.参数
R_ave=21/1000;  % 平均半径，有限元中取磁密的半径 /m
Rs=23/1000;  % 定子内半径，Rs = R_ave + g/2, 气隙长度 g = 4/1000
Rm=19/1000;  % 磁极半径，Rm = R_ave - g/2
Rr=15/1000;  % 转子内外半径，Rr = R_ave - hm, 磁极厚度 h = 4/1000
Rt=25/1000;  % 定子槽顶部半径
Rsb=30/1000; % 定子槽底部半径

p=1;% 极对数
ay=pi/p;%永磁体极距,相邻永磁体的中心距,unit is 'rad'
a0=1/p*(pi-2*asin((30^2-((R_ave*1000)^2))/756));% p对极时永磁体的宽度
% a0=1.8367; %永磁体宽度，单位为rad % R_ave=21/1000处的永磁体宽度，单位为rad
ap=a0/ay;       % 极弧系数 ap=tm/tp

Ns=36;   %齿槽个数
theta_s=2*pi/Ns; %定子齿槽极距，两个齿槽之间的间距，与选取半径无关，有槽数有关
theta0=0.05;  %齿槽槽口宽度，单位为rad, theta0 = b/R_ave = 1.05/21
alpha0=theta_s/2;
L=2*pi;    %电机展开长度 0--2*pi
bsa=0.8*(2*pi)/Ns;     %bsa是槽宽角
boa=0.5*bsa;           %boa是槽开口角


%% 使用红色同心圆画永磁体

% 画出永磁体的圆形轮廓
drawarc(Rr,'k');
drawarc(Rm,'k');
% 使用红色填充轮廓内部面积
fillcolor(Rr,Rm,'r');
axis square

%% 使用黑色虚线画气隙

% 靠近圆心的气隙
for i = 1:Ns
    begin=alpha0+(i-1)*theta_s-theta0/2;
    fall=alpha0+(i-1)*theta_s+theta0/2;
    range=linspace(begin,fall,100);
    x=Rs*cos(range);
    y=Rs*sin(range);
    plot(x,y,'k:');
end

% 远离圆心的气隙
for i = 1:Ns
    begin=alpha0+(i-1)*theta_s-theta0/2;
    fall=alpha0+(i-1)*theta_s+theta0/2;
    range=linspace(begin,fall,100);
    x=Rt*cos(range);
    y=Rt*sin(range);
    plot(x,y,'k:');
end


%% 使用红色实现画定子齿部

% 使用黑色直线画出槽底弧线
for i = 1:Ns
    begin=-alpha0+(i-1)*theta_s+theta0/2;
    fall=alpha0+(i-1)*theta_s-theta0/2;
    range=linspace(begin,fall,100);
    x=Rs*cos(range);
    y=Rs*sin(range);
    plot(x,y,'k-');
end

% 使用黑色直线画出径向槽内壁
for i = 1:Ns
    x1=Rs*cos(alpha0+(i-1)*theta_s-theta0/2);
    x2=Rt*cos(alpha0+(i-1)*theta_s-theta0/2);
    x3=Rs*cos(alpha0+(i-1)*theta_s+theta0/2);
    x4=Rt*cos(alpha0+(i-1)*theta_s+theta0/2);
    y1=Rs*sin(alpha0+(i-1)*theta_s-theta0/2);
    y2=Rt*sin(alpha0+(i-1)*theta_s-theta0/2);
    y3=Rs*sin(alpha0+(i-1)*theta_s+theta0/2);
    y4=Rt*sin(alpha0+(i-1)*theta_s+theta0/2);
    plot([x1 x2],[y1 y2],'k',[x3 x4],[y3 y4],'k')
    hold on
end

%% 画定子槽形

% 使用黑色直线画出定子齿部周向弧线
for i = 1:Ns
    begin=alpha0+(i-1)*theta_s-bsa/2;
    fall=alpha0+(i-1)*theta_s+bsa/2;
    range=linspace(begin,fall,100);
    x=Rsb*cos(range);
    y=Rsb*sin(range);
    plot(x,y,'k-');
end

% 使用黑色直线画出定子槽顶周向弧线与定子槽顶到槽底的径向内壁
for i = 1:Ns
    % 画出定子槽顶到槽底的径向内壁
    x1=Rt*cos(alpha0+(i-1)*theta_s-bsa/2);
    x2=Rsb*cos(alpha0+(i-1)*theta_s-bsa/2);
    x3=Rt*cos(alpha0+(i-1)*theta_s+bsa/2);
    x4=Rsb*cos(alpha0+(i-1)*theta_s+bsa/2);
    y1=Rt*sin(alpha0+(i-1)*theta_s-bsa/2);
    y2=Rsb*sin(alpha0+(i-1)*theta_s-bsa/2);
    y3=Rt*sin(alpha0+(i-1)*theta_s+bsa/2);
    y4=Rsb*sin(alpha0+(i-1)*theta_s+bsa/2);
    plot([x1 x2],[y1 y2],'k',[x3 x4],[y3 y4],'k')

    % 画出定子槽顶周向弧线
    range1=linspace(alpha0+(i-1)*theta_s-bsa/2,alpha0+(i-1)*theta_s-theta0/2,100);
    range2=linspace(alpha0+(i-1)*theta_s+theta0/2,alpha0+(i-1)*theta_s+bsa/2,100);
    x5=Rt*cos(range1);
    y5=Rt*sin(range1);
    x6=Rt*cos(range2);
    y6=Rt*sin(range2);
    plot(x5,y5,'k-',x6,y6,'k-')
    hold on
end

%% 定义画布，横纵坐标范围，定义画图函数

xlim([-0.1 0.1]);
ylim([-0.1 0.1]);

function drawarc(r,color)
plot_theta=linspace(0,2*pi,1000);
x=r*cos(plot_theta);
y=r*sin(plot_theta);
plot(x,y,color);
hold on
end

function fillcolor(r1,r2,color)
plot_theta=linspace(0,2*pi,1000);
for i = 1:999
    x1=r1*cos(plot_theta(i));
    y1=r1*sin(plot_theta(i));
    x2=r2*cos(plot_theta(i));
    y2=r2*sin(plot_theta(i));
    x3=r1*cos(plot_theta(i+1));
    y3=r1*sin(plot_theta(i+1));
    x4=r2*cos(plot_theta(i+1));
    y4=r2*sin(plot_theta(i+1));
    x=[x1,x2,x4,x3];
    y=[y1,y2,y4,y3];
    fill(x,y,color,EdgeColor='none');
end
hold on
end
