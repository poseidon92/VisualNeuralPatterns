function [p_c,k_c]=makeBifurcation2(a,b,h,plt)
ext=1;
%Definizione delle trasformate W e funzioni L,M
W_ee=@(k) pi/b(1)*exp(-(k^2)/(4*b(1)))*exp(-i*h(1)*k);
W_ii=@(k) pi/b(2)*exp(-(k^2)/(4*b(2)))*exp(-i*h(2)*k);
W_ei=@(k) pi/b(3)*exp(-(k^2)/(4*b(3)))*exp(-i*h(3)*k);
W_ie=@(k) pi/b(4)*exp(-(k^2)/(4*b(4)))*exp(-i*h(4)*k);
L=@(k,p) 2-p*a(1)*W_ee(k)+p*a(2)*W_ii(k);
M=@(k,p) 1+p^2*a(4)*a(3)*W_ie(k)*W_ei(k)-p*a(1)*W_ee(k)-p^2*a(1)*a(2)*W_ee(k)*W_ii(k)+p*a(2)*W_ii(k);

%Calcoli relativi alla relazione di dispersione.
% scrittura in forma simbolica e derivazione
syms k;
F=a(1)*W_ee(k)-a(2)*W_ii(k)+((a(1)*W_ee(k)+a(2)*W_ii(k))^2-4*a(4)*a(3)*W_ie(k)*W_ei(k))^(1/2);
F_prime=diff(F);
% conversione in forma handle function
F=matlabFunction(real(F));
F_prime=matlabFunction(real(F_prime));
% scrittura della dispersione lambda
lambda=@(k,p) p/2*F(k)-1;
% calcolo dei valori di biforcazione k_c,p_c
k_c=fsolve(F_prime,1e-1);
p_c=2/F(k_c);

%Controllo validità dei parametri al caso p=p_c
if L(0,p_c)<=0 || M(0,p_c)<=0
    exit('Parametri non validi: soluzione spazio-indipendente non stabile.')
end

if plt==1
    %Generazione valori casuali di plotting.
    p1=0.02*rand()+(p_c-0.02);
    p2=0.05*rand()+p_c;
    
    %Elaborazione del diagramma di biforcazione.
    hold on
    title('Modello 2-dimensionale, diagramma di biforcazione','Interpreter','latex');
    xlabel("$||\textbf{k}||$",'Interpreter','latex');
    ylabel("Dispersione $\Re(\lambda(\textbf{k}))$",'Interpreter','latex');
    k=linspace(0,ext,200);
    lims=[0,ext,min(lambda(k,p1)),max(lambda(k,p2))];
    axis(lims);
    xline(0,'Color','black','Linewidth',0.08);
    yline(0,'Color','black','Linewidth',0.08);
    % caso 0<p<p_c
    fplot(@(k) lambda(k,p1),'Color','blue');
    text(ext-0.4,lambda(ext-0.2,p1)+0.02,strcat('$p=',num2str(p1),'$'),'Interpreter','latex');
    % caso p=pc
    fplot(@(k) lambda(k,p_c),'Color','#607d8b');
    text(ext-0.4,lambda(ext-0.4,p_c)+0.02,strcat('$p=p_c=',num2str(p_c),'$'),'Interpreter','latex');
    text(k_c,-0.02,'$k_c$','Interpreter','latex','FontSize',8);
    % caso p>p_c
    fplot(@(k) lambda(k,p2),'Color','#880e4f');
    text(ext-0.4,lambda(ext-0.4,p2)+0.02,strcat('$p=',num2str(p2),'$'),'Interpreter','latex');
    k1=max(fsolve(@(k) lambda(k,p2),0.02),0);
    k2=fsolve(@(k) lambda(k,p2),ext);
    text(k1+0.001,-0.02,'$k_1$','Interpreter','latex','FontSize',8);
    text(k2+0.001,-0.02,'$k_2$','Interpreter','latex','FontSize',8);
    plot([k1,k2],[0,0],'Color','#880e4f','Linestyle',':','Linewidth',1);
    % legenda
    lg=legend('','','','','',strcat('modi instabili, ','$ \ p=',num2str(p2),'$'));
    set(lg,'Interpreter','latex','Location','northeast');
    % box dei valori di k1,k2,k_c ricavati
    text(0.2,lims(3)+0.12,strcat('$k_1 \approx ',num2str(k1),';\ k_2 \approx',num2str(k2),'$'),'Interpreter','latex','FontSize',8);
    text(0.2,lims(3)+0.1,strcat('$k_c \approx ',num2str(k_c),'$'),'Interpreter','latex','FontSize',8);
    % salvataggio immagine    
    exportgraphics(gcf,'bifurcation2.jpg','Resolution',300);
end
end


