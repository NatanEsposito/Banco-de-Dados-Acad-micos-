CREATE DATABASE BancoAcademico;
GO

USE BancoAcademico;

-- Tabela Predio
CREATE TABLE Predio (
    CodPred INT PRIMARY KEY,
    NomePred VARCHAR(40)
);
GO

-- Tabela Sala
CREATE TABLE Sala (
    CodPred INT,
    NumSala INT,
    DescriSala VARCHAR(40),
    CapacSala INT,
    PRIMARY KEY(CodPred, NumSala),
    FOREIGN KEY(CodPred) REFERENCES Predio(CodPred)
);
GO

-- Tabela Titulacao
CREATE TABLE Titulacao (
    CodTit INT PRIMARY KEY,
    NomeTit VARCHAR(40)
);
GO

-- Tabela Depto
CREATE TABLE Depto (
    CodDepto CHAR(5) PRIMARY KEY,
    NomeDepto VARCHAR(40)
);
GO

-- Tabela Disciplina
CREATE TABLE Disciplina (
    CodDepto CHAR(5),
    NumDisc INT,
    NomeDisc VARCHAR(40),
    CreditoDisc INT,
    PRIMARY KEY (CodDepto, NumDisc),
    FOREIGN KEY (CodDepto) REFERENCES Depto(CodDepto)
);
GO

-- Tabela Professor
CREATE TABLE Professor (
    CodProf INT PRIMARY KEY,
    CodDepto CHAR(5),
    CodTit INT,
    NomeProf VARCHAR(40),
    FOREIGN KEY (CodDepto) REFERENCES Depto(CodDepto),
    FOREIGN KEY (CodTit) REFERENCES Titulacao(CodTit)
);
GO

-- Tabela PreReq
CREATE TABLE PreReq (
    CodDeptoReq CHAR(5),
    NumDiscPreReq INT,
    CodDepto CHAR(5),
    NumDisc INT,
    PRIMARY KEY (CodDeptoReq, NumDiscPreReq, CodDepto, NumDisc),
    FOREIGN KEY (CodDepto, NumDisc) REFERENCES Disciplina(CodDepto, NumDisc),
    FOREIGN KEY (CodDeptoReq, NumDiscPreReq) REFERENCES Disciplina(CodDepto, NumDisc)
);
GO

-- Tabela Turma
CREATE TABLE Turma (
    AnoSem INT,
    CodDepto CHAR(5),
    NumDisc INT,
    SiglaTur CHAR(2),
    CapacTur INT,
    PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTur),
    FOREIGN KEY (CodDepto, NumDisc) REFERENCES Disciplina(CodDepto, NumDisc)
);
GO

-- Tabela Horario
CREATE TABLE Horario (
    AnoSem INT,
    CodDepto CHAR(5),
    NumDisc INT,
    SiglaTur CHAR(2),
    DiaSem INT,
    HoraInicio INT,
    NumSala INT,
    CodPred INT,
    NumHoras INT,
    PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio),
    FOREIGN KEY (AnoSem, CodDepto, NumDisc, SiglaTur) REFERENCES Turma(AnoSem, CodDepto, NumDisc, SiglaTur),
    FOREIGN KEY (CodPred, NumSala) REFERENCES Sala(CodPred, NumSala)
);
GO

-- Tabela ProfTurma
CREATE TABLE ProfTurma (
    AnoSem INT,
    CodDepto CHAR(5),
    NumDisc INT,
    SiglaTur CHAR(2),
    CodProf INT,
    PRIMARY KEY (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf),
    FOREIGN KEY (AnoSem, CodDepto, NumDisc, SiglaTur) REFERENCES Turma(AnoSem, CodDepto, NumDisc, SiglaTur),
    FOREIGN KEY (CodProf) REFERENCES Professor(CodProf)
);
GO

-- Inserção de dados nas tabelas

INSERT INTO Predio (CodPred, NomePred) VALUES
(1, 'Predio A'),
(2, 'Predio B'),
(3, 'Predio C'),
(4, 'Predio D'),
(5, 'Predio E');
GO

INSERT INTO Sala (CodPred, NumSala, DescriSala, CapacSala) VALUES
(1, 101, 'Sala de Computação', 30),
(1, 102, 'Sala de Reuniões', 20),
(2, 201, 'Laboratório de Química', 25),
(3, 301, 'Sala de Aula 301', 40),
(4, 401, 'Sala de Estudos', 15);
GO

INSERT INTO Titulacao (CodTit, NomeTit) VALUES
(1, 'Mestre'),
(2, 'Doutor'),
(3, 'Especialista'),
(4, 'Professor Adjunto'),
(5, 'Professor Assistente');
GO

INSERT INTO Depto (CodDepto, NomeDepto) VALUES
('CS', 'Ciência da Computação'),
('QU', 'Química'),
('MA', 'Matemática'),
('FI', 'Física'),
('EN', 'Engenharia');
GO

INSERT INTO Disciplina (CodDepto, NumDisc, NomeDisc, CreditoDisc) VALUES
('CS', 101, 'Program', 4),
('CS', 102, 'ED', 4),
('QU', 201, 'Química', 4),
('MA', 301, 'Cálculo 1', 5),
('FI', 401, 'Física 1', 5);
GO

INSERT INTO PreReq (CodDeptoReq, NumDiscPreReq, CodDepto, NumDisc) VALUES
('CS', 101, 'CS', 102),
('QU', 201, 'QU', 201),
('MA', 301, 'MA', 301),
('FI', 401, 'FI', 401),
('CS', 102, 'CS', 101);
GO

INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES
(2024, 'CS', 101, 'A', 30),
(2024, 'CS', 102, 'B', 30),
(2024, 'QU', 201, 'A', 25),
(2024, 'MA', 301, 'A', 40),
(2024, 'FI', 401, 'A', 40);
GO

INSERT INTO Horario (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio, NumSala, CodPred, NumHoras) VALUES
(2024, 'CS', 101, 'A', 2, 9, 101, 1, 2),
(2024, 'CS', 102, 'B', 3, 11, 102, 1, 2),
(2024, 'QU', 201, 'A', 4, 14, 201, 2, 3),
(2024, 'MA', 301, 'A', 1, 8, 301, 3, 3),
(2024, 'FI', 401, 'A', 5, 10, 401, 4, 2);
GO

INSERT INTO Professor (CodProf, CodDepto, CodTit, NomeProf) VALUES
(1, 'CS', 2, 'Ana Silva'),
(2, 'QU', 4, 'Carlos Souza'),
(3, 'MA', 5, 'Mariana Lima'),
(4, 'FI', 3, 'Pedro Oliveira'),
(5, 'CS', 1, 'Julia Costa');
GO

INSERT INTO ProfTurma (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf) VALUES
(2024, 'CS', 101, 'A', 1),
(2024, 'CS', 102, 'B', 5),
(2024, 'QU', 201, 'A', 2),
(2024, 'MA', 301, 'A', 3),
(2024, 'FI', 401, 'A', 4);
GO

SELECT * FROM predio;
SELECT * FROM sala;
SELECT * FROM titulacao;
SELECT * FROM depto;
SELECT * FROM disciplina;
SELECT * FROM PreReq;
SELECT * FROM turma;
SELECT * FROM horario;
SELECT * FROM professor;
SELECT * FROM profturma;


-- Criação da Procedure
CREATE PROCEDURE ContarDisciplinasPorDepto
AS
BEGIN
    -- Declaração das variáveis para armazenar os dados do cursor
    DECLARE @CodDepto CHAR(5), @QtdDisciplinas INT;

    -- Declaração do cursor
    DECLARE disciplinas_cursor CURSOR FOR
    -- Seleção do código do departamento e a contagem de disciplinas
    SELECT CodDepto, COUNT(*) AS QtdDisciplinas
    FROM Disciplina
    -- Agrupamento por departamento
    GROUP BY CodDepto;

    -- Abre o cursor para processamento
    OPEN disciplinas_cursor;

    -- Recupera o primeiro registro do cursor e armazena nas variáveis
    FETCH NEXT FROM disciplinas_cursor
    INTO @CodDepto, @QtdDisciplinas;

    -- Loop para processar todos os registros retornados pelo cursor
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Exibe os dados do departamento e a quantidade de disciplinas
        PRINT 'Departamento: ' + @CodDepto + ', Quantidade de Disciplinas: ' + CAST(@QtdDisciplinas AS VARCHAR);

        -- Recupera o próximo registro do cursor e armazena nas variáveis
        FETCH NEXT FROM disciplinas_cursor
        INTO @CodDepto, @QtdDisciplinas;
    END

    -- Fecha o cursor após o processamento
    CLOSE disciplinas_cursor;
    
    -- Desaloca o cursor para liberar os recursos
    DEALLOCATE disciplinas_cursor;
END
GO

SELECT * 
FROM sys.procedures
WHERE name = 'ContarDisciplinasPorDepto';