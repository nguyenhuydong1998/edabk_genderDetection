function b = FIR_LPF_900Hz()
% Implement Low Pass Filter
[n,fo,ao,w] = firpmord([900 1700],[1 0],[0.001 0.0025],8000);
b = firpm(n,fo,ao,w);

