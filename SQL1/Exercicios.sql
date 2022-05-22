select * from alugueis; -- 578 alugueis

-- 1)Utilize o comando LIMIT para visualizar apenas as 10 primeiras linhas da tabela de FILMES.
select * from filmes limit 10;

-- 2)Utilize o comando LIMIT para visualizar apenas as 50 primeiras linhas da tabela de CLIENTES.
select * from clientes limit 50;

-- 3) Existem 7 GÊNEROS DE FILMES: Comédia, Drama, Ficcao e fantasia, misterio e suspense, arte, animaçao, acao e aventura.
-- Verifique se todos estao presentes, se nao estiver, reporte ao responsavel:
select distinct genero from filmes;

-- 4)
select distinct estado, regiao from clientes;

-- 5)
select * 
from atores 
order by ano_nascimento desc;

-- 6)
select nome_cliente, data_criacao_conta
from clientes
order by data_criacao_conta limit 3;

-- 7)
select titulo, genero, duracao
from filmes
order by duracao desc limit 5;

-- 8)
select * 
from filmes
where genero = 'Comedia';

-- 9)
select * 
from filmes
where ano_lancamento = 2003;

-- 10)
select * 
from atores
where nacionalidade IN ('Austrália', 'Canadá', 'Irlanda do Norte');

-- 11)
select * 
from filmes
where duracao BETWEEN 90 AND 100;

-- 12)
select count(id_aluguel)
from alugueis;

-- 13)
select count(id_aluguel and nota)
from alugueis;

-- 14)
select count(distinct genero)
from filmes;

-- 15)
select sum(duracao)
from filmes;

-- 16)
select min(duracao), max(duracao)
from filmes;

-- 17)
select avg(nota) -- media
from alugueis;









 





