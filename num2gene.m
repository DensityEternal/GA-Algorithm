function gene = num2gene( xInput )
%��xInput���� ת��Ϊ 12λ�Ļ������(6λ��������+6λС������)
gene = zeros(12, 1);

x = floor( xInput*1000*1000 );%����6λС�� Ȼ��ȡ��

ret = mod(x, 10);
for i = 1: 1: 12
    gene(i) = ret;
    x = floor( (x-ret)/10 );
    ret = mod(x, 10);
end

end

