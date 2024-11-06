function  animation(R0, position, t, filename)
    % 创建轨道动画
    figure;
    hold on;
    grid on;
    xlabel('X (km)');
    ylabel('Y (km)');
    zlabel('Z (km)');
    title('轨道路径');
    plot3(R0(1), R0(2), R0(3), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % 起始点
    view(3); % 设置视角
    axis equal; % 坐标轴比例相等

    % 初始化 GIF 文件
    frames = [];  % 存储帧数据
    gif_name = filename + '.gif';

    % 动画循环
    for i = 1:length(t)
        % 绘制 ode45 当前轨道点
        plot3(position(i, 1), position(i, 2), position(i, 3), 'k.', 'MarkerSize', 10);

        % 捕捉当前帧
        frame = getframe(gcf);
        frames = [frames; frame];  % 存储当前帧

        pause(0.01); % 暂停以创建动画效果
    end

    hold off;

    % 保存动画为 GIF
    for k = 1:length(frames)
        [A, map] = frame2im(frames(k));
        [A, map] = rgb2ind(A, 256);
        if k == 1
            imwrite(A, map, gif_name, 'gif', 'LoopCount', inf, 'DelayTime', 0.01); % 设置延迟时间
        else
            imwrite(A, map, gif_name, 'gif', 'WriteMode', 'append', 'DelayTime', 0.01); % 追加帧
        end
    end

    figure;
    hold on;
    grid on;
    xlabel('X (km)');
    ylabel('Y (km)');
    zlabel('Z (km)');
    title('轨道路径');
    
    % 绘制起始点
    plot3(R0(1), R0(2), R0(3), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % 起始点
    
    % 绘制轨道点
    plot3(position(:, 1), position(:, 2), position(:, 3), 'k.', 'MarkerSize', 5);

    % 设置视角和坐标轴比例
    view(3); % 设置三维视角
    axis equal; % 坐标轴比例相等

    % 保存图像
    saveas(gcf, filename + '.svg'); % 保存为指定文件名的图像
    hold off;
end
    