# Projeto - Pratica Orgazição de Computadores
## Projeto Final de Prática de Organização Computacional

Nesta disciplina os alunos trabalharam com o caminho de dados das intruções de um processador feito pelo professor para o ICMC-USP, conhecendo o funcionamento de cada instrução, criando uma nova para ser adicionanda à arquitetura e montando um jogo na linguagem assembly fornecida.

## A nova função em VHDL:	LOADZ Rx

A nova função em VHDL feita para o projeto foi a loadz (load-zero), que recebe como argumento um registrador e atribuí a ele o valor 0.

### Código da nova função em VHDL
![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/quartus1.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/quartus2.png)

### Teste em assembly da nova função em VHDL

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/def1.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/def2.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/def3.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/montador1.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/montador2.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/montador3.png)


## O jogo em Assembly

O jogo feito neste projeto é o famoso Conway's Gaem of Life (jogo da vida de Conway), com bordas esquerda e direita conectadas, tal como as bordas de cima e baixo. Células são pré-selecionadas como vivas ou mortas pelo jogador e quando colocado para rodar, o programa mata e cria células de acordo com as regras definadas por Conway.


## Simular o jogo no computador:

Para jogar o jogo no computador deve ter-se instalado o simulador disponibilizado pelo professor Simões e, na pasta Simulador, incluir o arquivo .asm do jogo que disponibilizado. Feito isso, basta abrir o simulador com o executável do Sublime e abrir o arquivo .asm. Para compilar aperte F7, e, quando a janela do simulador abrir, basta aperte HOME para as etapas rodarem automaticamente.

## Como jogar:

- Uma vez inicializado o jogo, o jogador pode navegar as células para selecionar qual caracter quer alterar com as tecls w, a, s e d.
- Para alterar a célula (de morta para viva ou de viva para morta) aperta-se o botão c.
- Para ativar o jogo uma vez que as células tenham sido selecionadas basta apertar r para simular.
- Para pausar o jogo e editar as células manualmente novamente, basta apertar e.
- Para finalizar o jogo, aperta-se h.
