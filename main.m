clc; clear;
a = 9; % 学号

% Step1=指定GA的参数
num = 80; % 个体数量
num_runs = 5; % 设置算法运行次数

% Step2=初始化求解的函数 fun
x = 0:0.01:10; % x=0~10
y = 0:0.01:10; % y=0~10
fun_x_y = 6.2*(x+a*y).*(cos(x)-cos(a*y)).^2/(0.8+(x-4).^2+2*(y-0.7).^2).^0.5+a*y;

% 结果保存
best_solution_all_runs = zeros(num_runs, 3); % 记录每次运行的最优个体 [编号, x, y]
best_fitness_all_runs = -inf * ones(num_runs, 1); % 记录每次运行的最优适应度

for run = 1:num_runs
    hold on;

    % 3) 使用GA求解函数的最大值
    % 随机产生一群个体
    individual = zeros(num, 3); % 每个个体包含[编号, x坐标, y坐标]
    mean_x = 5; % 均值
    std_x = 2;  % 标准差
    mean_y = 5; % 均值
    std_y = 2;  % 标准差

    for i = 1:num
        individual(i, 1) = i; % 个体编号
        individual(i, 2) = normrnd(mean_x, std_x); % x坐标
        individual(i, 3) = normrnd(mean_y, std_y); % y坐标

        % 确保个体在有效范围内
        individual(i, 2) = max(0, min(10, individual(i, 2)));
        individual(i, 3) = max(0, min(10, individual(i, 3)));
    end

    best_fitness = -inf; % 记录最优适应度

    % 初始化存储每代最优个体的数组
    % 记录每代最优个体和适应度
    num_generations = 100; % 设定总的迭代次数
    best_fitness_history = zeros(num_generations, 1); % 存储每代最优适应度
    best_individual_history = zeros(num_generations, 3); % 存储每代最优个体 [编号, x, y]

    for cycle = 1:num_generations % 群体繁殖的循环次数
        % 1) 计算每个个体的适应度值
        fitness = GetFitness(individual);

        % 2) 获取母本组
        parent = zeros(num/2, 2);
        for i = 1:num/2
            parent(i, :) = GetTwoParents(fitness); % 每行=两个母本的编号
        end

        % 3) 交叉生成子代
        tmpParent = zeros(num, 3); % 新的个体群
        for i = 1:num/2
            % 对x变量交叉
            genesOfTwoChildren_x = TwoPointCrossParent(parent(i,:), individual(:, 2));
            % 对y变量交叉
            genesOfTwoChildren_y = TwoPointCrossParent(parent(i,:), individual(:, 3));

            % 两个子代
            tmpParent(2*i-1, 1) = 2*i-1; % 编号
            tmpParent(2*i-1, 2) = gene2num(genesOfTwoChildren_x); % x坐标
            tmpParent(2*i-1, 3) = gene2num(genesOfTwoChildren_y); % y坐标

            tmpParent(2*i, 1) = 2*i; % 编号
            tmpParent(2*i, 2) = gene2num(genesOfTwoChildren_x); % x坐标
            tmpParent(2*i, 3) = gene2num(genesOfTwoChildren_y); % y坐标
        end

        % 变异
        mutation_rate = 0.1; % 设置变异率
        for i = 1:num
            if rand < mutation_rate
                tmpParent(i, 2) = 10 * rand(1, 1); % 对x变异
            end
            if rand < mutation_rate
                tmpParent(i, 3) = 0 + 10 * rand(1, 1); % 对y变异
            end
        end

        % 精英策略
        elite_count = 2; % 设定精英个体数量
        [~, elite_indices] = sort(fitness(:,2), 'descend');
        elite_individuals = individual(elite_indices(1:elite_count), :);

        % 更新个体群体
        individual = [elite_individuals; tmpParent];

        % 找到当前代最优的个体
        [max_fitness, max_index] = max(fitness(:,2)); % 获取当前代的最大适应度及其索引
        if max_fitness > best_fitness
            best_fitness = max_fitness; % 更新最优适应度
            best_individual = individual(max_index, :); % 更新最优个体
        end

        % 记录当前代的最优个体和适应度
        best_fitness_history(cycle) = max_fitness; % 记录适应度
        best_individual_history(cycle, :) = individual(max_index, :); % 记录个体
    end

    % 保存每次运行的最优结果
    best_solution_all_runs(run, :) = best_individual; % 保存最优个体
    best_fitness_all_runs(run) = best_fitness; % 保存最优适应度

    % 可视化当前结果
    figure(1);
    hold on;
    plot3(best_individual(2), best_individual(3), best_fitness, '*r'); % 绘制最优个体
    hold off;
    % 可选：绘制每代最优适应度的变化
    figure(2);
    plot(1:num_generations, best_fitness_history);
    xlabel('Generation');
    ylabel('Best Fitness');
    title('Best Fitness Over Generations');
    grid on;
end

% 找到最优的解
[global_best_fitness, best_run_index] = max(best_fitness_all_runs);
global_best_solution = best_solution_all_runs(best_run_index, :);

fprintf('Global best solution found: x = %.2f, y = %.2f, Fitness = %.2f\n', ...
    global_best_solution(2), global_best_solution(3), global_best_fitness);


