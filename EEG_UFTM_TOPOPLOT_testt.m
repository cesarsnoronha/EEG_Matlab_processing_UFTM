%% FFT Upload (SEM AJUSTE)

[~,s] = xlsread('electrode_names_uftm.xlsx');

locs = get_chanlocs_from_labels(s);

AlfaAntesFFT = xlsread('AreaAlfaAntes.xlsx',1,'B2:G7');
AlfaDepoisFFT = xlsread('AreaAlfaDepois.xlsx',1,'B2:G7');

BetaAntesFFT = xlsread('AreaBetaAntes.xlsx',1,'B2:G7');
BetaDepoisFFT = xlsread('AreaBetaDepois.xlsx',1,'B2:G7');

DeltaAntesFFT = xlsread('AreaDeltaAntes.xlsx',1,'B2:G7');
DeltaDepoisFFT = xlsread('AreaDeltaDepois.xlsx',1,'B2:G7');

TetaAntesFFT = xlsread('AreaTetaAntes.xlsx',1,'B2:G7');
TetaDepoisFFT = xlsread('AreaTetaDepois.xlsx',1,'B2:G7');

Antes = [AlfaAntesFFT BetaAntesFFT DeltaAntesFFT TetaAntesFFT];
Depois = [AlfaDepoisFFT BetaDepoisFFT DeltaDepoisFFT TetaDepoisFFT];

Antes_anodico = Antes([1 3 5],:);
Depois_anodico = Depois([1 3 5],:);

Antes_Shan = Antes([2 4 6],:);
Depois_Shan = Depois([2 4 6],:);

qnt_eletrodos = size(s,2);
qnt_amostra = size(Antes,1);
%%
tipo = sprintf('Shan');
AlfaAntesFFT = AlfaAntesFFT([2 4 6],:);
BetaAntesFFT = BetaAntesFFT([2 4 6],:);
DeltaAntesFFT = DeltaAntesFFT([2 4 6],:);
TetaAntesFFT = TetaAntesFFT([2 4 6],:);

AlfaDepoisFFT = AlfaDepoisFFT([2 4 6],:);
BetaDepoisFFT = BetaDepoisFFT([2 4 6],:);
DeltaDepoisFFT = DeltaDepoisFFT([2 4 6],:);
TetaDepoisFFT = TetaDepoisFFT([2 4 6],:);

%%
tipo = sprintf('tDCS');
AlfaAntesFFT = AlfaAntesFFT([1 3 5],:);
BetaAntesFFT = BetaAntesFFT([1 3 5],:);
DeltaAntesFFT = DeltaAntesFFT([1 3 5],:);
TetaAntesFFT = TetaAntesFFT([1 3 5],:);
 
AlfaDepoisFFT = AlfaDepoisFFT([1 3 5],:);
BetaDepoisFFT = BetaDepoisFFT([1 3 5],:);
DeltaDepoisFFT = DeltaDepoisFFT([1 3 5],:);
TetaDepoisFFT = TetaDepoisFFT([1 3 5],:);

%% Valores de Banda
BandAntesFFT = [median(AlfaAntesFFT); median(BetaAntesFFT); median(DeltaAntesFFT); median(TetaAntesFFT)];
BandDepoisFFT = [median(AlfaDepoisFFT); median(BetaDepoisFFT); median(DeltaDepoisFFT); median(TetaDepoisFFT)];

SubtractedFFT = [median(AlfaAntesFFT - AlfaDepoisFFT); median(BetaAntesFFT - BetaDepoisFFT); median(DeltaAntesFFT - DeltaDepoisFFT); median(TetaAntesFFT - TetaDepoisFFT)];

% BandAntesFFT(:,23:24) = 0;
% BandDepoisFFT(:,23:24) = 0;
% SubtractedFFT(:,23:24) = 0;



%% (valores de banda e valotes de p)
displayopt = sprintf('off');

k=1; % T-test FFT
for j = size(AlfaAntesFFT,2)
[~,p1(k,j)] = ttest(AlfaAntesFFT(:,j), AlfaDepoisFFT(:,j));
end
k=2;
for j = size(AlfaAntesFFT,2)
[~,p1(k,j)] = ttest(BetaAntesFFT(:,j), BetaDepoisFFT(:,j));
end
k=3;
for j = size(AlfaAntesFFT,2)
[~,p1(k,j)] = ttest(DeltaAntesFFT(:,j), DeltaDepoisFFT(:,j));
end
k=4;
for j = size(AlfaAntesFFT,2)
[~,p1(k,j)] = ttest(TetaAntesFFT(:,j), TetaDepoisFFT(:,j));
end

k=1; % friedman FFT
for j = size(AlfaAntesFFT,2)
    tofriedman = [AlfaAntesFFT(:,j) AlfaDepoisFFT(:,j)];
    p3(k,j) = friedman(tofriedman,1,displayopt);
end
k=2;
for j = size(AlfaAntesFFT,2)
    tofriedman = [BetaAntesFFT(:,j) BetaDepoisFFT(:,j)];
    p3(k,j) = friedman(tofriedman,1,displayopt);
end
k=3;
for j = size(AlfaAntesFFT,2)
    tofriedman = [DeltaAntesFFT(:,j) DeltaDepoisFFT(:,j)];
    p3(k,j) = friedman(tofriedman,1,displayopt);
end
k=4;
for j = size(AlfaAntesFFT,2)
    tofriedman = [TetaAntesFFT(:,j) TetaDepoisFFT(:,j)];
    p3(k,j) = friedman(tofriedman,1,displayopt);
end


%% Plotando imagens
Banda = sprintf('Alfa'); i = 1;
%%
Banda = sprintf('Beta'); i = 2;
%%
Banda = sprintf('Delta'); i = 3;
%%
Banda = sprintf('Teta'); i = 4;

%% Plot
figura = figure('units' , 'normalized', 'outerposition', [0 0 1 1]);
teste = sprintf('FFT Media Antes'); %Media Antes
subplot(2,3,1)
% h=subtightplot(2,3,1,[0,0]);
topoplot(BandAntesFFT(i,:),locs); 
Title = sprintf('%s - %s (%s)',teste, Banda,tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandAntesFFT(i,:))))
ax = gca;
ax.FontSize = 11;

teste = sprintf('FFT Media Depois'); %Media Antes
subplot(2,3,2)
%h=subtightplot(2,3,2,[0,0]);
topoplot(BandDepoisFFT(i,:),locs)
Title = sprintf('%s - %s (%s)',teste, Banda,tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandDepoisFFT(i,:))))
ax = gca;
ax.FontSize = 11;


teste = sprintf('FFT Subtração [D-A]'); %Media Antes
subplot(2,3,3)
%h=subtightplot(2,3,3,[0,0]);
topoplot(SubtractedFFT(i,:),locs)
Title = sprintf('%s - %s (%s)',teste, Banda,tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(SubtractedFFT(i,:))))
ax = gca;
ax.FontSize = 11;



teste = sprintf('teste-t para diferenças'); %Media Antes
subplot(2,3,4)
%h=subtightplot(2,3,4,[0,0]);
topoplot(p1(i,:),locs,'maplimits',[0,0.05])
Title = sprintf('%s - %s (%s)',teste, Banda,tipo);
title(Title)
cbar('horiz',0,[0 1])
ax = gca;
ax.FontSize = 11;


teste = sprintf('Friedman para diferenças'); %Media Antes
subplot(2,3,5)
%h=subtightplot(2,3,6,[0,0]);
topoplot(p3(i,:),locs,'maplimits',[0,0.05])
Title = sprintf('%s - %s (%s)',teste, Banda,tipo);
title(Title)
cbar('horiz',0,[0 1])
ax = gca;
ax.FontSize = 11;

nome_figura = sprintf('%s_%s_topoplot.png',tipo, Banda);
saveas(figura,nome_figura)
close(figura)