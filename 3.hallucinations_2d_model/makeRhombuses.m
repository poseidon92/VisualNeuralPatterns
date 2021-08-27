function makeRhombuses(a,b,h)
%Recupero i valori di biforcazione p_c,k_c
[p_c,k_c]=makeBifurcation2(a,b,h,0);

%Costruisco la griglia di mesh per la visualizzazione a livelli
ext=5*2*pi/k_c; % 5 intervalli di periodicità
x=linspace(-ext,ext,1000);
y=linspace(-ext,ext,1000);
[X,Y]=meshgrid(x,y);

%Scrivo sulla matrice Z i valori della soluzione.
phi=pi/3;
Z=cos(k_c.*X)+cos(k_c*X*cos(phi)+k_c*Y*sin(phi));

%Visualizzazione dei livelli.
figure
hold on
axis('equal')
colormap turbo
title(strcat('$E(x,y)\propto \cos(k_c x)+ \cos(k_c x \cos(\varphi) + k_c y \sin(\varphi)): k_c=',num2str(k_c),'\ \varphi= \frac{\pi}{3}$'),'Interpreter','latex');
contourf(Z);
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% salvataggio immagine
exportgraphics(gcf,'rhombLevels.jpg','Resolution',300);

%Costruisco la griglia di mesh per la visualizzazione dei valori positivi
%(più piccola)
ext=2*2*pi/k_c; % 2 intervalli di periodicità
x=linspace(-ext,ext,1000);
y=linspace(-ext,ext,1000);
[X,Y]=meshgrid(x,y);

%Scrivo sulla matrice Z i valori della soluzione.
Z=cos(k_c.*X)+cos(k_c*X*cos(phi)+k_c*Y*sin(phi));

%Visualizzazione dei valori positivi
figure
title(strcat('$E(x,y) \propto \cos(k_c x)+ \cos(k_c y  \sin(\varphi) + k_c x \cos(\varphi)): k_c=',num2str(k_c),'\varphi= \frac{\pi}{3}$'),'Interpreter','latex');
axis('equal');
hold on
Z_sp=(Z >= 0);
spy(Z_sp);
xlabel('');
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% legenda
lg=legend('$E\geq0$');
set(lg,'Interpreter','latex','Location','northeast');
% salvataggio immagine
exportgraphics(gcf,'rhombPositivity.jpg','Resolution',300);
end

