% # *v) Refazer o mesmo com observadores de Luenberger (Ordem reduzida)*
%
% Para o projeto do observadr de ordem reduzida temos para ambos os
% sistemas um estado relacionado a saída pela matriz C (x3 no caso do 
% sistema A e x1 no caso do sistema B). 
% Dessa maneira podemos reduzir a ordem do observador para estimar apenas 
% os outros dois estados.
%
% Iniciamos reordenando as matrizes para separar a parde medida e a parte
% estimada:

% Para o sistema A temos o estado x3 medido e os demais estimados,
% reordenando as matrizes chegamos nos seguintes valores:
A_Aaa = [-0.7];
A_Aab = [-0.005, -0.11];
A_Aba = [(0);(1)]; 
A_Abb = [0,1;0,0];

Areord = [A_Aaa, A_Aab;A_Aba,A_Abb]





A_Ba = [-0.1];
A_Bb = [0.1;-0.2];

A_Ca = [1];
A_Cb = [0,0];


A_Ke = [1;1]

% Seguindo a equação apresentada por Ogata para isolar a saída dos estados temos:
    A_AObs = (A_Abb-(A_Ke*A_Aab))
    A_BObs = ((A_AObs*Ke) + A_Aba - (A_Ke*A_Aaa))
    A_FObs = (A_Bb - (A_Ke*A_Ba))
    A_CObs = (eye(2))
    A_DObs = [1;A_Ke]
% A equação característica do observador para o sistema A será então:
% det|sI – Abb – KeAab|= s²+s(0.005k1+0.11k2)+0.005k2
%



% Para o sistema B temos o estado x1 medido e os demais estimados,
% reordenando as matrizes chegamos nos seguintes valores:
B_Aaa = [-0.2];
B_Aab = [-0.2, 0.4];
B_Aba = [(0.5);(0)]; 
B_Abb = [0,1;-0.4,-0.4];

B_Ba = [0.01];
B_Bb = [0;0.05];

B_Ca = [1];
B_Cb = [0,0];



C_TESTE = [1,0,0]
KEteste = [1;1;1]


syms k1 k2 s
kteste = [k1;k2]
resultado = (s*eye(2))-A_Abb-(kteste*A_Aab)

det(resultado)
