classdef MutationStrategies
    properties
        mutation_rate % 变异率
    end

    methods
        % 构造函数，设置变异率
        function obj = MutationStrategies(mutation_rate)
            if nargin > 0
                obj.mutation_rate = mutation_rate;
            else
                obj.mutation_rate = 0.1; % 默认变异率为 0.1
            end
        end

        % 位点变异
        function mutatedIndividual = PointMutation(obj, individual)
            mutatedIndividual = individual; % 复制个体
            for i = 1:size(mutatedIndividual, 1)
                if rand < obj.mutation_rate
                    mutatedIndividual(i, 2) = 10 * rand(1, 1); % 对x坐标变异
                end
                if rand < obj.mutation_rate
                    mutatedIndividual(i, 3) = 10 * rand(1, 1); % 对y坐标变异
                end
            end
        end

        % 逆转变异
        function mutatedIndividual = InversionMutation(obj, individual)
            mutatedIndividual = individual; % 复制个体
            for i = 1:size(mutatedIndividual, 1)
                if rand < obj.mutation_rate
                    idx = sort(randi([2, 3], 1, 2)); % 随机选择两个基因位点
                    mutatedIndividual(i, idx(1):idx(2)) = flip(mutatedIndividual(i, idx(1):idx(2)));
                end
            end
        end

        % 插入变异
        function mutatedIndividual = InsertionMutation(obj, individuals)
            num_individuals = size(individuals, 1);
            mutatedIndividual = individuals; % 复制个体

            for i = 1:num_individuals
                if rand < obj.mutation_rate
                    % 随机选择两个位置
                    idx = randperm(size(mutatedIndividual, 2) - 1, 2); % 避免选择最后一列（编号）
                    idx = sort(idx); % 确保小的索引在前
                    % 执行插入变异
                    gene_to_insert = mutatedIndividual(i, idx(1)); % 选择要插入的基因
                    mutatedIndividual(i, idx(1)) = mutatedIndividual(i, idx(2)); % 移动第二个基因到第一个位置
                    mutatedIndividual(i, idx(2)) = gene_to_insert; % 插入原来的基因到第二个位置
                end
            end
        end

        % 互换变异
        function mutatedIndividual = SwapMutation(obj, individual)
            mutatedIndividual = individual; % 复制个体
            for i = 1:size(mutatedIndividual, 1)
                if rand < obj.mutation_rate
                    idx = randperm(size(mutatedIndividual, 2) - 1, 2) + 1; % 随机选择两个基因位点
                    mutatedIndividual(i, idx) = mutatedIndividual(i, fliplr(idx)); % 交换基因
                end
            end
        end

        % 移动变异
        function mutatedIndividual = ShiftMutation(obj, individual)
            mutatedIndividual = individual; % 复制个体
            for i = 1:size(mutatedIndividual, 1)
                if rand < obj.mutation_rate
                    idx = randi([2, size(mutatedIndividual, 2)]); % 随机选择一个基因位点
                    shift_direction = randi([-1, 1]); % 随机选择向左或向右移动
                    new_idx = idx + shift_direction;
                    % 检查边界条件
                    if new_idx >= 2 && new_idx <= size(mutatedIndividual, 2)
                        % 执行移动操作
                        mutatedIndividual(i, [idx, new_idx]) = mutatedIndividual(i, [new_idx, idx]);
                    end
                end
            end
        end
    end
end
