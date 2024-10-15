classdef SelectionStrategies
    properties
        strategyType % 当前选择策略的类型
        tournamentSize % 锦标赛大小
    end
    
    methods
        % 构造函数
        function obj = SelectionStrategies(strategyType, tournamentSize)
            if nargin < 1 % 如果没有输入策略类型，默认使用轮盘赌选择
                obj.strategyType = 'roulette';
            else
                obj.strategyType = strategyType;
            end
            
            if nargin < 2 % 如果没有输入锦标赛大小，默认大小为3
                obj.tournamentSize = 3; % 默认锦标赛大小
            else
                obj.tournamentSize = tournamentSize;
            end
        end
        
        % 选择父母的主方法
        function parents = SelectParents(obj, fitness)
            switch obj.strategyType
                case 'roulette'
                    parents = obj.RouletteSelection(fitness);
                case 'tournament'
                    parents = obj.TournamentSelection(fitness);
                case 'elite'
                    parents = obj.EliteSelection(fitness);
                otherwise
                    error('Unknown selection strategy.');
            end
        end
        
        % 轮盘赌选择
        function parents = RouletteSelection(~, fitness)
            num = size(fitness, 1);
            parents = zeros(1, 2);
            totalFitness = sum(fitness(:, 2));
            randomValues = rand(1, 2) * totalFitness;

            for parentNum = 1:2
                tmpSum = 0;
                for i = 1:num
                    tmpSum = tmpSum + fitness(i, 2);
                    if tmpSum >= randomValues(parentNum)
                        parents(parentNum) = fitness(i, 1); % 记录母本编号
                        break;
                    end
                end 
            end
        end
        
        % 锦标赛选择
        function parents = TournamentSelection(obj, fitness)
            numIndividuals = size(fitness, 1);
            parents = zeros(1, 2);

            for parentNum = 1:2
                competitors = randi(numIndividuals, 1, obj.tournamentSize);
                [~, bestIndex] = max(fitness(competitors, 2));
                parents(parentNum) = fitness(competitors(bestIndex), 1);
            end
        end
        
        % 精英选择
        function parents = EliteSelection(~, fitness)
            eliteCount = 2; % 设定精英个体数量
            [~, eliteIndices] = sort(fitness(:, 2), 'descend');
            parents = fitness(eliteIndices(1:eliteCount), 1)'; % 返回前两个最优个体的编号
        end
    end
end
