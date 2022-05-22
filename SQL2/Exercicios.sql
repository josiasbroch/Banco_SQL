# --- AULA 3: ANÁLISES DE DADOS COM SQL --- #

-- Agrupamentos
-- Filtragem avançada
-- Joins
-- Subqueries
-- Criação de Views

-- Lembrando das tabelas do banco de dados...

SELECT * FROM alugueis;
SELECT * FROM atores;
SELECT * FROM atuacoes;
SELECT * FROM clientes;
SELECT * FROM filmes;

# =======        PARTE 1:        =======#
# =======  CRIANDO AGRUPAMENTOS  =======#

-- CASE 1. Você deverá começar fazendo uma análise para descobrir o preço médio de aluguel dos filmes.
SELECT avg(preco_aluguel)
FROM filmes;

-- Agora que você sabe o preço médio para se alugar filmes na hashtagmovie, você deverá ir além na sua análise e descobrir qual é o preço médio para cada gênero de filme.

/*
genero                   | preco_medio
______________________________________
Comédia                  | X
Drama                    | Y
Ficção e Fantasia        | Z
Mistério e Suspense      | A
Arte                     | B
Animação                 | C
Ação e Aventura          | D
*/

-- Você seria capaz de mostrar os gêneros de forma ordenada, de acordo com a média?
SELECT genero, avg(preco_aluguel) as preço_medio
FROM filmes
group by genero;
    


-- Altere a consulta anterior para mostrar na nossa análise também a quantidade de filmes para cada gênero, conforme exemplo abaixo.

/*
genero                   | preco_medio      | qtd_filmes
_______________________________________________________
Comédia                  | X                | .
Drama                    | Y                | ..
Ficção e Fantasia        | Z                | ...
Mistério e Suspense      | A                | ....
Arte                     | B                | .....
Animação                 | C                | ......
Ação e Aventura          | D                | .......
*/

SELECT genero, 
avg(preco_aluguel) as preço_medio, 
count(genero) as qtd_filmes
FROM filmes
group by genero;

-- CASE 2. Para cada filme, descubra a classificação média, o número de avaliações e a quantidade de vezes que cada filme foi alugado. Ordene essa consulta a partir da avaliacao_media, 
-- em ordem decrescente.
SELECT id_filme, 
avg(nota) as avaliacao_media, 
count(nota) as num_avaliacoes,
count(id_aluguel) as num_alugueis
FROM alugueis
group by id_filme
order by avaliacao_media desc;

/*
id_filme  | avaliacao_media   | num_avaliacoes  | num_alugueis
_______________________________________________________
1         | X                 | .               | .
2         | Y                 | ..              | ..
3         | Z                 | ...             | ...
4         | A                 | ....            | ....
5         | B                 | .....           | .....
...
*/



# =======              PARTE 2:               =======#
# =======  FILTROS AVANÇADOS EM AGRUPAMENTOS  =======#

-- CASE 3. Você deve alterar a consulta DO CASE 1 e considerar os 2 cenários abaixo:

-- Cenário 1: Fazer a mesma análise, mas considerando apenas os filmes com ANO_LANCAMENTO igual a 2011.
SELECT genero, 
avg(preco_aluguel) as preço_medio, 
count(genero) as qtd_filmes
FROM filmes
where ano_lancamento = 2011
group by genero;

-- Cenário 2: Fazer a mesma análise, mas considerando apenas os filmes dos gêneros com mais de 10 filmes.
SELECT genero, 
avg(preco_aluguel) as preço_medio, 
count(genero) as qtd_filmes
FROM filmes
group by genero
having qtd_filmes >=10;

# =======              PARTE 3:              =======#
# =======  RELACIONANDO TABELAS COM O JOIN   =======#


-- CASE 4. Selecione a tabela de Atuações. Observe que nela, existem apenas os ids dos filmes e ids dos atores. Você seria capaz de completar essa tabela com as informações de 
-- títulos dos filmes e nomes dos atores?
SELECT 
atuacoes.*,
filmes.titulo,
atores.nome_ator
FROM atuacoes
left join filmes
on atuacoes.id_filme = filmes.id_filme -- coluna em comum
left join atores
on atuacoes.id_ator = atores.id_ator; -- coluna em comum

-- CASE 5. Média de avaliações dos clientes
select 
clientes.nome_cliente,
avg(alugueis.nota) as avaliacao_med
from alugueis
left join clientes
on alugueis.id_cliente = clientes.id_cliente
group by clientes.nome_cliente;

# =======                         PARTE 4:                           =======#
# =======  SUBQUERIES: UTILIZANDO UM SELECT DENTRO DE OUTRO SELECT   =======#

-- CASE 6. Você precisará fazer uma análise de desempenho dos filmes. Para isso, uma análise comum é identificar quais filmes têm uma nota acima da média. Você seria capaz de fazer isso?
select avg(nota) from alugueis; -- media = 7.94

select
filmes.titulo,
avg(alugueis.nota) as avaliacao_media
from alugueis
left join filmes
on alugueis.id_filme = filmes.id_filme
group by filmes.titulo
having avaliacao_media >= 7.94;

-- OU
select
filmes.titulo,
avg(alugueis.nota) as avaliacao_media
from alugueis
left join filmes
on alugueis.id_filme = filmes.id_filme
group by filmes.titulo
having avaliacao_media >= (SELECT AVG(nota) FROM alugueis);

# =======   PARTE 5:     =======#
SELECT * FROM alugueis;
SELECT * FROM atores;
SELECT * FROM atuacoes;
SELECT * FROM clientes;
SELECT * FROM filmes;

# =======  CREATE VIEW   =======#
-- CREATE/DROP VIEW: Guardando o resultado de uma consulta no nosso banco de dados
-- CASE 8. Crie uma view para guardar o resultado do SELECT abaixo e utilizar em uma analise futura

create view resultado as
select
titulo,
count(*) as num_alugueis,
avg(nota) as media_nota,
sum(preco_aluguel) as receita_total
from alugueis
left join filmes
on alugueis.id_filme = filmes.id_filme
group by titulo
order by num_alugueis desc;

select * from resultado;

drop view resultado; -- apagar view
