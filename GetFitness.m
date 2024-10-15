function fitness = GetFitness( individual )
%计算个体的适应度
a=9;%a是学号
[r, ~] = size(individual);
fitness = zeros(r, 2);
for i = 1: 1: r
    fitness(i, 1) = i;%个体编号
    
    x = individual(i,2);%该个体所对应的坐标x
    y = individual(i,3);%该个体所对应的坐标y
    %适应度=函数值
    fitness(i, 2) = 6.2*(x+a*y).*(cos(x)-cos(a*y)).^2/(0.8+(x-4).^2+2*(y-0.7).^2).^0.5+a*y;
    
end



