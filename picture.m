function picture(t, position)    
    % 绘制X、Y、Z轴的变化
    figure;
    
    % 绘制X轴变化
    subplot(3, 1, 1);
    plot(t, position(:, 1), 'b-');
    grid on;
    xlabel('时间 (s)');
    ylabel('X (km)');
    title('X轴位置变化');
    
    % 绘制Y轴变化
    subplot(3, 1, 2);
    plot(t, position(:, 2), 'r-');
    grid on;
    xlabel('时间 (s)');
    ylabel('Y (km)');
    title('Y轴位置变化');
    
    % 绘制Z轴变化
    subplot(3, 1, 3);
    plot(t, position(:, 3), 'g-');
    grid on;
    xlabel('时间 (s)');
    ylabel('Z (km)');
    title('Z轴位置变化');
end