function [IRGarson] = Garson(nodos,net)
% j es el número de neuronas de la red, y net es la red.
weights = getwb(net); % Carga los pesos y las biases de la red.
iw = cell2mat(net.IW); % Input weights
lw = cell2mat(net.LW); % Layer weights
P = zeros;
in = 10; % Número de entradas
out = 4; % Número de salidas

for j = 1 : out
    for c = 1 : in
        for i = 1 : nodos
            P(i, c, j) = abs(iw(i,c)) * abs(lw(j,i));
        end
    end
end

suma = zeros;
Q = zeros;

for x = 1 : out
    for c = 1 : in
        for i = 1 : nodos
            suma = zeros;
            for a = 1 : in
                suma = suma + P(i, a, x);
            end
            Q(i, c, x) = P(i, c, x) / suma;
        end
    end
end

S = zeros;
for x = 1 : out
    for c = 1 : in
        suma = 0;
        for i = 1 : nodos
            suma = suma + Q(i, c, x);
        end
        S(c, x) = suma;
    end
end

for x = 1 : out
    suma = zeros;
    for a = 1 : in
        suma = suma + S(a, x);
    end
end

IRGarson = zeros;

for x = 1 : out
    for c = 1 : in
        IRGarson(c, x) = S(c, x) * 100 / suma;
    end
end