%rate Allan variance analysis demo
clc;clear;

N = 0.1;
T = 400;
dt = 0.01;
n = T/dt;

data = randn(n,1)*(N*sqrt(1/dt));

ks = round(10.^linspace(0,log10(floor((n-1)/2)),100));
ks([1,diff(ks)]==0) = []; %delete repetitive value
kn = length(ks);
sigma = zeros(kn,2);

for m=1:kn
    k = ks(m);
    a = 0;
    for p=1:n-2*k+1
        a = a + ((sum(data(p:p+k-1))-sum(data(p+k:p+2*k-1)))/k)^2;
    end
    sigma(m,1) = k*dt;
    sigma(m,2) = sqrt(a/2/(n-2*k+1));
end
disp(interp1(sigma(:,1),sigma(:,2),1))

% figure
loglog(sigma(:,1),sigma(:,2))
xlabel('\tau/s')
ylabel('\sigma(\tau)')
grid on