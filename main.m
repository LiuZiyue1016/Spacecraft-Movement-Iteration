clear; clc;  % 清空工作区和命令窗口

% 定义常数
mu = 398600.5;         % 地心引力常数 (km^3/s^2)
R_E = 6378.145;        % 地球半径 (km)
J2 = 0.00108263;       % J2 阻尼系数
consider_J2 = true;    % 是否考虑 J2 阻尼项

% 初始条件
R0 = [7158.6, -687.006, 158.23];    % 初始位置 (km)
V0 = [0.0501, 3.07425, 0.0134];     % 初始速度 (km/s)
initial_state = [R0'; V0'];         % 初始状态向量（位置和速度结合）

% 定义时间范围和步长
day = 0.5;                        % 天数
tspan = [0, 24*3600 * day];         % 时间范围：秒数
step_rk4 = 5;                        % 四阶Runge-Kutta法固定步长
step_mid = 5;                        % 中点法固定步长
step_euler = 0.01;                  % 欧拉法固定步长
step_adaptrk4 = 5;                  % 自适应龙格-库塔法初始步长
epsilon = 1;                        % 自适应步长方法的误差容忍度

% 定义微分方程
f = @(t,x) [
    x(4); % 速度在x方向的变化
    x(5); % 速度在y方向的变化
    x(6); % 速度在z方向的变化
    - mu/(x(1)^2+x(2)^2+x(3)^2)^(1.5) * x(1) ... % 计算x方向的加速度
    - consider_J2 * (3*J2*R_E^2*mu*x(1)) / (2*(x(1)^2+x(2)^2+x(3)^2)^(2.5)) ...
    * (1 - 5*x(3)^2/(x(1)^2+x(2)^2+x(3)^2)^2); % J2效应影响的x方向加速度

    - mu/(x(1)^2+x(2)^2+x(3)^2)^(1.5) * x(2) ... % 计算y方向的加速度
    - consider_J2 * (3*J2*R_E^2*mu*x(2)) / (2*(x(1)^2+x(2)^2+x(3)^2)^(2.5)) ...
    * (1 - 5*x(3)^2/(x(1)^2+x(2)^2+x(3)^2)^2); % J2效应影响的y方向加速度

    - mu/(x(1)^2+x(2)^2+x(3)^2)^(1.5) * x(3) ... % 计算z方向的加速度
    - consider_J2 * (3*J2*R_E^2*mu*x(3)) / (2*(x(1)^2+x(2)^2+x(3)^2)^(2.5)) ...
    * (3 - 5*x(3)^2/(x(1)^2+x(2)^2+x(3)^2)^2); % J2效应影响的z方向加速度
];

% 使用 ode45 求解微分方程
[t_ode45, sol_ode45] = ode45(f, tspan, initial_state);

% 使用四阶Runge-Kutta方法求解微分方程
[t_rk4, sol_rk4] = runge_kutta_4th(f, tspan, initial_state, step_rk4);

% 中点法求解微分方程
[t_mid, sol_mid] = midpoint(f, initial_state, tspan, step_mid);

% 欧拉法求解微分方程
[t_euler, sol_euler] = euler_method_6d(f, initial_state, tspan(1), step_euler, tspan(2));

% 自适应龙格库塔法求解微分方程
[t_adaptrk4, sol_adaptrk4] = adaptiveRungeKutta(f, tspan(1), initial_state, step_adaptrk4, tspan(2), epsilon);

% 提取位置向量
position_ode45 = sol_ode45(:, 1:3);   % ode45方法计算的位置信息
position_rk4 = sol_rk4(1:3, :)';       % 四阶Runge-Kutta方法计算的位置信息
position_mid = sol_mid(:, 1:3);       % 中点法计算的位置信息
position_euler = sol_euler(1:3, :)';   % 欧拉法计算的位置信息
position_adaptrk4 = sol_adaptrk4(:, 1:3); % 自适应龙格-库塔法计算的位置信息

% 进行结果可视化和比较
% picture生成位置变化图
% animation生成三维轨道路径图/三维轨道路径gif
% compare_picture生成积分法和ode45积分的位置变化比较图

% 对不同方法的结果进行绘图和动画展示
picture(t_ode45, position_ode45); % 绘制ode45的轨迹
animation(R0, position_ode45, t_ode45, 'ode45'); % 动画显示ode45的轨迹

picture(t_rk4, position_rk4); % 绘制RK4的轨迹
animation(R0, position_rk4, t_rk4, 'rk4'); % 动画显示RK4的轨迹
compare_picture(position_ode45, t_ode45, position_rk4, t_rk4); % 比较ode45与RK4的轨迹

picture(t_mid, position_mid); % 绘制中点法的轨迹
animation(R0, position_mid, t_mid, 'mid'); % 动画显示中点法的轨迹
compare_picture(position_ode45, t_ode45, position_mid, t_mid, 'mid'); % 比较ode45与中点法的轨迹

picture(t_euler, position_euler); % 绘制欧拉法的轨迹
animation(R0, position_euler, t_euler, 'euler'); % 动画显示欧拉法的轨迹
compare_picture(position_ode45, t_ode45, position_euler, t_euler, 'euler'); % 比较ode45与欧拉法的轨迹

picture(t_adaptrk4, position_adaptrk4); % 绘制自适应RK的轨迹
animation(R0, position_adaptrk4, t_adaptrk4, 'adaptrk4'); % 动画显示自适应RK的轨迹
compare_picture(position_ode45, t_ode45, position_adaptrk4, t_adaptrk4, 'adaptrk4'); % 比较ode45与自适应RK的轨迹
