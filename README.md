# GA-Algorithm

## Question
![image](https://github.com/user-attachments/assets/367e8085-8711-40ac-838f-59136ad07f1e)

## Final Result
<div align="center">
    <img src="https://github.com/user-attachments/assets/906c4d29-ddcb-4192-9451-f2470c016e1f" alt="Final Result" width="400"/>
</div>
The maximum value of the final function `f(x, y)` is around 275.66.


# GA-Algorithm

## Project Introduction
This project is an algorithm for solving multivariate function optimization problems. It is based on the [Intelligent Optimization Algorithms](https://github.com/yangzhen0512/IntelligentOptimizationAlgorithms) project, which has been improved from univariate to multivariate optimization. Various selection, crossover, and mutation operations have been encapsulated.

### Variables to Modify
The variable `a` that needs to be modified in the project includes the following files:
- `main.mlx`
- `GetFitness.m`

### Final Results
By running the optimization algorithm, we found the following global best solution:
The maximum value of the final function `f(x, y)` is around 275.66.

<div align="center">
    <img src="https://github.com/user-attachments/assets/906c4d29-ddcb-4192-9451-f2470c016e1f" alt="Final Results" width="400"/>
</div>


## 项目概述
该项目是基于遗传算法（GA）实现的多元函数极值求解器。项目的灵感来源于 [IntelligentOptimizationAlgorithms](https://github.com/yangzhen0512/IntelligentOptimizationAlgorithms)，我们对其进行了改进，将单变量优化扩展为多变量优化，并封装了各种选择、交叉和变异操作，以提高算法的可读性和灵活性。

## 主要功能
- **多元函数优化**：能够求解多元函数的极值。
- **选择操作**：实现了多种选择策略，包括轮盘赌选择和锦标赛选择。
- **交叉操作**：支持单点交叉和双点交叉。
- **变异操作**：提供多种变异策略，以增强种群的多样性。

## 关键文件
- `main.mlx`：主程序，负责算法的初始化、执行和结果展示。
- `GetFitness.m`：计算每个个体的适应度。
- `CrossoverStrategies.m`：实现交叉操作的类。
- `SelectionStrategies.m`：实现选择操作的类。
- `MutationStrategies.m`：实现变异操作的类。

## 使用方法
1. 确保已安装 MATLAB。
2. 克隆项目代码。
3. 运行 `main.mlx` 文件。
4. 根据需要修改参数，如个体数量、运行次数等。

## 贡献
欢迎提交问题或贡献代码，以帮助改进项目。


