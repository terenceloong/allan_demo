%incremental Allan variance analysis demo
clc;clear;

N = 0.1;
T = 1000;
dt = 0.01;
n = T/dt;

data = zeros(n,1);
ti = 10;
for p=2:n
    data(p) = data(p-1)+sum(randn(1,ti)*sqrt(N^2/(dt/ti)))*(dt/ti);
end
% data = round(data,2);

ks = round(10.^linspace(0,log10(floor((n-2)/2)),200));
ks([1,diff(ks)]==0) = []; %delete repetitive value
kn = length(ks);
sigma = zeros(kn,2);

for m=1:kn
	k = ks(m);
    a = 0;
    for p=1:n-2*k
        a = a + ((data(p+2*k)-2*data(p+k)+data(p))/(k*dt))^2;
    end
    sigma(m,1) = k*dt;
    sigma(m,2) = sqrt(a/2/(n-2*k));
end
disp(interp1(sigma(:,1),sigma(:,2),1))

% figure
loglog(sigma(:,1),sigma(:,2))
xlabel('\tau/s')
ylabel('\sigma(\tau)')
grid on