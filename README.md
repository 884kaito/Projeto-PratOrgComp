# Projeto - Pratica Organização de Computadores
## Projeto Final de Prática de Organização Computacional

Nesta disciplina os alunos trabalharam com o caminho de dados das intruções de um processador feito pelo professor para o ICMC-USP, conhecendo o funcionamento de cada instrução, criando uma nova para ser adicionanda à arquitetura e montando um jogo na linguagem assembly fornecida.

## O jogo

O jogo feito neste projeto é o famoso Conway's Game of Life (jogo da vida de Conway), com bordas esquerda e direita conectadas, tal como as bordas de cima e baixo. Células são pré-selecionadas como vivas ou mortas pelo jogador e quando colocado para rodar, o programa mata e cria células de acordo com as regras definadas por Conway a cada ciclo.

As regras são simples:
- Células tem como células vizinhas as 8 células que rodeiam ela, fornando todas juntas um quadrado 3x3 de células.
- Caso uma célula tenha 3 vizinhos vivos, ela se torna ou se mantém viva.
- Caso uma célula tenha 2 vizinhos vivos, elea se mantém viva ou morta.
- Caso uma célula tenha mais que 3 vizinhos ou menos que dois, ela se torna ou se mantém morta.


### Simular o jogo no computador:

Para jogar o jogo no computador deve ter-se instalado a pasta Simulador. Feito isso, basta abrir o simulador com o executável do Sublime e abrir o arquivo conways.asm pelo simulador. Para compilar aperte F7, e, quando a janela do simulador abrir, basta aperte HOME para as etapas rodarem automaticamente.

As células mortas são representadas por '.' e células vivas são representadas por '#'.

### Como jogar:

- Uma vez inicializado o jogo, o jogador pode navegar entre as células para selecionar qual caracter quer alterar com as teclas **w**, **a**, **s** e **d**.
- Para alterar a célula (de morta para viva ou de viva para morta) aperta-se o botão **c**.
- Para ativar o jogo uma vez que as células tenham sido selecionadas basta apertar **r** para simular.
- Para pausar o jogo e editar as células manualmente novamente, basta apertar **e**.
- Para finalizar o jogo, aperta-se **h**.

### Vídeo de exemplo do funcionamento
[![Vídeo do jogo]()](https://youtu.be/Q2f86QpXnTA)


## A nova instrução para o processador:	LOADZ Rx

A nova função em VHDL feita para o projeto foi a loadz (load-zero), que recebe como argumento um registrador e atribuí a ele o valor 0.

### Mudanças feitas em VHDL para implementação
![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/quartus1.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/quartus3.png)

### Mudanças feitas no montador para implementação

#### Mudanças no def.h

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/def1.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/def2.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/def3.png)

#### Mudanças no montador.c

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/montador1.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/montador2.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/montador3.png)

### Montagem e execução à partir do arquivo .asm

#### Montagem

Para a montagem, precisa compilar o programa que está na pasta Assembler_Source no gcc com seguinte comando:

 gcc *.c -o main
 
 Depois disso, precisa executar o programa com seguinte instrução:
 
 ./main <arquivoEntrada.asm> <cpuram.mif>
 
 Se conseguir executar corretamente, irá aparecer um arquivo cpuram.mif.
 
 
 #### Execução
 
 Para a execução precisa seguir seguintes passos.
 
 - Colocar o cpuram.mif na pasta Processor_Template_VHDL_DE0_CV.
 - Abrir o Quartus a partir do AP9.qpf na mesma pasta. 
 - Compilar e executar o programa no FPGA.

### Teste da instrução

Para verificar o funcionamento da nova instrução nós fizemos dois instruções: uma com o teste.asm e outro com conways.asm. Os arquivos utilizados no teste estão na pasta Assembler_Source.

#### Teste no teste.asm

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/teste.png)

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/teste_feito.jpeg)

Para o teste, fizemos uma programa para aparecer o **Q** na posição 32 se a execução for executada corretamente, e apósa execução verificamos a aparição da letra **Q** na tela.

#### Teste no conways.asm

![alt text](https://github.com/884kaito/Projeto-PratOrgComp/blob/main/Imagens/conways.png)

Para o teste, substituímos todas as instruções de **loadn rx, #0** por **loadz rx** e verificamos que não teve diferença no funcionamento das duas programas.


