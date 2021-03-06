function makeHexagons(a,b,h)
%Recupero i valori di biforcazione p_c,k_c
[p_c,k_c]=makeBifurcation2(a,b,h,0);

%Costruisco la griglia di mesh per la visualizzazione a livelli
ext=5*2*pi/k_c; % 5 intervalli di periodicità
x=linspace(-ext,ext,1000);
y=linspace(-ext,ext,1000);
[X,Y]=meshgrid(x,y);

%Scrivo sulla matrice Z i valori della soluzione.
Z=cos(k_c*(sqrt(3)/2.*Y+1/2.*X))+cos(k_c*(sqrt(3)/2.*Y-1/2.*X))+cos(k_c.*X);

%Visualizzazione dei livelli.
figure
hold on
axis('equal')
colormap turbo
%title(strcat('$E(x_1,x_2)\propto \cos\left(k_c \left( \frac{\sqrt{3}}{2}x_2 + \frac{1}{2}x_1 \right)\right)+ \cos\left(k_c \left( \frac{\sqrt{3}}{2}x_2 - \frac{1}{2}x_1 \right)\right) +\cos(k_c x_1):','k_c=',num2str(k_c),'$'),'Interpreter','latex');
contourf(Z);
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% salvataggio immagine
exportgraphics(gcf,'hexaLevels.jpg','Resolution',300);

%Costruisco la griglia di mesh per la visualizzazione dei valori positivi
%(più piccola)
ext=2*2*pi/k_c; % 2 intervalli di periodicità
x=linspace(-ext,ext,1000);
y=linspace(-ext,ext,1000);
[X,Y]=meshgrid(x,y);

%Scrivo sulla matrice Z i valori della soluzione.
Z=cos(k_c*(sqrt(3)/2.*Y+1/2.*X))+cos(k_c*(sqrt(3)/2.*Y-1/2.*X))+cos(k_c.*X);

%Visualizzazione dei valori positivi
figure
%title(strcat('$E(x_1,x_2)\propto \cos\left(k_c \left( \frac{\sqrt{3}}{2}x_2 + \frac{1}{2}x_1 \right)\right)+ \cos\left(k_c \left( \frac{\sqrt{3}}{2}x_2 - \frac{1}{2}x_1 \right)\right) +\cos(k_c x_1):','k_c=',num2str(k_c),'$'),'Interpreter','latex');
axis('equal');
hold on
colormap gray
Z_sp=(Z >= 0);
contour(Z,[-1,-1]);
spy(fliplr(Z_sp));
xlabel('');
% cancellazione dei valori sugli assi
set(gca,'XTick',[]);
set(gca,'YTick',[]);
% legenda
lg=legend('','$E\geq0$');
set(lg,'Interpreter','latex','Location','northeast');
% salvataggio immagine
exportgraphics(gcf,'hexaPositivity.jpg','Resolution',300);
end

