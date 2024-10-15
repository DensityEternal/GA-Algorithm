function individual = GenerateIndividuals(num, mean_x, std_x, mean_y, std_y)
    % 生成个体的函数
    % 默认参数
    if nargin < 1
        num = 80; % 默认个体数量
    end
    if nargin < 2
        mean_x = 5; % 默认x均值
    end
    if nargin < 3
        std_x = 2;  % 默认x标准差
    end
    if nargin < 4
        mean_y = 5; % 默认y均值
    end
    if nargin < 5
        std_y = 2;  % 默认y标准差
    end

    % 初始化个体数组
    individual = zeros(num, 3); % 每个个体包含[编号, x坐标, y坐标]

    for i = 1:num
        individual(i, 1) = i; % 个体编号
        individual(i, 2) = normrnd(mean_x, std_x); % x坐标
        individual(i, 3) = normrnd(mean_y, std_y); % y坐标

        % 确保个体在有效范围内
        individual(i, 2) = max(0, min(10, individual(i, 2)));
        individual(i, 3) = max(0, min(10, individual(i, 3)));
    end
end
