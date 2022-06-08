%% *NOGUEIRA PME5009 2022 - LISTA 1*

%% *Exercício 1:*
% 
%  *Sistema1 a) representado em espaço de estados*
    A = [[0,1,0];[0,0,1];[-0.005,-0.11,-0.7]];
    B = [[0.1];[-0.2];[-0.1]];
    C = [0,0,1];
    D = [0];
    ss_Model_1 = ss(A,B,C,D)  
%%
%  *Sistema2 b) representado em espaço de estados*
% 
    A2 = [[-0.2,-0.2,0.4];[0.5,0,1];[0,-0.4,-0.4]];
    B2 = [[0.01];[0];[0.05]];
    C2 = [1,0,0];
    D2 = [0];
    ss_Model_2 = ss(A2,B2,C2,D2)
%%
%
% # *i) Verificar e Justificar se os sistemas são controláveis e Observáveis:* 
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
% observabilidade são iguais a ordem do sistema, o que significa que temos
% uma solução linearmente independente que relaciona entradas com cada um
% dos estados (no caso da matriz de controlabilidade) e uma solução
% linearmente independente que relaciona as saídas com cada um dos estados
% (no caso da matriz de observabilidade). Concluímos então que o sistema é 
% completamente controlável e completamente observável. 
%
%

%%
%
% # *ii) Verificar e Justificar se são estáveis em malha aberta*
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
% e sua parte real negativa indica que o sistema é estável e irá 
% convergir seguindo a direção apontada pelos auto valores da matiz.
% Nesse caso ambos os sisteas *Sistema1* e *Sistema2* é estável em malha 
% aberta, pois todos os auto valores possuem parte real negativa indicando 
% que seus polos estão no semiplano complexo esquerdo.
   
%%
%
% # *iii) Simular por 60 seg para entrada em degrau unitário e impulso unitário*
%
    Ke1_B1 = 0;
    Ke2_B1 = 0;
    Ke3_B1 = 0;

    Aobs_B1  = A2;
    Bobs_B1  = B2;
    Cobs_B1  = C2;
    Dobs_B1  = D2;
    Keobs_B1 = [(0);(0);(0)];
    
    Ke1_A1 = 0;
    Ke2_A1 = 0;
    Ke3_A1 = 0;

    Aobs_A1  = A;
    Bobs_A1  = B;
    Cobs_A1  = C;
    Dobs_A1  = D;
    Keobs_A1 = [(0);(0);(0)];
    
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
% Obs.: Podemos notar que o sistema converge sendo estável em malha aberta 
% como verificado no exercício anterior.
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
% Obs.: Podemos notar que o sistema converge sendo estável em malha aberta 
% como verificado no exercício anterior.
%
%%
%
% # *iv) Projetar observador de estados de ordem completa com polos à sua escolha*
% 
% 
% Segundo Ogata podemos utilizar o método de obtenção do ganho do
% observador por meio da equação da dinâmica do erro: 
% eponto = (A – KeC)e
% Tendo como resultado para o erro tendendo a 0 a equação:
% |sI – A + KeC| = 0
% Onde: Ke = [[Ke1];[Ke2];[Ke3]]
% Calculando o determinante temos: 
%    det(SI-A+Ke*C) = [(s*s*(s+0.7))+(-1*(ke2-1)*0.005)+(ke1*0*0.11)]-[(0.005*s*ke1)+(0.11*(ke2-1)*(s))+((s+0.7)*0*(-1))]
% Resultado:
%
% A escolha dos polos foi adotada considerando pouco mais que o dobro do valor do polo
% dominante do sistema, no caso do sistema A o polo dominante era -0.5000,
% então o valor adotado foi - 1.5 o que garante uma dinâmica mais rápida
% que o sistema, o terceiro polo foi adotado para aproximação para um sistema
% de segunda ordem sendo alocado 5x mais rápido que o polo escolhido com o
% valor de -7.5.
% Dessa maneira a equação característica desejada é:
% s^3 + 10.51 s^2 + 25.33 s + 20.93
% O que resulta nos seguintes ganhos Ke:
    Ke1_A1 = 87026;
    Ke2_A1 = -4185;
    Ke3_A1 = 9.81;

    Aobs_A1  = A;
    Bobs_A1  = B;
    Cobs_A1  = C;
    Dobs_A1  = D;
    Keobs_A1 = [(Ke1_A1);(Ke2_A1);(Ke3_A1)];
%
%
% Adotando o mesmo método para o sistema B1:
% det(SI-A+Ke*C) =
% s^3+S^2*(0.6+Ke1)+s*(0.4*Ke3+0.2*Ke2+0.4Ke1+0.58)-0.2*Ke3-0.24*Ke2+0.4*Ke1+0.2
%
% Escolha dos polos é -1.2 (O polo dominante do sistema é -0.4) e o terceiro polo
% adotado para aproximação para segunda ordem é -6 (5x mais rápido qe polo escolhido)
% Então a equação característica desejada é:
% s^3 + 8.78 s^2 + 18.45 s + 10.61
% O que resulta nos seguintes ganhos Ke:
    Ke1_B1 = 8.18;
    Ke2_B1 = -42.462;
    Ke3_B1 = 15.264;

    Aobs_B1  = A2;
    Bobs_B1  = B2;
    Cobs_B1  = C2;
    Dobs_B1  = D2;
    Keobs_B1 = [(Ke1_B1);(Ke2_B1);(Ke3_B1)];
%
%
% Para ser aproximado para segunda ordem, um dos polos precisa ser pelo menos 5x mais
% rápido que os polos de segunda ordem desejados, os polos desejados de
% segunda ordem precisam ser duas vezes mais rápidos que o polo mais rápido
% do sistema para o observador.
% Desse modo o polo mais rapido do sistema é -0.5 então os polos desejados
% do sistema escolhidos foram -1.5 (mais de 2x o polo mais rápido do sistema)
% O terceiro polo foi alocado 5x mais rápido que o polo escolhido
% possibilitando aproximar o sistema para segunda ordem.
% Com o polinômio desejado é possivel calcular os ganhos de acordo com a resolução do 
% determinante da matriz resultante do cálculo:   det(s*A_Id-A+Ke*C)
%
%
% Comparando os resultados obtidos da simulação com condições iniciais diferentes para planta e para o observador:
%   
    t_sim = 100;
    sim('Exercicio_1_sim',t_sim);
%   
% Sistema A reposta ao degrau:
    figure;
    subplot(221);
    plot(step_resp_model1,'-black','LineWidth',1);
    xlabel('tempo (s)');
    ylabel('amplitude');
    axis([0 t_sim -0.11415 0.30241]);
    hold on 
    plot(step_resp_saidaobs_model1,'-r','LineWidth',0.7);
    title('Modelo A x Observador A');
    legend({'step resp model A', 'step obsrv model A'},'Location','southeast');
    hold off
    subplot(223);
    plot(step_input,'-b','LineWidth',1.5);
    axis([0 t_sim -1 1.5]);
    title('Step Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    title('Step Input');
    legend({'step input'},'Location','southeast');
          
    subplot(222); %erro obsv
    plot(step_resp_erroobs_model1,'-black','LineWidth',1);
    title('Erro Observador A');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'Erro Obsrv A'},'Location','southeast');

    subplot(224); %estodos obsv x estados modelo
    hold on
    plot(Sis_A1_ObsState1,'-magenta','LineWidth',1);
    plot(Sis_A1_ObsState2,'-cyan','LineWidth',1);
    plot(Sis_A1_ObsState3,'-yellow','LineWidth',1);
    plot(Sis_A1_State1,'--black','LineWidth',1);
    plot(Sis_A1_State2,'--r','LineWidth',1);
    plot(Sis_A1_State3,'--b','LineWidth',1);
    title('Estados Model x Obsrv');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'ObsvState1', 'ObsvState2', 'ObsvState3', 'SistState1', 'SistState2', 'SistState3'},'Location','southeast');
    hold off

% Sistema B reposta ao degrau:
    figure;
    subplot(221);
    plot(step_resp_model2,'-black','LineWidth',1);
    xlabel('tempo (s)');
    ylabel('amplitude');
    axis([0 t_sim -0.06272 0.04083]);
    hold on 
    plot(step_resp_saidaobs_model2,'-r','LineWidth',0.7);
    title('Modelo B x Observador B');
    legend({'step resp model B', 'step obsrv model B'},'Location','southeast');
    hold off
    subplot(223);
    plot(step_input,'-b','LineWidth',1.5);
    axis([0 t_sim -1 1.5]);
    title('Step Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    title('Step Input');
    legend({'step input'},'Location','southeast');
          
    subplot(222); %erro obsv
    plot(step_resp_erroobs_model2,'-black','LineWidth',1);
    title('Erro Observador B');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'Erro Obsrv B'},'Location','southeast');

    subplot(224); %Estados obsv x estados modelo
    hold on
    plot(Sis_B1_ObsState1,'-magenta','LineWidth',1);
    plot(Sis_B1_ObsState2,'-cyan','LineWidth',1);
    plot(Sis_B1_ObsState3,'-yellow','LineWidth',1);
    plot(Sis_B1_State1,'--black','LineWidth',1);
    plot(Sis_B1_State2,'--r','LineWidth',1);
    plot(Sis_B1_State3,'--b','LineWidth',1);
    title('Estados Model x Obsrv');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'ObsvState1', 'ObsvState2', 'ObsvState3', 'SistState1', 'SistState2', 'SistState3'},'Location','northeast');
    hold off

    
    
% Sistema A reposta ao impulso:
    figure;
    subplot(221);
    plot(impulse_resp_model1,'-black','LineWidth',1);
    xlabel('tempo (s)');
    ylabel('amplitude');
    axis([0 t_sim -0.11661 0.05402]);
    hold on 
    plot(imp_resp_saidaobs_model1,'-r','LineWidth',0.7);
    title('Modelo A x Observador A');
    legend({'impulse resp model A', 'impulse obsrv model A'},'Location','southeast');
    hold off
    subplot(223);
    plot(impulse_input,'-b','LineWidth',1.5);
    axis([0 t_sim -10 100]);
    title('Impulse Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    title('Impulse Input');
    legend({'impulse input'},'Location','northeast');
          
    subplot(222); %erro obsv
    plot(imp_resp_erroobs_model1,'-black','LineWidth',1);
    title('Erro Observador A');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'Erro Obsrv A'},'Location','southeast');

    subplot(224); %Estados obsv x estados modelo
    hold on
    plot(Sis_A1_imp_ObsState1,'-magenta','LineWidth',1);
    plot(Sis_A1_imp_ObsState2,'-cyan','LineWidth',1);
    plot(Sis_A1_imp_ObsState3,'-yellow','LineWidth',1);
    plot(Sis_A1_imp_State1,'--black','LineWidth',1);
    plot(Sis_A1_imp_State2,'--r','LineWidth',1);
    plot(Sis_A1_imp_State3,'--b','LineWidth',1);
    title('Estados Model x Obsrv');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'ObsvState1', 'ObsvState2', 'ObsvState3', 'SistState1', 'SistState2', 'SistState3'},'Location','southeast');
    hold off

% Sistema B reposta ao impulso:
    figure;
    subplot(221);
    plot(impulse_resp_model2,'-black','LineWidth',1);
    xlabel('tempo (s)');
    ylabel('amplitude');
    axis([0 t_sim -0.0319 0.02292]);
    hold on 
    plot(imp_resp_saidaobs_model2,'-r','LineWidth',0.7);
    title('Modelo B x Observador B');
    legend({'impulse resp model B', 'impulse obsrv model B'},'Location','southeast');
    hold off
    subplot(223);
    plot(impulse_input,'-b','LineWidth',1.5);
    axis([0 t_sim -10 100]);
    title('Impulse Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    title('Impulse Input');
    legend({'impulse input'},'Location','northeast');
          
    subplot(222); %erro obsv
    plot(imp_resp_erroobs_model2,'-black','LineWidth',1);
    title('Erro Observador B');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'Erro Obsrv B'},'Location','southeast');

    subplot(224); %Estados obsv x estados modelo
    hold on
    plot(Sis_B1_imp_ObsState1,'-magenta','LineWidth',1);
    plot(Sis_B1_imp_ObsState2,'-cyan','LineWidth',1);
    plot(Sis_B1_imp_ObsState3,'-yellow','LineWidth',1);
    plot(Sis_B1_imp_State1,'--black','LineWidth',1);
    plot(Sis_B1_imp_State2,'--r','LineWidth',1);
    plot(Sis_B1_imp_State3,'--b','LineWidth',1);
    title('Estados Model x Obsrv');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'ObsvState1', 'ObsvState2', 'ObsvState3', 'SistState1', 'SistState2', 'SistState3'},'Location','northeast');
    hold off

%%
%
% # *v) Refazer o mesmo com observadores de Luenberger (Ordem reduzida)*
%

%%    
%
% # *vi) Projetar controlador para tornar a resposta ao derau mais rápida em malha fechada utilizando o método de alocação de polos e observador a sua escolha, avaliar sensibilidade da planta a escolha dos polos do controlador e observador*
%   

%% *Exercício 2:*
%
% * *Sistema escolhido representado em espaço de estados:*
%
