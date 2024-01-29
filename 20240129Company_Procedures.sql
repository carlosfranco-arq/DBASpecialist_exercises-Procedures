DROP SCHEMA company_constraints;
CREATE SCHEMA IF NOT EXISTS company_constraints;
USE company_constraints;

CREATE TABLE employee(
Fname VARCHAR(15) NOT NULL,
Minit CHAR,
Lname VARCHAR(15) NOT NULL,
Ssn CHAR(9) NOT NULL,
Bdate DATE,
Address VARCHAR(30),
sex CHAR,
Salary DECIMAL(10,2),
Super_ssn CHAR(9),
Dno INT NOT NULL,
constraint chk_salary_employee check (Salary> 2000.0),
constraint pk_employee PRIMARY KEY (Ssn)
);

CREATE TABLE departament(
Dname VARCHAR(20) NOT NULL,
Dnumber INT NOT NULL,
Mgr_ssn CHAR(9),
Mgr_star_date DATE,
Dept_create_date DATE,
constraint chk_date_dept check (Dept_create_date < Mgr_star_date),
constraint pk_dept PRIMARY KEY (Dnumber),
constraint unique_name_dept Unique(Dname),
FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
);

CREATE TABLE dept_locations(
Dnumber INT NOT NULL,
Dlocation VARCHAR(15) NOT NULL,
constraint pk_dept_locations PRIMARY KEY (Dnumber,Dlocation),
constraint fk_dept_locations FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
);

CREATE TABLE project(
Pname VARCHAR(15) NOT NULL,
Pnumber INT NOT NULL,
Plocation VARCHAR(15),
Dnum INT NOT NULL,
PRIMARY KEY (Pnumber),
constraint unique_project_name UNIQUE (Pname),
constraint fk_project FOREIGN KEY (Dnum) REFERENCES departament(Dnumber)
);

CREATE TABLE works_on(
Essn CHAR(9) NOT NULL,
Pno INT NOT NULL,
Hours DECIMAL(3,1) NOT NULL,
PRIMARY KEY (Essn, Pno),
constraint fk_employee_works_on FOREIGN KEY (Essn) REFERENCES employee(Ssn),
constraint fk_project_works_on FOREIGN KEY (Pno) REFERENCES project(Pnumber)
);

CREATE TABLE dependent(
Essn CHAR(9) NOT NULL,
Dependent_name VARCHAR(15) NOT NULL,
Sex CHAR, -- F ou M
Bdate DATE,
Relationship VARCHAR(8),
Age int not null,
constraint chk_age_dependent check (Age < 22),
PRIMARY KEY (Essn, Dependent_name),
constraint fk_dependent FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);


select * from information_schema.table_constraints where constraint_schema = 'company_constraints';
    
-- select * from information_schema.referential_constraints where constraint_schema = 'company_constraints';

-- Inserir 15 registros na tabela employee, garantindo que Super_ssn tenha apenas 5 valores diferentes
INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES
    ('John', 'A', 'Doe', '111111111', '1990-01-01', '123 Main St', 'M', 3000.00, '111111111', 1),
    ('Jane', 'B', 'Smith', '222222222', '1985-05-15', '456 Oak St', 'F', 3500.00, '222222222', 2),
    ('Bob', 'C', 'Johnson', '333333333', '1992-09-30', '789 Pine St', 'M', 2800.00, '333333333', 3),
    ('Alice', 'D', 'Williams', '444444444', '1988-12-12', '101 Cedar St', 'F', 3200.00, '444444444', 4),
    ('Mike', 'E', 'Brown', '555555555', '1995-04-05', '202 Maple St', 'M', 3000.00, '555555555', 5),
    ('Sarah', 'F', 'Davis', '666666666', '1993-07-20', '303 Elm St', 'F', 4000.00, '111111111', 6),
    ('David', 'G', 'Miller', '777777777', '1998-03-18', '404 Walnut St', 'M', 3800.00, '222222222', 7),
    ('Emily', 'H', 'Jones', '888888888', '1991-11-25', '505 Oakwood St', 'F', 3200.00, '333333333', 8),
    ('Chris', 'I', 'Lee', '999999999', '1986-08-07', '606 Pine Lane', 'M', 3500.00, '444444444', 5),
    ('Tom', 'J', 'Clark', '123456789', '1997-02-14', '707 Birch Ave', 'M', 3000.00, '555555555', 6),
    ('Eva', 'K', 'Taylor', '111222333', '1994-06-22', '808 Cedar Lane', 'F', 4100.00, '555555555', 7),
    ('Sam', 'L', 'Moore', '444555666', '1990-10-11', '909 Maple Ave', 'M', 3400.00, '555555555', 5),
    ('Olivia', 'M', 'Johnson', '333111222', '1987-04-03', '101 Pine Circle', 'F', 3700.00, '555555555', 3),
    ('Ryan', 'N', 'Martin', '555111444', '1996-09-28', '202 Oak Lane', 'M', 3100.00, '555555555', 4),
    ('Sophia', 'O', 'White', '777111999', '1992-12-17', '303 Elm Circle', 'F', 3300.00, '555555555', 5);

-- Inserir mais de 8 registros na tabela departament
INSERT INTO departament (Dname, Dnumber, Mgr_ssn, Mgr_star_date, Dept_create_date) VALUES
    ('Sales', 1, '111111111', '2020-01-01', '2019-01-01'),
    ('Marketing', 2, '222222222', '2021-02-15', '2019-02-15'),
    ('Finance', 3, '333333333', '2022-03-30', '2019-03-30'),
    ('Human Resources', 4, '444444444', '2023-04-10', '2019-04-10'),
    ('Research', 5, '555555555', '2024-05-20', '2019-05-20'),
    ('Development', 6, '666666666', '2020-06-01', '2019-06-01'),
    ('IT', 7, '777777777', '2021-07-15', '2019-07-15'),
    ('Customer Support', 8, '888888888', '2022-08-25', '2019-08-25'),
    ('Operations', 9, '999999999', '2023-09-05', '2019-09-05'),
    ('Quality Assurance', 10, '123456789', '2024-10-15', '2019-10-15'),
    ('Legal', 11, '111111111', '2020-11-01', '2019-11-01'),
    ('Production', 12, '222222222', '2021-12-15', '2019-12-15'),
    ('Supply Chain', 13, '333333333', '2022-01-30', '2020-01-30'),
    ('Logistics', 14, '444444444', '2023-02-10', '2020-02-10'),
    ('Facilities', 15, '555555555', '2024-03-20', '2020-03-20');


-- Inserir registros na tabela dept_locations
INSERT INTO dept_locations (Dnumber, Dlocation) VALUES
    (1, 'New York'),
    (2, 'New York'),
    (3, 'New York'),
    (4, 'New York'),
    (5, 'New York'),
    (6, 'Chicago'),
    (14, 'Chicago'),
    (15, 'Chicago'),
    (7, 'Chicago'),
    (8, 'Chicago'),
    (1, 'Los Angeles'),
    (13, 'Los Angeles'),
    (14, 'Los Angeles'),
    (15, 'Los Angeles'),
    (2, 'Los Angeles'),
    (3, 'Los Angeles'),
    (4, 'San Francisco'),
    (9, 'San Francisco'),
    (8, 'San Francisco'),
    (5, 'San Francisco'),
    (6, 'San Francisco'),
    (7, 'Houston'),
    (15, 'Houston'),
    (13, 'Houston'),
    (12, 'Houston'),
    (8, 'Houston'),
    (1, 'Miami'),
    (7, 'Miami'),
    (6, 'Miami'),
    (9, 'Miami'),
    (3, 'Miami');


-- Inserir 15 registros na tabela project
INSERT INTO project (Pname, Pnumber, Plocation, Dnum) VALUES
    ('ProjectA', 1, 'New York', 1),
    ('ProjectB', 2, 'Chicago', 2),
    ('ProjectC', 3, 'Los Angeles', 4),
    ('ProjectD', 4, 'San Francisco', 4),
    ('ProjectE', 5, 'Houston', 5),
    ('ProjectF', 6, 'New York', 6),
    ('ProjectG', 7, 'Chicago', 7),
    ('ProjectH', 8, 'Los Angeles', 15),
    ('ProjectI', 9, 'San Francisco', 13),
    ('ProjectJ', 10, 'Houston', 11),
    ('ProjectK', 11, 'New York', 11),
    ('ProjectL', 12, 'Chicago', 11),
    ('ProjectM', 13, 'Los Angeles', 10),
    ('ProjectN', 14, 'San Francisco', 14),
    ('ProjectO', 15, 'Houston', 15);


-- Inserir registros na tabela works_on
INSERT INTO works_on (Essn, Pno, Hours) VALUES
    ('111111111', 1, 20.5),
    ('111111111', 15, 22.5),
    ('111111111', 13, 24.5),
    ('222222222', 10, 11.0),
    ('222222222', 1, 15.0),
    ('222222222', 12, 11.0),
    ('222222222', 11, 25.0),
    ('333333333', 4, 25.5),
    ('333333333', 8, 22.5),
    ('333333333', 5, 12.5),
    ('444444444', 12, 8.0),
    ('444444444', 2, 28.0),
    ('444444444', 6, 18.0),
    ('555555555', 2, 22.5),
    ('555555555', 6, 12.5),
    ('555555555', 8, 27.5),
    ('666666666', 7, 30.0),
    ('666666666', 9, 3.0),
    ('666666666', 2, 31.0),
    ('777777777', 3, 10.5),
    ('777777777', 1, 16.5),
    ('888888888', 3, 27.5),
    ('888888888', 13, 12.5),
    ('999999999', 13, 15.5),
    ('999999999', 15, 10.5),
    ('999999999', 3, 19.5),
    ('123456789', 4, 2.0),
    ('123456789', 14, 12.0),
    ('123456789', 5, 15.0),
    ('123456789', 9, 19.0);

-- Inserindo dados na tabela dependent
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship, Age)
VALUES 
  ('444444444', 'Mary', 'F', '2010-02-20', 'Child', 12),
  ('444444444', 'Joe', 'M', '2015-08-10', 'Child', 6),
  ('123456789', 'Sue', 'F', '2018-04-05', 'Child', 3);
  
  -- -------------------------------------------
  

-- Parte 1 – Criando índices em Banco de Dados 
-- Criação de índices para consultas para o cenário de company com as perguntas (queries sql)
-- para recuperação de informações. Sendo assim, dentro do script será criado os índices com
-- base na consulta SQL.  
-- O que será levado em consideração para criação dos índices? 
    -- Quais os dados mais acessados 
    -- Quais os dados mais relevantes no contexto 
-- Lembre-se da função do índice... ele impacta diretamente na velocidade da busca pelas
-- informações no SGBD. Crie apenas aqueles que são importantes. Sendo assim, adicione um
-- README dentro do repositório do Github explicando os motivos que o levaram a criar tais
-- índices. Para que outras pessoas possam se espelhar em seu trabalho, crie uma breve
-- descrição do projeto. 
-- A criação do índice pode ser criada via ALTER TABLE ou CREATE Statement, como segue o
-- exemplo: 
    -- ALTER TABLE customer ADD UNIQUE index_email(email); 
    -- CREATE INDEX index_ativo_hash ON exemplo(ativo) USING HASH; 
-- Perguntas:  
    -- Qual o departamento com maior número de pessoas? 
    -- Quais são os departamentos por cidade? 
    -- Relação de empregrados por departamento 
-- Entregável: 
    -- Crie as queries para responder essas perguntas 
    -- Crie o índice para cada tabela envolvida (de acordo com a necessidade) 
    -- Tipo de indice utilizado e motivo da escolha (via comentário no script ou readme) 


-- **************************************** 
-- Respostas
-- ****************************************
-- Qual o departamento com maior número de pessoas? 
DROP PROCEDURE IF EXISTS FindDeptWithMaxEmployees;
DELIMITER //
CREATE PROCEDURE FindDeptWithMaxEmployees()
BEGIN
    SELECT e.Dno, d.Dname, COUNT(*) AS NumEmployees
    FROM employee e
    JOIN departament d ON e.Dno = d.Dnumber
    GROUP BY e.Dno, d.Dname
    ORDER BY NumEmployees DESC
    LIMIT 1;
END //
DELIMITER ;
CALL FindDeptWithMaxEmployees();

-- Quais são os departamentos por cidade? 
DROP PROCEDURE IF EXISTS ListDeptsByCity;
DELIMITER //
CREATE PROCEDURE ListDeptsByCity()
BEGIN
    SELECT dl.Dlocation, d.Dnumber, d.Dname
    FROM dept_locations dl
    JOIN departament d ON dl.Dnumber = d.Dnumber
    GROUP BY dl.Dlocation, d.Dnumber, d.Dname
    ORDER BY COUNT(*) DESC, dl.Dlocation;
END //
DELIMITER ;

CALL ListDeptsByCity();

-- Relação de empregrados por departamento
DROP PROCEDURE IF EXISTS ListEmployeesByDept;
DELIMITER //
CREATE PROCEDURE ListEmployeesByDept()
BEGIN
    SELECT d.Dname, d.Dnumber, e.Fname, e.Lname
    FROM departament d
    LEFT JOIN (
        SELECT Dno, Fname, Lname
        FROM employee
    ) e ON d.Dnumber = e.Dno
    ORDER BY (SELECT COUNT(*) FROM employee WHERE Dno = d.Dnumber) DESC, d.Dname, d.Dnumber;
END //
DELIMITER ;
CALL ListEmployeesByDept();

-- Crie o índice para cada tabela envolvida (de acordo com a necessidade)
-- Qual o departamento com maior número de pessoas? 
CREATE INDEX idx_dnumber ON departament(Dnumber);
-- ou pela instrução ALTER TABLE
ALTER TABLE departament
ADD INDEX idx_dnumber (Dnumber);
-- Tipo de indice utilizado e motivo da escolha (via comentário no script ou readme)

-- Quais são os departamentos por cidade? 
CREATE INDEX idx_dno ON employee(Dno);
-- ou pela instrução ALTER TABLE
ALTER TABLE employee
ADD INDEX idx_dnumber (Dno);

-- Relação de empregrados por departamento
-- Os indices criados acima já contempla a procedure ListEmployeesByDept

-- ***************************
-- RESPOSTA: O tipo de index criado é B-Tree pois os dados são distribuidos entre muitos departamentos
-- ***************************
