function makeStripes(a,b,h)
%Recupero i valori di biforcazione p_c,k_c
[p_c,k_c]=makeBifurcation2(a,b,h,0);

%Costruisco la griglia di mesh
ext=10*2*pi/k_c; % 10 intervalli di periodicità
x=linspace(-ext,ext,1000);
y=linspace(-ext,ext,1000);
[X,Y]=meshgrid(x,y);

%STRISCE VERTICALI
%Evidenzio i valori positivi della soluzione sui punti della griglia
figure
hold on
%title(strcat('Equilibri $E(x_1,x_2)\propto \cos(k_c x_1):','k_c=',num2str(k_c),'$'),'Interpreter','latex')
Z=(cos(k_c*X) >= 0);
spy(fliplr(Z));
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% legenda
lg=legend('$E\geq0$');
set(lg,'Interpreter','latex','Location','northeast');
% salvataggio immagine
exportgraphics(gcf,'stripes1cortex.jpg','Resolution',300);

%Calcolo l'immagine sulla retina
alpha=1;
beta=1;
figure
hold on
axis('equal');
%title(strcat('Immagine sulla retina $E(x_1,x_2)\propto \cos(k_c x_1):','k_c=',num2str(k_c),'$'),'Interpreter','latex');
for l=1:length(Z)
    if Z(1,l) == 1
        z_ret=1/(2*beta)*exp(1/alpha.*X(:,l)+i.*Y(:,l));
        plot(z_ret,'Color',[0, 0.4470, 0.7410]);
    end
end
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% salvataggio immagine
exportgraphics(gcf,'stripes1retina.jpg','Resolution',300);

%STRISCE ORIZZONTALI
%Evidenzio i valori positivi della soluzione sui punti della griglia
figure
hold on
%title(strcat('Equilibri $E(x_1,x_2)\propto \cos(k_c x_2):','k_c=',num2str(k_c),'$'),'Interpreter','latex')
Z=(cos(k_c*Y) >= 0);
spy(fliplr(Z));
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% legenda
lg=legend('$E\geq0$');
set(lg,'Interpreter','latex','Location','northeast');
% salvataggio immagine
exportgraphics(gcf,'stripes2cortex.jpg','Resolution',300);

%Calcolo l'immagine sulla retina
alpha=1;
beta=1;
figure
hold on
axis([-1e2,1e2,-1e2,1e2]);
%title(strcat('Immagine sulla retina $E(x_1,x_2)\propto \cos(k_c x_2):','k_c=',num2str(k_c),'$'),'Interpreter','latex');
for m=1:length(Z)
    if Z(m,1) == 1
        z_ret=1/(2*beta)*exp(1/alpha.*X(m,:)+i.*Y(m,:));
        plot(z_ret,'Color',[0, 0.4470, 0.7410]);
    end
end
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% salvataggio immagine
exportgraphics(gcf,'stripes2retina.jpg','Resolution',300);

%STRISCE OBLIQUE
%Necessito di una griglia di mesh più fine.
x=linspace(-ext,ext,2000);
y=linspace(-ext,ext,2000);
[X,Y]=meshgrid(x,y);

%Evidenzio i valori positivi della soluzione sui punti della griglia
figure
hold on
phi=pi/3;
%title(strcat('Equilibri $E(x_1,x_2)\propto \cos(k_c x_1 \cos(\varphi) + k_c x_2 \sin(\varphi)):','k_c=',num2str(k_c),'\ \varphi= \frac{\pi}{3}','$'),'Interpreter','latex')
Z=(cos(k_c*X*cos(phi)+k_c*Y*sin(phi)) >= 0);
spy(fliplr(Z));
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% legenda
lg=legend('$E\geq0$');
set(lg,'Interpreter','latex','Location','northeast');
% salvataggio immagine
exportgraphics(gcf,'stripes3cortex.jpg','Resolution',300);

%Calcolo l'immagine sulla retina
alpha=1;
beta=1;
figure
hold on
axis([-1e-2,1e-2,-1e-2,1e-2]);
%title(strcat('Immagine sulla retina $E(x_1,x_2)\propto \cos(k_c x_1 \cos(\varphi) + k_c x_2 \sin(\varphi)):','k_c=',num2str(k_c),'\ \varphi= \frac{\pi}{3}','$'),'Interpreter','latex')
for m=1:length(Z)
    if Z(m,1) == 1
        z_ret=[];
        l=0;
        while l<m
            z_ret(end+1)=1/(2*beta)*exp(1/alpha.*X(m-l,1+l)+i.*Y(m-l,1+l));
            l=l+1;
        end
        plot(z_ret,'Color',[0, 0.4470, 0.7410]);
    end
end
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% salvataggio immagine
exportgraphics(gcf,'stripes3retina.jpg','Resolution',300);

end

