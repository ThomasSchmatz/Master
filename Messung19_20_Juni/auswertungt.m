% Graphische Auswertung der Robotermesswerte

close all;
clc;
clear all;

% Öffnen der Datei, welche eine Messfahrt mit genau 308 Messwerten
% enthalten muss
fid = fopen('mess6.txt', 'r');
a = fscanf(fid, '%g %g', [7 308])     
a = a';
fclose(fid)

j=1; k=1; l=1;

% Umwandeln der 1 dimensionalen Modultemperatur ADC-Werte in eine Matrix:
for(i=0:307)
    if(mod(i,28)>13) k = 28- mod(i,28);
    else k = mod(i,14)+1;
    end
    Tm(k,l)=a(i+1,3);
    if(mod(i+1,14)==0) l=l+1;
    end
end

% Umrechnung der ADC-Werte in Temeratur:
Rm = (Tm +4038.9)/40.107;  % ADC --> Widerstand
TTm = (Rm-100.03)/0.3879;  % Widerstand --> Temperatur

j=1; k=1; l=1;

% Umwandeln der 1 dimensionalen Innentemperatur ADC-Werte in eine Matrix:
for(i=0:307)
    if(mod(i,28)>13) k = 28- mod(i,28);
    else k = mod(i,14)+1;
    end
    Ti(k,l)=a(i+1,4);
    if(mod(i+1,14)==0) l=l+1;
    end
end

% Umrechnung der ADC-Werte in Temeratur:
Ri = (Ti +4023.6)/40.027;  % ADC --> Widerstand
TTi = (Ri-100.03)/0.3879;  % Widerstand --> Temperatur

j=1; k=1; l=1;

% Umwandeln der 1 dimensionalen Kurzschlusstrom ADC-Werte in eine Matrix:
for(i=0:307)
    if(mod(i,28)>13) k = 28- mod(i,28);
    else k = mod(i,14)+1;
    end
    I(k,l)=a(i+1,2);
    if(mod(i+1,14)==0) l=l+1;
    end
end

% Umrechnung der ADC-Werte in Ampere:
G_mean=0;

A = (I +4.5766)/119.2;   % ADC --> Ampere
for i=1:14
    for j=1:22
G(i,j) = 1000 * A(i,j) / 4.99 * ( 1 - 0.00048 * (TTm(i,j) - 25));
G_mean = G_mean + G(i,j)
    end
end

G_mean = G_mean / 308;

[XI,YI] = meshgrid(1:.125:22, 1:.125:14);

Gi = interp2(G,XI,YI,'cubic'); % Interpolation


G_max = max(max(Gi));
G_min = min(min(Gi));

w = (G_max - G_min)/(G_max + G_min) * 100  % maximale Abweichung in Protzent

display(G_mean);


% Graphische Darstellung der Bestrahlungsstärke
figure;
surf(XI,YI,Gi); % in W/m2

% Graphische Darstellung des normierten Stromes
% zlevs2 = 0.0:0.1:2;
% figure;
% [C,h] = contourf(XI,YI,Normiert,zlevs2);
% set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
% colorbar;


% Graphische Darstellung der Modultemperatur
figure;
surf(TTm); 

% Graphische Darstellung der Umgebungstemperatur
figure;
surf(TTi);   


