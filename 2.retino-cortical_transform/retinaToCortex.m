function [x,y] = retinaToCortex(theta,rho,alpha,beta)
x=alpha*log(2*beta*rho);
y=alpha*theta;
end

