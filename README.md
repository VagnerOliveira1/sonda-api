
# Teste back-end - Credere

### Descrição

Uma sonda exploradora da NASA pousou em marte. O pouso se deu em uma área retangular, na qual a sonda pode navegar usando uma interface web. A posição da sonda é representada pelo seu eixo x e y, e a direção que ele está apontado pela letra inicial, sendo as direções válidas:

- `E` - Esquerda
- `D` - Direita
- `C` - Cima
- `B` - Baixo

A sonda aceita três comandos:

- `GE` - girar 90 graus à esquerda
- `GD` - girar 90 graus à direta
- `M` - movimentar. Para cada comando `M` a sonda se move uma posição na direção à qual sua face está apontada.

A sonda inicia no quadrante (x = 0, y = 0), o que se traduz como a casa mais inferior da esquerda; também inicia com a face para a direita.
Se pudéssemos visualizar a posição inicial, seria:

| (0,4) |  (1,4) | (2,4) |  (3,4) | (4,4) |
|:-----:|  ----  |  ---- |  ----  |  ---- |
| (0,3) |  (1,3) | (2,3) |  (3,3) | (4,3) |
| (0,2) |  (1,2) | (2,2) |  (3,2) | (4,2) |
| (0,1) |  (1,1) | (2,1) |  (3,1) | (4,1) |
| * >   |  (1,0) | (2,0) |  (3,0) | (4,0) |

`* Indica a direção inicial da nossa sonda`

A intenção é controlar a sonda enviando a direção e quantidade de movimentos que ela deve executar. A resposta deve ser sua coordenada final caso o ponto se encontre dentro do quadrante, caso o ponto não possa ser alcançado a resposta deve ser um erro indicando que a posição é inválida. Para a execução do teste as dimensões de 5x5 pode ser usado.
### Montar o ambiente
  - Rails 6.0.3.4
  - Ruby 2.7.1
  - rails db:create
  - rake db:migrate
  - rake sonda:setup

### Endpoints

- http://localhost:3000/api/v1/sondas/1 -> Mostra o posição atual da sonda
- http://localhost:3000/api/v1/sondas/1/reset -> Volta para posição inicial
- http://localhost:3000/api/v1/sondas/1/move?commands[]="GE","M","M","M","GD","M","M" -> Realiza Movimentos

### EndPoints no Heroku
https://tranquil-spire-20644.herokuapp.com/api/v1/sondas/1

https://tranquil-spire-20644.herokuapp.com/api/v1/sondas/1/reset

https://tranquil-spire-20644.herokuapp.com/api/v1/sondas/1/move?commands[]="GE"M",M","M","GD","M","M”



Exemplo:

```
{
  movimentos: ['GE', 'M', 'M', 'M', 'GD', 'M', 'M']
}
```

A resposta deve ser:

```
{
  x: 2,
  y: 3
}
```

E a descrição da sequência de movimentos:

```a sonda girou para a esquerda, se moveu 3 casas no eixo y, virou para a direita e andou mais duas casas no eixo x.```

A visualização da posição após esses movimentos seria a seguinte:

| (0,4) |  (1,4) | (2,4) |  (3,4) | (4,4) |
| ----- |  ---- |:----:|  ---- | ---- |
| (0,3) |  (1,3) |   >   |  (3,3) | (4,3) |
| (0,2) |  (1,2) | (2,2) |  (3,2) | (4,2) |
| (0,1) |  (1,1) | (2,1) |  (3,1) | (4,1) |
| (0,0) |  (1,0) | (2,0) |  (3,0) | (4,0) |


Exemplos de movimento inválido seriam os seguintes:

```
{
  movimentos: ['GD', 'M', 'M']
}
```

ou

```
{
  movimentos: ['M', 'M', 'M', 'M', 'M', 'M']
}
```

A resposta pode ser algo como:

```
{
  "erro": "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv"
}
```
