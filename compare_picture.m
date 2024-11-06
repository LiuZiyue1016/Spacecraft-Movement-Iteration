function compare_picture(position_ode45, t_ode45, position, t, way)
    % 创建 X、Y、Z 轴对比图像
    figure;

    % 绘制 X 轴
    subplot(3, 1, 1);
    hold on;
    plot(t_ode45 / 3600, position_ode45(:, 1), 'r', 'LineWidth', 1.5);
    plot(t / 3600, position(:, 1), 'b', 'LineWidth', 1.5);
    xlabel('时间 (小时)');
    ylabel('X (km)');
    title('X 轴位置对比');
    legend('ode45', way);
    grid on;
    hold off;

    % 绘制 Y 轴
    subplot(3, 1, 2);
    hold on;
    plot(t_ode45 / 3600, position_ode45(:, 2), 'r', 'LineWidth', 1.5);
    plot(t / 3600, position(:, 2), 'b', 'LineWidth', 1.5);
    xlabel('时间 (小时)');
    ylabel('Y (km)');
    title('Y 轴位置对比');
    legend('ode45', way);
    grid on;
    hold off;

    % 绘制 Z 轴
    subplot(3, 1, 3);
    hold on;
    plot(t_ode45 / 3600, position_ode45(:, 3), 'r', 'LineWidth', 1.5);
    plot(t / 3600, position(:, 3), 'b', 'LineWidth', 1.5);
    xlabel('时间 (小时)');
    ylabel('Z (km)');
    title('Z 轴位置对比');
    legend('ode45', way);
    grid on;
    hold off;

    % 调整子图之间的间距
    sgtitle('X, Y, Z 轴位置对比');
end