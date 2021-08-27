f1= @(n,r) r.*n.*(1-n);
f2= @(n,r,nc) r.*n.*(n-nc).*(1-n);

title('$f_1(n)=n(1-n)$','Interpreter','latex')
hold on
r=1;
n=linspace(0,1.2,200);
xline(0,'Color','black','Linewidth',0.08);
yline(0,'Color','black','Linewidth',0.08);
plot(n,f1(n,r),'Color','black');
plot([0],[0],'Color','red','Marker','x','LineStyle','none','Linewidth',1.5);
plot([1],[0],'Color','blue','Marker','o','LineStyle','none','Linewidth',1.5);
xlabel('$n$','Interpreter','latex');
ylabel('$f(n)$','Interpreter','latex');
legend('','','','equilibri instabili', 'equilibri stabili','Location','southwest');
exportgraphics(gcf,'f1.jpg','Resolution',300)

figure
title('$f_2(n)=n\left(n-\frac{1}{2}\right)(1-n)$','Interpreter','latex')
hold on
nc=1/2;
xline(0,'Color','black','Linewidth',0.08);
yline(0,'Color','black','Linewidth',0.08);
plot(n,f2(n,r,nc),'Color','black');
plot([0, 1],[0, 0],'Color','blue','Marker','o','LineStyle','none','Linewidth',1.2);
plot([nc],[0],'Color','red','Marker','x','LineStyle','none','Linewidth',1.2);
xlabel('$n$','Interpreter','latex');
ylabel('$f(n)$','Interpreter','latex');
legend('','','','equilibri stabili', 'equilibri instabili','Location','southwest');
exportgraphics(gcf,'f2.jpg','Resolution',300)