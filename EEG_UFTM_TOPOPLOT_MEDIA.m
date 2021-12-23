
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
Antes_Shan = Antes([2 4 6],:);

Depois_anodico = Depois([1 3 5],:);
Depois_Shan = Depois([2 4 6],:);

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

%%

BandAntes = [median(AlfaAntesFFT); median(BetaAntesFFT); median(DeltaAntesFFT); median(TetaAntesFFT)];
BandDepois = [median(AlfaDepoisFFT); median(BetaDepoisFFT); median(DeltaDepoisFFT); median(TetaDepoisFFT)];

Subtracted = [median(AlfaAntesFFT - AlfaDepoisFFT); median(BetaAntesFFT - BetaDepoisFFT); median(DeltaAntesFFT - DeltaDepoisFFT); median(TetaAntesFFT - TetaDepoisFFT)];

BandAntes = [median(AlfaAntesFFT); median(BetaAntesFFT); median(DeltaAntesFFT); median(TetaAntesFFT)];
BandDepois = [median(AlfaDepoisFFT); median(BetaDepoisFFT); median(DeltaDepoisFFT); median(TetaDepoisFFT)];

%% Media Antes

teste = sprintf('Media Antes');
subplot(3,4,1)
topoplot(BandAntes(1,:),locs)
Banda = sprintf('Alfa');
Title = sprintf('%s %s - %s',teste, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandAntes(1,:))))
    
subplot(3,4,2)
topoplot(BandAntes(2,:),locs)
Banda = sprintf('Beta');
Title = sprintf('%s %s - %s',teste, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandAntes(2,:))))

subplot(3,4,3)
topoplot(BandAntes(3,:),locs)
Banda = sprintf('Delta');
Title = sprintf('%s %s - %s',teste, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandAntes(3,:))))

subplot(3,4,4)
topoplot(BandAntes(4,:),locs)
Banda = sprintf('Teta');
Title = sprintf('%s %s - %s',teste, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandAntes(4,:))))

%% Media Depois
teste1 = sprintf(' Media Depois');
subplot(3,4,5)
topoplot(BandDepois(1,:),locs)
Banda = sprintf('Alfa');
Title = sprintf('%s %s - %s',teste1, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandDepois(1,:))))
    
subplot(3,4,6)
topoplot(BandDepois(2,:),locs)
Banda = sprintf('Beta');
Title = sprintf('%s %s - %s',teste1, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandDepois(2,:))))

subplot(3,4,7)
topoplot(BandDepois(3,:),locs)
Banda = sprintf('Delta');
Title = sprintf('%s %s - %s',teste1, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandDepois(3,:))))

subplot(3,4,8)
topoplot(BandDepois(4,:),locs)
Banda = sprintf('Teta');
Title = sprintf('%s %s - %s',teste1, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandDepois(4,:))))

%% Subtração
teste = sprintf('Subtração  (D-A)');

subplot(3,4,9)
Band =  BandDepois(1,:) - BandAntes(1,:);
topoplot(Band,locs)
Banda = sprintf('Alfa');
Title = sprintf('%s %s - %s',teste, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandDepois(1,:)- BandAntes(1,:))))

subplot(3,4,10)
Band =  BandDepois(2,:) - BandAntes(2,:);
topoplot(Band,locs)
Banda = sprintf('Beta');
Title = sprintf('%s %s - %s',teste, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandDepois(2,:)- BandAntes(2,:))))

subplot(3,4,11)
Band =  BandDepois(3,:) - BandAntes(3,:);
topoplot(Band,locs)
Banda = sprintf('Delta');
Title = sprintf('%s %s - %s',teste, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandDepois(3,:)- BandAntes(3,:))))

subplot(3,4,12)
Band =  BandDepois(4,:) - BandAntes(4,:);
topoplot(Band,locs)
Banda = sprintf('Teta');
Title = sprintf('%s %s - %s',teste, Banda, tipo);
title(Title)
cbar('horiz',0,[-1 1]*max(abs(BandDepois(4,:)- BandAntes(4,:))))
