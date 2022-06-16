%% *Exercício 2:*
%
% * *Sistema escolhido representado em espaço de estados:*
%
% O sistema escolhido é um sistema de suspensão e tem como base um exemplo
% genérico de modelo para suspensão que aborda o seguinte problema:
% 
% Parametros do sistema:
% (M1)    1/4 bus body mass                        2500 kg
% (M2)    suspension mass                          320 kg
% (K1)    spring constant of suspension system     80,000 N/m
% (K2)    spring constant of wheel and tire        500,000 N/m
% (b1)    damping constant of suspension system    350 N.s/m
% (b2)    damping constant of wheel and tire       15,020 N.s/m
% (U)     control force
%
% Dessa maneira temos o seguinte sistema representado em espaço de estados:
m = 0.111;
R = 0.015;
g = -9.8;
J = 9.99e-6;

H_ball = -m*g/(J/(R^2)+m);

A_ball = [0 1 0 0
     0 0 H_ball 0
     0 0 0 1
     0 0 0 0];
B_ball = [0;0;0;1];
C_ball = [1 0 0 0];
D_ball = [0];

ball_ss = ss(A_ball,B_ball,C_ball,D_ball);

p1_ball = -2+2i;
p2_ball = -2-2i;
p3_ball = -20;
p4_ball = -80;

K_ball = place(A_ball,B_ball,[p1_ball,p2_ball,p3_ball,p4_ball])


% Verificando a observabilidade e controlabilidade:
Matriz_Cntrl_ball = ctrb(A_ball,B_ball);
% Verificando o posto (rank) da matrizes de controlabilidade
Posto_Matriz_Cntrl_ball = rank(Matriz_Cntrl_ball);

% Matrizes de observabilidade:
Matriz_Observ_ball = obsv(A_ball,C_ball);
% Verificando o posto (rank) das matrizes de observabilidade
Posto_Matriz_Obsv_ball = rank(Matriz_Observ_ball);

% Ambos os ranks das matrizes de observabilidade e controlabilidade são 4,
% o mesmo número da ordem do sistema o que indica que o sistema é controlável e observável.

% Estabilidade em Malha aberta:
Estabilidade_Sistema_ball = eig(A_ball);
% Todos os polos do sistema estão na origem indicando que o
% sistema é instável em malha aberta.

% Projeto do observador de ordem completa:
AObs_ball = A_ball;
BObs_ball = B_ball;
CObs_ball = C_ball;
DObs_ball = D_ball;

% Polos escolhidos duas vezes mais rápidos que os polos dominantes do sistema:
p1_ball = -4.5;
p2_ball = -4.5;
p3_ball = -50;
p4_ball = -170;


 pr_obs=[p1_obs p2_obs p3_obs p4_obs];
 eqco_obs = poly(pr_obs);
% Com isso os polos desejados são -4+/-2i, -20 e -80, resultando na seguinte equação
% desejada: s4+104s3+2004s2+6800s+6400
% Calculando os valores de Ke:
Ke_ball = acker(AObs_ball,BObs_ball,pr_obs);
% Ke_ball = 914.3    971.4    2004.0    104.0

% Projeto do Observador de ordem mínima
% Como x1 é relacionado a saída podemos assumir o observador com uma ordem
% a menos. Organizando as matrizs temos:
    Ball_Aaa = [0];
    Ball_Aab = [1, 0, 0];
    Ball_Aba = [0; 0; 0]; 
    Ball_Abb = [0,7,0;0,0,1;0,0,0];

    Ball_Ba = [0];
    Ball_Bb = [0;0;1];

    Ball_Ca = [1];
    Ball_Cb = [0,0,0];

% A equação característica do observador para o sistema ball será então:
    % Com isso os polos desejados são -4+/-2i, -40
    p1_obs_ordmin = -4+2i;
    p2_obs_ordmin = -4-2i;
    p3_obs_ordmin = -40;

    pr_obs_ordmin=[p1_obs_ordmin p2_obs_ordmin p3_obs_ordmin];
    eqco_obs_ordmin = poly(pr_obs_ordmin);
% Resultando na seguinte equação desejada: s3+48s2+340s+800
% Calculando os valores de Ke:
    Ke_ball_ordmin = acker(Ball_Abb',Ball_Aab',pr_obs_ordmin);
    Ke1_ball_ordmin = Ke_ball_ordmin(1);
    Ke2_ball_ordmin = Ke_ball_ordmin(2);
    Ke3_ball_ordmin = Ke_ball_ordmin(3);
    Ke_ball_ordmin = [Ke1_ball_ordmin;Ke2_ball_ordmin;Ke3_ball_ordmin]
    
% Seguindo a equação apresentada por Ogata para isolar a saída dos estados temos:
    Ball_AObs = (Ball_Abb-(Ke_ball_ordmin*Ball_Aab));
    Ball_BObs = ((Ball_AObs*Ke_ball_ordmin) + Ball_Aba - (Ke_ball_ordmin*Ball_Aaa));
    Ball_FObs = (Ball_Bb - (Ke_ball_ordmin*Ball_Ba));
    Ball_CObs = [[0 0 0];[eye(3)]];
    Ball_DObs = [1;Ke_ball_ordmin];

    
% Necessário adição do termo N para corrigir o erro em regime permanente:
N_termo = rscale(A_ball,B_ball,C_ball,D_ball,K_ball);

t_sim = 150;
sim('Exercicio_1gball_sim',t_sim);

% Resposta ao degrau com observador de ordem reduzida do sistema
    figure;
    subplot(211);
    plot(OrdMinCntrl_step_resp_ball,'-black','LineWidth',1);
    xlabel('tempo (s)');
    ylabel('amplitude');
    axis([0 t_sim -0.4 1.2]);
    title('Sistema com realimentação por observador de ordem reduzida');
    legend({'resposta ao degrau'},'Location','southeast');
    subplot(212);
    plot(OrdMinCntrl_step_input_ball,'-b','LineWidth',1.5);
    axis([0 t_sim -1 1.5]);
    title('Resposta ao degrau com controle');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    title('Step Input');
    legend({'step input'},'Location','southeast');
    
    %Comparação dos estados observados e do sistema
    figure;
    subplot(212);
    plot(OrdMinCntrl_step_input_ball,'-b','LineWidth',1.5);
    axis([1 5 -1 1.5]);
    title('Step Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    title('Sist Step Input');
    legend({'step input'},'Location','southeast');
          
    subplot(211); %estados obsv ordem min x estados modelo
    hold on
    plot(Sis_ball_OrdMin_ObsState1,'-magenta','LineWidth',1);
    plot(Sis_ball_OrdMin_ObsState2,'-cyan','LineWidth',1);
    plot(Sis_ball_OrdMin_ObsState3,'-yellow','LineWidth',1);
    plot(Sis_ball_OrdMin_ObsState4,'-g','LineWidth',1);
    plot(Sis_ball_OrdMin_State1,'--black','LineWidth',1);
    plot(Sis_ball_OrdMin_State2,'--r','LineWidth',1);
    plot(Sis_ball_OrdMin_State3,'--b','LineWidth',1);
    plot(Sis_ball_OrdMin_State4,'--black','LineWidth',1);
    axis([1 5 -10 10]);
    title('Estados Sist x Obsrv Ordem Reduzida');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'ObsvState1', 'ObsvState2', 'ObsvState3', 'ObsvState4', 'SistState1', 'SistState2', 'SistState3', 'SistState4'},'Location','southeast');
    hold off
    
% Resposta ao degrau com observador de ordem plena do sistema
    figure;
    subplot(211);
    plot(step_resp_ball,'-black','LineWidth',1);
    xlabel('tempo (s)');
    ylabel('amplitude');
    axis([0 t_sim -0.4 1.2]);
    title('Sistema com realimentação por observador de ordem plena');
    legend({'resposta ao degrau'},'Location','southeast');
    subplot(212);
    plot(step_input_ball,'-b','LineWidth',1.5);
    axis([0 t_sim -1 1.5]);
    title('Resposta ao degrau com controle');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    title('Step Input');
    legend({'step input'},'Location','southeast');

    %Comparação dos estados observados e do sistema
    figure;
    subplot(212);
    plot(step_input_ball,'-b','LineWidth',1.5);
    axis([0 t_sim -1 1.5]);
    title('Step Input');
    xlabel('tempo (s)'); 
    ylabel('amplitude'); 
    title('Sist Step Input');
    legend({'step input'},'Location','southeast');
          
    subplot(211); %estados obsv ordem plena x estados modelo
    hold on
    plot(Sis_ball_ObsState1,'-magenta','LineWidth',1);
    plot(Sis_ball_ObsState2,'-cyan','LineWidth',1);
    plot(Sis_ball_ObsState3,'-yellow','LineWidth',1);
    plot(Sis_ball_ObsState4,'-g','LineWidth',1);
    plot(Sis_ball_State1,'--black','LineWidth',1);
    plot(Sis_ball_State2,'--r','LineWidth',1);
    plot(Sis_ball_State3,'--b','LineWidth',1);
    plot(Sis_ball_State4,'--black','LineWidth',1);
    axis([0 t_sim -10 10]);
    title('Estados Sist x Obsrv Ordem Reduzida');
    xlabel('tempo (s)');
    ylabel('amplitude');
    legend({'ObsvState1', 'ObsvState2', 'ObsvState3', 'ObsvState4', 'SistState1', 'SistState2', 'SistState3', 'SistState4'},'Location','southeast');
    hold off

    % Notamos que o observador e ordem reduzida apresetnou um melhor
    % comportamento para o controle por realimentação de estados.