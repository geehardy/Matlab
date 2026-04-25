clear; clc;

f=@(x) x.^4-2.*x.^2+1;   
df=@(x) 4*x.^3-4*x;
d2f=@(x) 12*x.^2-4;           
x=-10; % 初始点选取
tol= 1e-6; % 收敛精度
max_iter= 50;   % 最大迭代次数
iter= 1;
while iter <= max_iter
    % 当前参数
    fx  = f(x);
    g   = df(x);
    G   = d2f(x);
    if abs(g) < tol
        break;
    end
    % 迭代过程
    d = -g / G;   
    alpha=Parabola_means(@(a) f(x+a*d),tol);
    x = x + alpha * d;
    iter = iter + 1;
end
fprintf('\n========== 最终收敛结果 ==========\n');
fprintf('最优点x*=%.4f\n',x);
fprintf('极小值f(x*)=%.4f\n',f(x));
fprintf('迭代总次数=%d\n',iter-1);

% 函数定义
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