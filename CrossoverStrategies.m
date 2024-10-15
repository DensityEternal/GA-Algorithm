classdef CrossoverStrategies
    methods (Static)
        function childPopulation = GenerateOffspring(parentPairs, individual, crossoverType)
            numParents = size(parentPairs, 1);
            childPopulation = zeros(numParents * 2, size(individual, 2)); % 每对父母生成两个子代
            
            for i = 1:numParents
                % 对x变量交叉
                if strcmp(crossoverType, 'two-point')
                    genesOfTwoChildren_x = CrossoverStrategies.TwoPointCrossParent(parentPairs(i,:), individual(:, 2));
                else
                    genesOfTwoChildren_x = CrossoverStrategies.CrossParent(parentPairs(i,:), individual(:, 2));
                end
                
                % 对y变量交叉
                if strcmp(crossoverType, 'two-point')
                    genesOfTwoChildren_y = CrossoverStrategies.TwoPointCrossParent(parentPairs(i,:), individual(:, 3));
                else
                    genesOfTwoChildren_y = CrossoverStrategies.CrossParent(parentPairs(i,:), individual(:, 3));
                end

                % 两个子代
                childPopulation(2*i-1, 1) = 2*i-1; % 编号
                childPopulation(2*i-1, 2) = gene2num(genesOfTwoChildren_x); % x坐标
                childPopulation(2*i-1, 3) = gene2num(genesOfTwoChildren_y); % y坐标

                childPopulation(2*i, 1) = 2*i; % 编号
                childPopulation(2*i, 2) = gene2num(genesOfTwoChildren_x); % x坐标
                childPopulation(2*i, 3) = gene2num(genesOfTwoChildren_y); % y坐标
            end
        end
        
        % 双点交叉
        function childGene = TwoPointCrossParent(parent, individualCol)
            % parent = 两个母本的编号
            % individualCol 是一个列向量，包含单个变量（x或y）的个体数据

            % 母本的编号
            parent1Index = parent(1);
            parent2Index = parent(2);
            
            % 母本的变量值 (x 或 y)
            parent1X = individualCol(parent1Index);
            parent2X = individualCol(parent2Index);
            
            % 母本的基因
            parent1Gene = num2gene(parent1X); % 列向量
            parent2Gene = num2gene(parent2X); % 列向量
            
            % 基因长度
            geneLength = length(parent1Gene);
            
            % 交叉点的选择：生成两个不同的随机交叉点
            cut1 = floor(rand(1, 1) * geneLength) + 1;
            cut2 = floor(rand(1, 1) * geneLength) + 1;
            
            % 确保 cut1 < cut2
            if cut1 > cut2
                tmp = cut1;
                cut1 = cut2;
                cut2 = tmp;
            end
            
            % 交叉：在 cut1 和 cut2 之间的基因片段进行交换
            for i = cut1:cut2
                tmp = parent1Gene(i);
                parent1Gene(i) = parent2Gene(i);
                parent2Gene(i) = tmp;
            end
            
            % 生成子代的数值
            child1X = gene2num(parent1Gene);
            child2X = gene2num(parent2Gene);

            % 检查生成的数值是否超出范围
            child1X = CrossoverStrategies.checkBounds(child1X);
            child2X = CrossoverStrategies.checkBounds(child2X);

            % 返回的子代基因
            childGene = [num2gene(child1X); num2gene(child2X)];
        end
        
        % 单点交叉
        function childGene = CrossParent(parent, individualCol)
            % parent=两个母本的编号
            % individualCol是一个列向量，包含单个变量（x或y）的个体数据

            % 母本的编号
            parent1Index = parent(1);
            parent2Index = parent(2);
            
            % 母本的变量值 (x 或 y)
            parent1X = individualCol(parent1Index);
            parent2X = individualCol(parent2Index);
            
            % 母本的基因
            parent1Gene = num2gene(parent1X); % 列向量
            parent2Gene = num2gene(parent2X); % 列向量
            
            % 交叉点的选择
            cut = floor(rand(1, 1) * length(parent1Gene)) + 1; % 随机生成1~基因长度的整数
            
            % 基因交叉
            for i = 1:cut
                tmp = parent1Gene(i);
                parent1Gene(i) = parent2Gene(i);
                parent2Gene(i) = tmp;
            end
            
            % 生成子代的数值
            child1X = gene2num(parent1Gene);
            child2X = gene2num(parent2Gene);

            % 检查生成的数值是否超出范围
            child1X = CrossoverStrategies.checkBounds(child1X);
            child2X = CrossoverStrategies.checkBounds(child2X);

            % 返回的子代基因
            childGene = [num2gene(child1X); num2gene(child2X)];
        end

        % 辅助函数：检查生成的值是否在允许范围内
        function value = checkBounds(value)
            if value < 0 || value > 10
                value = 10 * rand(1, 1); % 随机生成一个合法值
            end
        end
    end
end
