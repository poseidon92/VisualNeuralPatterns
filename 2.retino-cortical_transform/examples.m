alpha=1;
beta=1;

%Primo esempio: circonferenze concentriche
theta=linspace(0,2*pi,100);
rho1=0.5*ones(1,100);
rho2=0.6*ones(1,100);
rho3=ones(1,100);
rho4=1.1*ones(1,100);
rho5=1.5*ones(1,100);
rho6=1.6*ones(1,100);
% immagine sulla retina
polarplot(theta,rho1,'Color','#1a237e');
hold on
title('Immagine sulla retina','Interpreter','latex');
polarplot(theta,rho2,'Color','#1a237e');
polarplot(theta,rho3,'Color','#304ffe');
polarplot(theta,rho4,'Color','#304ffe');
polarplot(theta,rho5,'Color','#9fa8da');
polarplot(theta,rho6,'Color','#9fa8da');
exportgraphics(gca,'circonferenze_retina.jpg','Resolution',300);
% immagine corticale
[x1,y1]=retinaToCortex(theta,rho1,alpha,beta);
[x2,y2]=retinaToCortex(theta,rho2,alpha,beta);
[x3,y3]=retinaToCortex(theta,rho3,alpha,beta);
[x4,y4]=retinaToCortex(theta,rho4,alpha,beta);
[x5,y5]=retinaToCortex(theta,rho5,alpha,beta);
[x6,y6]=retinaToCortex(theta,rho6,alpha,beta);
figure
hold on
axis([min(x1)-0.05,max(x6)+0.05,min(y1),max(y1)]);
title(strcat('Corrispettiva immagine corticale: parametri $\alpha=',num2str(alpha),', \ \beta=',num2str(beta),'$'),'Interpreter','latex');
plot(x1,y1,'Color','#1a237e');
plot(x2,y2,'Color','#1a237e');
plot(x3,y3,'Color','#304ffe');
plot(x4,y4,'Color','#304ffe');
plot(x5,y5,'Color','#9fa8da');
plot(x6,y6,'Color','#9fa8da');
exportgraphics(gca,'circonferenze_cortex.jpg','Resolution',300);

%Secondo esempio: spirali
rho=linspace(0,1,200);
theta1=linspace(0,4*pi,200);
theta2=linspace(-pi/6,4*pi-pi/6,200);
theta3=linspace(pi/2,4*pi+pi/2,200);
theta4=linspace(2*pi/6,4*pi+2*pi/6,200);
theta5=linspace(pi,4*pi+pi,200);
theta6=linspace(5*pi/6,4*pi+5*pi/6,200);
% immagine sulla retina
figure
polarplot(theta1,rho,'Color','#1a237e');
hold on
title('Immagine sulla retina','Interpreter','latex');
polarplot(theta2,rho,'Color','#1a237e');
polarplot(theta3,rho,'Color','#304ffe');
polarplot(theta4,rho,'Color','#304ffe');
polarplot(theta5,rho,'Color','#9fa8da');
polarplot(theta6,rho,'Color','#9fa8da');
exportgraphics(gca,'spirali_retina.jpg','Resolution',300);
% immagine corticale
[x1,y1]=retinaToCortex(theta1,rho,alpha,beta);
[x2,y2]=retinaToCortex(theta2,rho,alpha,beta);
[x3,y3]=retinaToCortex(theta3,rho,alpha,beta);
[x4,y4]=retinaToCortex(theta4,rho,alpha,beta);
[x5,y5]=retinaToCortex(theta5,rho,alpha,beta);
[x6,y6]=retinaToCortex(theta6,rho,alpha,beta);
figure
hold on
axis([min(x1)-0.05,max(x6)+0.05,min(y1),max(y1)]);
title(strcat('Corrispettiva immagine corticale: parametri $\alpha=',num2str(alpha),', \ \beta=',num2str(beta),'$'),'Interpreter','latex');
plot(x1,y1,'Color','#1a237e');
plot(x2,y2,'Color','#1a237e');
plot(x3,y3,'Color','#304ffe');
plot(x4,y4,'Color','#304ffe');
plot(x5,y5,'Color','#9fa8da');
plot(x6,y6,'Color','#9fa8da');
exportgraphics(gca,'spirali_cortex.jpg','Resolution',300);

%Terzo esempio: raggi
n=36;
theta=zeros(100,n);
rho=linspace(0,1,100);
for k=1:n
    theta(:,k)=k*2*pi/n*ones(1,100);
end
% immagine sulla retina
figure
polarplot(theta(:,1),rho);
hold on
title('Immagine sulla retina','Interpreter','latex');
for k=2:n
    polarplot(theta(:,k),rho)
end
exportgraphics(gca,'raggi_retina.jpg','Resolution',300);
% immagine corticale
figure
hold on
title(strcat('Corrispettiva immagine corticale: parametri $\alpha=',num2str(alpha),', \ \beta=',num2str(beta),'$'),'Interpreter','latex');
for k=2:n
    [x,y]=retinaToCortex(theta(:,k),rho,alpha,beta);
    plot(x,y)
end
exportgraphics(gca,'raggi_cortex.jpg','Resolution',300);

    