clear;clc;
% 抛物线法

f = @(x) (x.^3) - 2*x - 1;
a = -1;
b = 1;
tol = 0.02; % 容忍误差
[x_min, f_min] = Parabola_means(f, tol);
% 打印结果
fprintf('迭代完成！\n');
fprintf('最优解 x = %.4f\n', x_min);
fprintf('极小值 f(x) = %.4f\n', f_min);

% 函数定义
function [x_min, f_min] = Parabola_means(f, tol)
x0=0; h=0.5;x1=x0+h; x2=x0+2*h; % 等间距初始点法
% x0=0;x1=0.8;x2=1.6; % 随机三点法
% fprintf('x0=%.4f,x1=%.4f,x2=%.4f \n',x0,x1,x2);   % 打印初始轮的区间
    while abs(x2-x0)>tol
        % // 等距三点的插值
        % h=(4*f(x1)-3*f(x0)-f(x2))/(2*f(x1)-f(x0)-f(x2))*h/2;
        % x_ave=x0+h;
        % x0=x_ave;
        % x1=x0+h;
        % x2=x0+2*h;
        % fprintf('x0=%.4f,x1=%.4f,x2=%.4f,h=%.4f \n',x0,x1,x2,h);  % 打印循环轮中的区间
    
        % // 任意三点的插值
        if abs(x1-x0) < 1e-12 || abs(x2-x1) < 1e-12
            break;
        end 
        c1=(f(x2)-f(x0))/(x2-x0);
        c2=(c1-(f(x1)-f(x0))/(x1-x0))/(x2-x1);
        if abs(c2) < 1e-12
            break;
        end
        x_ave=(x0+x2-c1/c2)/2;
        if f(x1)<=f(x_ave)
            if x1<=x_ave
                x2=x_ave;
            else 
                x0=x_ave;
            end
        else
            if x1>x_ave
                x2=x1;
                x1=x_ave;
            else 
                x0=x1;
                x1=x_ave;
            end
        end
        % fprintf('x0=%.4f,x1=%.4f,x2=%.4f \n',x0,x1,x2);   % 打印循环轮中的区间
    end
    x_min=(x0+x2)/2;
    f_min=f(x_min);
end