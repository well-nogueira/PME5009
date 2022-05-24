%% *NOGUEIRA PME5009 2022 - LISTA 1*

%% *Exerc�cio 1:*
% 
%  *Sistema1 a) representado em espa�o de estados*
    A = [[0,1,0];[0,0,1];[-0.005,-0.11,-0.7]];
    B = [[0.1];[-0.2];[-0.1]];
    C = [0,0,1];
    D = [0];
    ss_Model_1 = ss(A,B,C,D)  
%%
%  *Sistema2 b) representado em espa�o de estados*
% 
    A2 = [[-0.2,-0.2,0.4];[0.5,0,1];[0,-0.4,-0.4]];
    B2 = [[0.01];[0];[0.05]];
    C2 = [1,0,0];
    D2 = [0];
    ss_Model_2 = ss(A2,B2,C2,D2)
%%
%
% # *i) Verificar e Justificar se os sistemas s�o control�veis e Observ�veis:* 
%    

    % Matrizes de controlabilidade
    Matriz_Controlabilidade_1 = ctrb(A,B)
    Matriz_Controlabilidade_2 = ctrb(A2,B2)
    % Verificando o posto (rank) da matrizes de controlabilidade
    Posto_Matriz_Contrl_1 = rank(Matriz_Controlabilidade_1)
    Posto_Matriz_Contrl_2 = rank(Matriz_Controlabilidade_2)

    % Matrizes de observabilidade:
    Matriz_Observabilidade_1 = obsv(A,C)
    Matriz_Observabilidade_2 = obsv(A2,C2)
    % Verificando o posto (rank) das matrizes de observabilidade
    Posto_Matriz_Obsv_1 = rank(Matriz_Observabilidade_1)
    Posto_Matriz_Obsv_2 = rank(Matriz_Observabilidade_2)
%    
%% 
% R) Ambos os postos (rank) das matrizes de controlabilidade e
% observabilidade s�o iguais a ordem do sistema, o que significa que temos
% uma solu��o linearmente independente que relaciona entradas com cada um
% dos estados (no caso da matriz de controlabilidade) e uma solu��o
% linearmente independente que relaciona as sa�das com cada um dos estados
% (no caso da matriz de observabilidade). Conclu�mos ent�o que o sistema � 
% completamente control�vel e completamente observ�vel. 
%
%

%%
%
% # *ii) Verificar e Justificar se s�o est�veis em malha aberta*
    Estabilidade_Sistema1 = eig(A)
    Estabilidade_Sistema2 = eig(A2)
%
%%
    tf_model1 = ss(A,B,C,D);
    tf_model2 = ss(A2,B2,C2,D2);
    figure; 
    subplot(211);
    rlocus(tf_model1);
    title('Root Locus modelo 1');
    subplot(212);
    rlocus(tf_model2);
    title('Root Locus modelo 2');
    
% R)
% eigein value (auto valor) da matriz A, representa os polos do sistema 
% e sua parte real negativa indica que o sistema � est�vel e ir� 
% convergir seguindo a dire��o apontada pelos auto valores da matiz.
% Nesse caso ambos os sisteas *Sistema1* e *Sistema2* � est�vel em malha 
% aberta, pois todos os auto valores possuem parte real negativa indicando 
% que seus polos est�o no semiplano complexo esquerdo.
   
%%
%
% # *iii) Simular por 60 seg para entrada em degrau unit�rio e impulso unit�rio*
%
    t_sim = 60;
    sim('Exercicio_1_sim',t_sim);
    
    figure;
    subplot(211);
    plot(step_resp_model1);
    title('Step Resp Model 1');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    legend({'step resp model 1'},'Location','northeast');
    hold;
    subplot(212);
    plot(step_input,'-r','LineWidth',1.5);
    axis([0 t_sim -1 1.5]);
    title('Step Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    legend({'step input'},'Location','northeast');
    
    
    figure
    subplot(211);
    plot(impulse_resp_model1);
    title('Impulse Resp Model 1');
    xlabel('tempo (s)');
    ylabel('amplitude'); 
    legend({'impulse resp model 1'},'Location','northeast');
    subplot(212);
    plot(impulse_input,'-r','LineWidth',2);
    axis([0 t_sim 0 120]);
    title('Impulse Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    legend({'impulse input'},'Location','northeast');
    
       
%%   
% Obs.: Podemos notar que o sistema converge sendo est�vel em malha aberta 
% como verificado no exerc�cio anterior.
%
    figure;
    subplot(211);
    plot(step_resp_model2);
    title('Step Resp Model 2');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'step resp model 2'},'Location','northeast');
    subplot(212);
    plot(step_input,'-r','LineWidth',1.5);
    axis([0 t_sim -1 1.5]);
    title('Step Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    legend({'step input'},'Location','northeast');
    
    figure;
    subplot(211);
    plot(impulse_resp_model2);
    title('Impulse Resp Model 2');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'impulse resp model 2'},'Location','northeast');
    subplot(212);
    plot(impulse_input,'-r','LineWidth',2);
    axis([0 t_sim 0 120]);
    title('Impulse Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    legend({'impulse input'},'Location','northeast');
%%   
% Obs.: Podemos notar que o sistema converge sendo est�vel em malha aberta 
% como verificado no exerc�cio anterior.
%
%%
%
% # *iv) Projetar observador de estados de ordem completa com polos � sua escolha*
%

%%
%
% # *v) Refazer o mesmo com observadores de Luenberger (Ordem reduzida)*
%

%%    
%
% # *vi) Projetar controlador para tornar a resposta ao derau mais r�pida em malha fechada utilizando o m�todo de aloca��o de polos e observador a sua escolha, avaliar sensibilidade da planta a escolha dos polos do controlador e observador*
%   

%% *Exerc�cio 2:*
%
% * *Sistema escolhido representado em espa�o de estados:*
%
