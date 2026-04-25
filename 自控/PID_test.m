Ti=2;%Ti=1时系统不稳定
Td=2.1;%Td=1.8时，系统动态性能下降
Kp=1.4;%分别取Kp=1,1.4和2，观察系统稳定性
num1=[Kp*Ti*Td Kp*Ti Kp];
den1=[Ti 0];
G1=tf(num1,den1);
num2=1;
den2=[1 1 4 0 0];
G2=tf(num2,den2);
G=feedback(G1*G2,1);
t=0:0.2:120;
step(G,t);