function [t, x] = euler_method_6d(f, x0, t0, h, t_end)
    % 欧拉法求解六维常微分方程
    % 输入:
    %   f     : 微分方程右侧的函数句柄（如 @(t, x) ...）
    %   x0    : 初始状态向量
    %   t0    : 初始时间
    %   h     : 步长
    %   t_end : 结束时间
    % 输出:
    %   t : 时间值数组
    %   x  : 状态值数组

    % 初始化
    n_steps = (t_end - t0) / h;  % 计算步数
    n_vars = length(x0);          % 状态向量的维数
    t = zeros(1, n_steps + 1);
    x = zeros(n_vars, n_steps + 1);

    % 设置初始值
    t(1) = t0;
    x(:, 1) = x0;

    % 欧拉法迭代
    for n = 1:n_steps
        x(:, n + 1) = x(:, n) + h * f(t(n), x(:, n));
        t(n + 1) = t(n) + h;
    end
end
