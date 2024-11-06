function [t, y] = adaptiveRungeKutta(f, t0, y0, h, t_end, epsilon)
    % 自适应步长四阶龙格-库塔法
    t = t0;          % 当前时间
    y = y0;          % 当前状态
    time = t0;       % 时间向量
    state = y0';     % 状态向量

    h_min = 1e-6;    % 最小步长
    h_max = 100;     % 最大步长
    last_acceptance_time = t; % 上次接受的时间

    while t < t_end
        % 计算单步四阶龙格-库塔
        k1 = h * f(t, y);
        k2 = h * f(t + h/2, y + k1/2);
        k3 = h * f(t + h/2, y + k2/2);
        k4 = h * f(t + h, y + k3);
        y_single = y + (k1 + 2*k2 + 2*k3 + k4) / 6;

        % 计算双步（使用一半的步长）
        h_half = h / 2;
        k1_half = h_half * f(t, y);
        k2_half = h_half * f(t + h_half/2, y + k1_half/2);
        k3_half = h_half * f(t + h_half/2, y + k2_half/2);
        k4_half = h_half * f(t + h_half, y + k3_half);
        y_double = y + (k1_half + 2*k2_half + 2*k3_half + k4_half) / 6;

        % 误差估计
        error = norm(y_single - y_double); 

        % 误差判断与步长调整
        if error < epsilon
            y = y_single;              % 接受当前步长结果
            t = t + h;                 % 更新时间
            time(end + 1) = t;         % 记录时间
            state(end + 1, :) = y';    % 记录状态

            % 增大步长，控制增幅
            h = min(h * 1.5, h_max);   % 增大步长，最大不超过 h_max

            % 检查是否已经达到时间更新
            if t - last_acceptance_time > 10  % 例如，10秒后再记录
                last_acceptance_time = t; % 更新接受时间
            end
        else
            % 减小步长，控制减幅
            h = max(h / 1.5, h_min);   % 减小步长，最小不小于 h_min
        end
    end

    % 输出结果
    t = time;
    y = state;
end
