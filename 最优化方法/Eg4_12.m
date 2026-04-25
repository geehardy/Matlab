clear; clc;

f= @(x) (x(1)-3)^2 + x(1)*x(2) + x(2)^2 + 1;
gradf = @(x) [2*(x(1)-3)+x(2);x(1)+2*x(2)];
x=[-2;6];   % 初始点选取
tol= 0.02;  % 梯度容许误差
maxIter = 20;   % 最大迭代次数
fprintf('%-3s %-10s %-10s %-10s %-15s\n', ...
        'k', 'x1', 'x2', 'f(x)', '||梯度||');

for k = 1:maxIter
    fx = f(x);
    g  = gradf(x);
    g_norm = norm(g);
    fprintf('%-3d %-10.4f %-10.4f %-10.4f %-15.4e\n', ...
            k-1, x(1), x(2), fx, g_norm);
    if g_norm < tol
        break;
    end
    % 不满足停止条件，迭代
    d = -g;
    alpha=Parabola_means(@(a) f(x+a*d),tol);
    x=x+alpha*d;
end
fprintf('\n========== 最终收敛结果 ==========\n');
fprintf('极小点X*=[%.4f,%.4f]\n',x(1),x(2));
fprintf('极小值f(X*)=%.4f\n',f(x));
fprintf('最终梯度范数= %.2e\n', norm(gradf(x)));
fprintf('总迭代次数=%d\n', k-1);

function [x_min, f_min] = Parabola_means(f, tol)
% x0=0; h=0.5;x1=x0+h; x2=x0+2*h; % 等间距初始点法
x0=0;x1=0.8;x2=1.6; % 随机三点法
% fprintf('x0=%.4f,x1=%.4f,x2=%.4f \n',x0,x1,x2);
    while abs(x2-x0)>tol
        % // 等距三点的插值
        % h=(4*f(x1)-3*f(x0)-f(x2))/(2*f(x1)-f(x0)-f(x2))*h/2;
        % x_ave=x0+h;
        % x0=x_ave;
        % x1=x0+h;
        % x2=x0+2*h;
        % fprintf('x0=%.4f,x1=%.4f,x2=%.4f,h=%.4f \n',x0,x1,x2,h);
    
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
        % fprintf('x0=%.4f,x1=%.4f,x2=%.4f \n',x0,x1,x2);
    end
    x_min=(x0+x2)/2;
    f_min=f(x_min);
end