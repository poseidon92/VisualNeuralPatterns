function [w,W] = makeKernel(b1,b2,d1,d2,plt)
ext=20;
ext_W=3;
%Controllo di validità dei parametri
if b1 <= b2 || d1 >= d2
    exit('kernel non della forma cercata')
end
if b1*d1-b2*d2 >= 0
    exit('kernel non valido: mancata negatività in 0 di W.');
end

%Costruzione del nucleo e relativa trasformata di Fourier
w_E=@(z) b1.*exp(-(z./d1).^2);
w_I=@(z) b2.*exp(-(z./d2).^2);
w=@(z) w_E(z)-w_I(z); 
W=@(k) sqrt(pi).*(b1.*d1.*exp(-((d1.*k).^2)/4)-b2.*d2.*exp(-((d2.*k).^2)/4));

%Plotting delle curve ottenute
z=linspace(-ext,ext,1000);
lims=[-ext,ext,min(w(z)),b1];
if plt==1
    hold on
    axis(lims);
    xlabel('$z$','Interpreter','latex');
    str_we=strcat('$w_E(z)=',num2str(b1),'e^{- \left(\frac{z}{',num2str(d1),'}\right)^2};');
    str_wi=strcat('w_I(z)=',num2str(b2),'e^{- \left(\frac{z}{',num2str(d2),'}\right)^2}$');
    tstr=strcat(str_we , str_wi);
    title(tstr,'Interpreter','latex');
    xline(0,'Color','black','Linewidth',0.08);
    yline(0,'Color','black','Linewidth',0.08);
    fplot(w_E, 'Color', 'red');
    fplot(w_I, 'Color', 'blue');
    lg=legend('','','$w_E$','$w_I$');
    set(lg,'Interpreter','latex','Location','northeast');
    exportgraphics(gcf,'kernel1.jpg','Resolution',300);
    
    figure
    hold on
    title('Nucleo di convoluzione $w(z)$','Interpreter','latex')
    xlabel('$z$','Interpreter','latex');
    axis(lims)
    xline(0,'Color','black','Linewidth',0.08);
    yline(0,'Color','black','Linewidth',0.08);
    fplot(w, 'Color', 'magenta');
    lg=legend('','','$w$');
    set(lg,'Interpreter','latex','Location','northeast');
    exportgraphics(gcf,'kernel2.jpg','Resolution',300);
    
    figure
    hold on
    z=linspace(-ext_W,ext_W,1000);
    lims=[-ext_W,ext_W,min(W(z)),max(W(z))];
    axis(lims);
    title('Trasformata di Fourier del nucleo $W(k) := \hat{w}(k)$','Interpreter','latex')
    xlabel('$k$','Interpreter','latex');
    xline(0,'Color','black','Linewidth',0.08);
    yline(0,'Color','black','Linewidth',0.08);
    fplot(W, 'Color', '#607d8b');
    lg=legend('','','$W$');
    set(lg,'Interpreter','latex','Location','northeast');
    exportgraphics(gcf,'kernel3.jpg','Resolution',300);
end

