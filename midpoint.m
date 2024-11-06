function [t, X] = midpoint(f, x0, tspan, dt)
    % x0 - 初始状态向量 [x0; y0; z0; vx0; vy0; vz0]
    % tspan - 积分时间范围 [t0, tf]
    % dt - 时间步长 (s)

    % 定义微分方程

    % 时间向量
    t = tspan(1):dt:tspan(2);
    n = length(t); % 时间步数

    % 初始化状态矩阵
    X = zeros(n, 6);
    X(1, :) = x0'; % 设置初始条件（转置为行向量）

    % 中点法积分
    for i = 1:n-1
        k1 = f(t(i), X(i, :)'); % 计算当前时刻的斜率
        mid_point = X(i, :)' + 0.5 * dt * k1; % 计算中点
        k2 = f(t(i) + 0.5 * dt, mid_point); % 计算中点的斜率
        X(i+1, :) = X(i, :) + dt * k2'; % 更新状态
    end
end
