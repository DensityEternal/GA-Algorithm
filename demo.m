% 定义函数
f = @(x, y) (6.2 * (x + 9 * y) .* (cos(x) - cos(9 * y)).^2) ./ ...
    sqrt(0.8 + (x - 4).^2 + 2 * (y - 0.7).^2) + 9 * y;

% 创建 x 和 y 的网格，范围在 (0, 10)
x = linspace(0, 10, 1000);
y = linspace(0, 10, 1000);
[X, Y] = meshgrid(x, y);

% 计算函数值
Z = f(X, Y);

% 找到最大值
max_value = max(Z(:));
[max_row, max_col] = find(Z == max_value);
max_x = X(max_row, max_col);
max_y = Y(max_row, max_col);

% 显示结果
disp(['最大值为: ', num2str(max_value)]);
disp(['发生在 x = ', num2str(max_x), ', y = ', num2str(max_y)]);
