-- Questão 1: Listar alunos ordenados por nome e data de nascimento. 
SELECT nome, data_nascimento
FROM aluno
ORDER BY nome ASC, data_nascimento ASC;

--Questão 2:  Listar professores e suas especialidades em ordem decrescente
SELECT nome, especialidade
FROM professor
ORDER BY nome DESC;

--Questão 3: Listar disciplinas ordenadas por carga horária
SELECT nome, carga_horaria
FROM disciplina
ORDER BY carga_horaria DESC;

--Questão 4: Contar o número de alunos em cada status de matrícula
SELECT status, COUNT(*) AS total_alunos
FROM matricula
GROUP BY status;

--Questão 5: Listar cursos com a soma total da carga horária de suas disciplinas
SELECT c.nome AS curso, SUM(d.carga_horaria) AS carga_horaria_total
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.nome;

--Questão 6: Contar quantos professores estão lecionando mais de 3 turmas
SELECT p.nome, COUNT(t.id_turma) AS total_turmas
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
GROUP BY p.nome
HAVING COUNT(t.id_turma) > 3;

--Questão 7: Listar os alunos matriculados em mais de uma disciplina
SELECT a.nome, COUNT(m.id_disciplina) AS total_disciplinas
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
GROUP BY a.nome
HAVING COUNT(m.id_disciplina) > 1
ORDER BY total_disciplinas DESC;

--Questão 8: Listar cursos com mais de 2000 horas de carga horária
SELECT c.nome, SUM(d.carga_horaria) AS carga_horaria_total
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.nome
HAVING SUM(d.carga_horaria) > 2000;

--Questão 9: Contar o número total de turmas e listar por professor
SELECT p.nome, COUNT(t.id_turma) AS total_turmas
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
GROUP BY p.nome
ORDER BY total_turmas DESC;

--Questão 10: Listar disciplinas e a média da carga horária por curso
SELECT c.nome AS curso, AVG(d.carga_horaria) AS media_carga_horaria
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.nome;

--Questão 11: Exibir os alunos e seus respectivos status de matrícula, ordenados pelo status e pela data de matrícula
SELECT a.nome, m.status, m.data_matricula
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
ORDER BY m.status, m.data_matricula DESC;

--Questão 12: Exibir a idade dos alunos ordenados da maior para a menor idade
SELECT nome, TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento) / 12) AS idade
FROM aluno
ORDER BY idade DESC;

--Questão 13: Exibir as disciplinas e o número de alunos matriculados em cada uma
SELECT d.nome AS disciplina, COUNT(m.id_aluno) AS total_alunos
FROM disciplina d
JOIN matricula m ON d.id_disciplina = m.id_disciplina
GROUP BY d.nome
ORDER BY total_alunos DESC;

--Questão 14: Listar as turmas com o nome dos professores e disciplinas, ordenadas por horário
SELECT t.horario, p.nome AS professor, d.nome AS disciplina
FROM turma t
JOIN professor p ON t.id_professor = p.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
ORDER BY t.horario;

--Questão 15: Contar quantas disciplinas têm carga horária superior a 80 horas
SELECT COUNT(*) AS total_disciplinas
FROM disciplina
WHERE carga_horaria > 80;

--Questão 16: Listar os cursos e a quantidade de disciplinas que cada curso possui
SELECT c.nome AS curso, COUNT(d.id_disciplina) AS total_disciplinas
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
GROUP BY c.nome;

--Questão 17: Exibir os professores que têm mais de 2 disciplinas com carga horária superior a 100 horas
SELECT p.nome, COUNT(d.id_disciplina) AS total_disciplinas
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
WHERE d.carga_horaria > 100
GROUP BY p.nome
HAVING COUNT(d.id_disciplina) > 2;
-- Professor esse somando acima eu fiz com base na questão
-- (que lecionam mais de 2 disciplinas cuja carga horária seja superior a 100 horas) no caso nenhuma discplina tem 100h entt nao retorna nada
-- mas acredito que seria a soma das duas disciplina que outrapassasem 100h que devceria ser contabilazado certo? ai fiz esse script de baixo
-- ai mandei os dois já que fiquei na duvida

SELECT p.nome AS professor, SUM(d.carga_horaria) AS soma_carga_horaria
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
GROUP BY p.nome
HAVING SUM(d.carga_horaria) > 100
ORDER BY soma_carga_horaria DESC;

--Questão 18: Listar disciplinas que tenham pelo menos 5 alunos matriculados
SELECT d.nome AS disciplina, COUNT(m.id_aluno) AS total_alunos
FROM disciplina d
JOIN matricula m ON d.id_disciplina = m.id_disciplina
GROUP BY d.nome
HAVING COUNT(m.id_aluno) >= 5;

--Questão 19: Exibir o número de alunos por status, ordenando pelos status com mais alunos
SELECT m.status, COUNT(m.id_aluno) AS total_alunos
FROM matricula m
GROUP BY m.status
ORDER BY total_alunos DESC;

--Questão 20: Listar professores e a soma da carga horária das disciplinas que lecionam
SELECT p.nome, SUM(d.carga_horaria) AS carga_horaria_total
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
GROUP BY p.nome
ORDER BY carga_horaria_total DESC;

-- outros testes que estava fazendo


SELECT 
    c.nome AS curso,
    d.nome AS disciplina,
    SUM(d.carga_horaria) OVER (PARTITION BY c.id_curso) AS carga_horaria_total
FROM curso c
JOIN disciplina d ON c.id_curso = d.id_curso
ORDER BY c.nome, d.nome ASC;
