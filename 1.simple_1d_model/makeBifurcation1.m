function makeBifurcation1(b1,b2,d1,d2)
ext=2;
[w,W]=makeKernel(b1,b2,d1,d2,0);
bif_fun=@(k,a) W(k)-a;
k_c=sqrt(4/(d2^2-d1^2)*log(b2/b1*(d2/d1)^3));
a_c=W(k_c);

%Generazione valori casuali di plotting.
a1=a_c*rand();
a2=(10-a_c)*rand()+a_c;

%Elaborazione del diagramma di biforcazione.
hold on
title(strcat('Modello 1-dimensionale, diagramma di biforcazione: $w(z)=',num2str(b1),'e^{- \left(\frac{z}{',num2str(d1),'}\right)^2} - ',num2str(b2),'e^{- \left(\frac{z}{',num2str(d2),'}\right)^2}$'),'Interpreter','latex');
xlabel("Numeri d'onda $k$",'Interpreter','latex');
ylabel("Dispersione $\lambda(k)$",'Interpreter','latex')
z=linspace(0,ext,1000);
lims=[0,ext,min(W(z))-a2,max(W(z))];
axis(lims);
xline(0,'Color','black','Linewidth',0.08);
yline(0,'Color','black','Linewidth',0.08);
% caso a=0
fplot(@(k) bif_fun(k,0),'Color','red');
text(ext-0.2,bif_fun(ext-0.2,0)+0.2,'$a=0$','Interpreter','latex');
k0=fsolve(@(k) bif_fun(k,0),1e-1);
text(k0+0.001,-0.2,'$k_0$','Interpreter','latex','FontSize',8);
plot([k0,ext],[0,0],'Color','red','Linestyle','--','Linewidth',1);
% caso 0<a<a_c
fplot(@(k) bif_fun(k,a1),'Color','#880e4f');
text(ext-0.2,bif_fun(ext-0.2,a1)+0.2,strcat('$a=',num2str(a1),'$'),'Interpreter','latex');
k1=fsolve(@(k) bif_fun(k,a1),1e-1);
k2=fsolve(@(k) bif_fun(k,a1),ext);
text(k1+0.001,-0.2,'$k_1$','Interpreter','latex','FontSize',8);
text(k2+0.001,-0.2,'$k_2$','Interpreter','latex','FontSize',8);
plot([k1,k2],[0,0],'Color','#880e4f','Linestyle',':','Linewidth',1);
% caso a=a_c
fplot(@(k) bif_fun(k,a_c),'Color','#607d8b');
text(ext-0.2,bif_fun(ext-0.2,a_c)+0.2,strcat('$a=a_c=',num2str(a_c),'$'),'Interpreter','latex');
plot([k_c,0],'Color','#607d8b','Marker','.','MarkerSize',10);
text(k_c,-0.2,'$k_c$','Interpreter','latex','FontSize',8);
% caso a>a_c
fplot(@(k) bif_fun(k,a2),'Color','blue');
text(ext-0.2,bif_fun(ext-0.2,a2)+0.2,strcat('$a=',num2str(a2),'$'),'Interpreter','latex');
% legenda
lg=legend('','','','modi instabili, $a=0$','',strcat('modi instabili, ','$ \ a=',num2str(a1),'$'),'','','');
set(lg,'Interpreter','latex','Location','northeast');
% box dei valori di k0,k1,k2,k_c ricavati
text(0.2,lims(3)+1.1,strcat('$k_0 \approx',num2str(k0),'$'),'Interpreter','latex','FontSize',8);
text(0.2,lims(3)+0.7,strcat('$k_1 \approx ',num2str(k1),';\ k_2 \approx',num2str(k2),'$'),'Interpreter','latex','FontSize',8);
text(0.2,lims(3)+0.3,strcat('$k_c=',num2str(k_c),'$'),'Interpreter','latex','FontSize',8);
% salvataggio immagine    
exportgraphics(gcf,'bifurcation1.jpg','Resolution',300);
end

