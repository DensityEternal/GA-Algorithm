function fitness = GetFitness( individual )
%����������Ӧ��
a=9;%a��ѧ��
[r, ~] = size(individual);
fitness = zeros(r, 2);
for i = 1: 1: r
    fitness(i, 1) = i;%������
    
    x = individual(i,2);%�ø�������Ӧ������x
    y = individual(i,3);%�ø�������Ӧ������y
    %��Ӧ��=����ֵ
    fitness(i, 2) = 6.2*(x+a*y).*(cos(x)-cos(a*y)).^2/(0.8+(x-4).^2+2*(y-0.7).^2).^0.5+a*y;
    
end



