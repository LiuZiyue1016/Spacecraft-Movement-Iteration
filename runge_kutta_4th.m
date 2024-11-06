function [t, x] = runge_kutta_4th(f, tspan, x0, h)
    % f: 微分方程（向量形式），函数句柄形式，如 @(t, x) [x(4); x(5); ...]
    % tspan: 时间范围 [t0, tf]
    % x0: 初始条件向量 [x0, y0, z0, vx0, vy0, vz0]
    % h: 步长
    
    % 初始化时间变量
    t = tspan(1):h:tspan(2);
    n = length(t);
    
    % 初始化解矩阵
    x = zeros(length(x0), n);
    x(:, 1) = x0;
    
    % 使用四阶Runge-Kutta法进行积分
    for i = 1:n-1
        k1 = h * f(t(i), x(:, i));
        k2 = h * f(t(i) + h/2, x(:, i) + k1/2);
        k3 = h * f(t(i) + h/2, x(:, i) + k2/2);
        k4 = h * f(t(i) + h, x(:, i) + k3);
        
        x(:, i+1) = x(:, i) + (k1 + 2*k2 + 2*k3 + k4) / 6;
    end
end
