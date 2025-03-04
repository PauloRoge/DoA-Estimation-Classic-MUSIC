# Classic-MUSIC

Este repositório contém a implementação do algoritmo **MUSIC (Multiple Signal Classification)** para estimar ângulos de chegada (AoA) em sistemas MIMO. O MUSIC clássico assume que o número de fontes é conhecido a priori; então para esse projeto implementamos critérios para estimar.
## 📌 Características
- Design do Array de antenas; ULA.
- Cenário; free space com Line-of-Sight.
- Sistema; MIMO, M-MIMO.

## 📌 Descrição dos Arquivos

| Arquivo               | Descrição |
|----------------------|-------------------------------------------|
| `main.m`            | Script principal do algoritmo MUSIC       |
| `signals.m`         | Gera/processa sinais                      |
| `responsearray.m`   | Define a matriz de resposta do array      |
| `aic_estimation.m`  | Implementa o critério AIC                 |
| `gap_estimation.m`  | Implementa o critério de separação natural  |
| `mdl_estimation.m`  | Implementa o critério MDL                 |
| `music.m`          | Implementação do algoritmo MUSIC          |
