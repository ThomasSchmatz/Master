% Graphische Auswertung der Robotermesswerte

close all;
clc;
clear all;

% Öffnen der Datei, welche eine Messfahrt mit genau 308 Messwerten
% enthalten muss
fid = fopen('mess1.txt', 'r');
a = fscanf(fid, '%g %g', [7 308])     
a = a';
fclose(fid)

fid1 = fopen('mess2.txt', 'r');
a1 = fscanf(fid1, '%g %g', [7 308])     
a1 = a1';
fclose(fid1)

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

j=1; k=1; l=1;

for(i=0:307)
    if(mod(i,28)>13) k = 28- mod(i,28);
    else k = mod(i,14)+1;
    end
    Tm1(k,l)=a1(i+1,3);
    if(mod(i+1,14)==0) l=l+1;
    end
end

% Umrechnung der ADC-Werte in Temeratur:
Rm = (Tm +4038.9)/40.107;  % ADC --> Widerstand
TTm = (Rm-100.03)/0.3879;  % Widerstand --> Temperatur

% Umrechnung der ADC-Werte in Temeratur:
Rm1 = (Tm1 +4038.9)/40.107;  % ADC --> Widerstand
TTm1 = (Rm1-100.03)/0.3879;  % Widerstand --> Temperatur

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

j=1; k=1; l=1;

% Umwandeln der 1 dimensionalen Innentemperatur ADC-Werte in eine Matrix:
for(i=0:307)
    if(mod(i,28)>13) k = 28- mod(i,28);
    else k = mod(i,14)+1;
    end
    Ti1(k,l)=a1(i+1,4);
    if(mod(i+1,14)==0) l=l+1;
    end
end

% Umrechnung der ADC-Werte in Temeratur:
Ri = (Ti +4023.6)/40.027;  % ADC --> Widerstand
TTi = (Ri-100.03)/0.3879;  % Widerstand --> Temperatur

% Umrechnung der ADC-Werte in Temeratur:
Ri1 = (Ti1 +4023.6)/40.027;  % ADC --> Widerstand
TTi1 = (Ri1-100.03)/0.3879;  % Widerstand --> Temperatur

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

j=1; k=1; l=1;

% Umwandeln der 1 dimensionalen Kurzschlusstrom ADC-Werte in eine Matrix:
for(i=0:307)
    if(mod(i,28)>13) k = 28- mod(i,28);
    else k = mod(i,14)+1;
    end
    I1(k,l)=a1(i+1,2);
    if(mod(i+1,14)==0) l=l+1;
    end
end

% Umrechnung der ADC-Werte in Ampere:

A = (I +4.5766)/119.2;   % ADC --> Ampere
A = A - (TTm-25)*0.00238;  % Temperaturkorrektur


A1 = (I1 +4.5766)/119.2;   % ADC --> Ampere
A1 = A1 - (TTm1-25)*0.00238;  % Temperaturkorrektur

[XI,YI] = meshgrid(1:.125:22, 1:.125:14);

Ai = interp2(A,XI,YI,'cubic'); % Interpolation

Ai1 = interp2(A,XI,YI,'cubic'); % Interpolation

Gi = Ai / 4.99 * 1000; % bestrahlungsstärke in Watt

Gi1 = Ai1 / 4.99 * 1000; % bestrahlungsstärke in Watt

A_max = max(max(Ai));
A_min = min(min(Ai));

Normiert = Ai / A_max * 1.1;

w = (A_max - A_min)/(A_max + A_min) * 100  % maximale Abweichung in Protzent

% Graphische Darstellung des Stromes
figure;
surf((Ai)); % in Ampere

figure;
surf((Ai1)); % in Ampere

% Graphische Darstellung der Bestrahlungsstärke
 figure;
 surf((A-A1)/4.99 * 1000); % in W/m2

% Graphische Darstellung der Modultemperatur
figure;
surf(TTm); 

figure;
surf(TTm1); 

% Graphische Darstellung der Umgebungstemperatur
% figure;
% surf(TTi);   


