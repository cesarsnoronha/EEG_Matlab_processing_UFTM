%% Comparation of 2 vectors, log of pre and post.

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
Banda = sprintf('Alfa'); banda = 1;
%%
Banda = sprintf('Beta'); banda = 2;
%%
Banda = sprintf('Delta'); banda = 3;
%%
Banda = sprintf('Teta'); banda = 4;
%%
tipo = sprintf('Shan');
Antes = Antes_Shan;
Depois = Depois_Shan;
%%
tipo = sprintf('tDCS');
Antes = Antes_anodico;
Depois = Depois_anodico;
%% Gera Gráfico

qnt_eletrodos = size(s,2);
qnt_amostra = size(Antes,1);

extra = (banda-1)*qnt_eletrodos;
A = Antes(:,(1+extra):(qnt_eletrodos+extra));
B = Depois(:,(1+extra):(qnt_eletrodos+extra));

[h,p] = ttest(A,B);


for canal = 1:qnt_eletrodos
    %if p(canal) < 0.05

        figura = figure;
        plot(2*ones(1,qnt_amostra),A(:,canal),'.k','MarkerSize', 12) %pontos pre
        hold on % mantem as plotagens no mesmo grafico 
        plot(3*ones(1,qnt_amostra),B(:,canal),'.k','MarkerSize', 12) %valores post

        HOLD = s;
        for i = 1:qnt_amostra
            h = line([3 2],[B(i,canal) A(i,canal)]); %marca as linhas entre os pontos
            s = h.Color;
            h.Color = 'k'; %cor da linha fica preta
        end
        s = HOLD;
        boxplot([A(:,canal) zeros(qnt_amostra,1) zeros(qnt_amostra,1) B(:,canal)],'Labels',{' ','Pre tDCS','Post tDCS',' '},'Color', 'k') %cria os boxplot

        electrode = s{canal};
        Title = sprintf('%s %s (p=%f) %s', Banda, electrode, p(canal), tipo);
        title(Title);
        
        Eixoy = sprintf('%s activity (dB)', Banda);
        ylabel(Eixoy) %['FFT power log(' char(181) 'V^2)']);
    %end

    %axis([ 0.5 4.5 0 inf]) % ajusta o zoom
    hold off
    
    nome_figura = sprintf('%s_%s_%s_boxplot.png',tipo, Banda, electrode);
    saveas(figura,nome_figura)
    close(figura)
end
