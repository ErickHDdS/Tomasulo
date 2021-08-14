# Pratica III LAOC-II - Algoritmo de Tomasulo
Prática III implementada na disciplina de Laboratório de Arquitetura e Organização de Computadores II do curso de Engenharia de Computação - CEFET/MG

Check List
=================

<!--ts-->   
   * [Registradores](#registradores)
   * [Testes](#código-teste)
     * [Programa Principal](#programa-principal)    

   * [Desenvolvedores](#realizado-por)
<!--te-->


Registradores
============
R1, R2, R3, R4, R5, R6, R7. <br />
``` cada reg tem 16 bits ```


Código teste:
============

Programa Principal
-----
[000]offset [000]Rz [000]Rx [000]Ry [0000] opcode <br />
Instrucao[0]=16'b0000110010100000; //ADD R3, R1, R2 <br />
Instrucao[1]=16'b0001010110010001; //SUB R5, R3, R1 <br />
Instrucao[2]=16'b0001011001100000; //ADD R5, R4, R6 <br />
Instrucao[3]=16'b0001101011000100; //MUL R6, R5, R4 <br />
Instrucao[4]=16'b0000101010110100; //MUL R2, R5, R3 <br />
Instrucao[5]=16'b0001101011000001; //SUB R6, R5, R4 <br />
Instrucao[6]=16'b0001101011010000; //ADD R6, R5, R5 <br />

## Realizado por:

[**Erick H. D. de Souza**](https://github.com/ErickHDdS) e
[**Marina B. Diniz**](https://github.com/pixel-debug)
