%% 画单个定子槽型

% tooth1=linspace(0,(theta_s-boa)/2,100);
% tooth2=linspace((theta_s+boa)/2,theta_s,100);
% slot_shoulder1=linspace((theta_s-boa)/2,(theta_s-bsa)/2,100);
% slot_shoulder2=linspace((theta_s+bsa)/2,(theta_s+boa)/2,100);
% slot_bottom=linspace((theta_s-bsa)/2,(theta_s+bsa)/2,100);
% slot_range=linspace(theta_s,0,100);
% x_tooth1=Rs*cos(tooth1);
% y_tooth1=Rs*sin(tooth1);
% x_tooth2=Rs*cos(tooth2);
% y_tooth2=Rs*sin(tooth2);
% x_shoulder1=Rt*cos(slot_shoulder1);
% y_shoulder1=Rt*sin(slot_shoulder1);
% x_shoulder2=Rt*cos(slot_shoulder2);
% y_shoulder2=Rt*sin(slot_shoulder2);
% x_bottom=Rsb*cos(slot_bottom);
% y_bottom=Rsb*sin(slot_bottom);
% x_slot=Rso*cos(slot_range);
% y_slot=Rso*sin(slot_range);
% 
% x_begin=Rs*cos(0);
% y_begin=Rs*sin(0);
% 
% X=[x_tooth1, x_shoulder1, x_bottom, x_shoulder2, x_tooth2, x_slot, x_begin];
% Y=[y_tooth1, y_shoulder1, y_bottom, y_shoulder2, y_tooth2, y_slot, y_begin];
% plot(X,Y,'-k');