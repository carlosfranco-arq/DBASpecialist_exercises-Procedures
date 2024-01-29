
-- verifica e deleta DB criado anteriormente
drop database ecomerce;
-- Criação do DB
create database ecomerce;
use ecomerce;
-- ****************************
-- criando tabelas
-- ****************************

-- criando tabela de endereços
create table address (
AdId INT PRIMARY KEY,
AdStreet VARCHAR(50) not null,
AdNumber VARCHAR(10) not null,							-- exemplo ser n. 1023 fundos
AdComplement VARCHAR(100),
AdNeighborhood VARCHAR(40) not null,
AdCity VARCHAR(30) not null,
AdState ENUM('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO') DEFAULT 'SP'
);
alter table address auto_increment = 1;


-- criando tabela empresas
create table enterprise (				 -- fornecedor e vendedor terceiro tem que ser pessoas jurídicas
EpId int primary key AUTO_INCREMENT,
EpName varchar(20) not null,
EpFantasyName VARCHAR(10) not null,			-- como prefere ser chamado
EpInitDate date,			-- data de início da atividade
AdId INT not null,
EpContact varchar(40) not null,
EpFone VARCHAR(12) not null,
EpEmail varchar(15) not null,
EpCnpj char(15) unique not null,
CONSTRAINT fk_enterprise_address FOREIGN KEY (AdId) REFERENCES address (AdId)
);
alter table enterprise auto_increment = 1;


-- criando tabela usuários
create table users (
UsId int primary key AUTO_INCREMENT,
UsName varchar(40),
UsBirthDate date not null,			-- data de nascimento
AdId INT not null,
UsFone VARCHAR(12) not null,
UsEmail varchar(15) not null,
UsCpf char(11) unique not null
);
alter table users auto_increment = 1;


-- criando tabela de depósitos
create table warehouse (
WhId int primary key auto_increment,
WhName varchar(20) not null,		-- nome do depósito
AdId int not null,
WhPrQtt int,						-- quantidade do produto no depósito
constraint fk_warehouse_address foreign key (AdId) references address (AdId)
);
alter table warehouse auto_increment = 1;


-- criando tabela de produtos
create table product (
PrId int primary key auto_increment,
EpId int not null,
PrDept VARCHAR(20) not null,					-- departamento ex: eletronicos
PrName varchar(20) not null,
PrDescription varchar(100) not null,
PrDetails varchar(100),
PrMaker VARCHAR(20),
PrValue float,
PrUnit char(15),									-- unidade de medida exemplo: peça, kg, metros
constraint fk_product_enterprise foreign key (EpId) references enterprise (EpId) ON DELETE CASCADE
);
alter table product auto_increment = 1;

-- criando a tabela de estoque para cada depósito
create table stock (
StId int primary key,
PrId int not null,
PrQtt int not null,
WhId int not null,
constraint fk_product_stock foreign key (PrId) references product (PrId) ON DELETE CASCADE,
constraint fk_product_warehouse foreign key (WhId) references warehouse (WhId) ON DELETE CASCADE
);
alter table stock auto_increment = 1;

-- criando tabela de clientes
create table costumer (					-- o cliente não precisa logar para colocar no carrinho de compras
CsId int primary key auto_increment,
CsReference varchar(30) not null,			-- id gerada pela API podendo ser MAC+Browser
UsId int,									-- é nulo até que o cliente logue e seja pj
constraint fk_costumer_users foreign key (UsID) references users(UsId) ON DELETE CASCADE
);
alter table costumer auto_increment = 1;


-- criando tabela de carrinho de compras
create table chart (
ChId int primary key auto_increment,
CsId int not null,
constraint fk_costumer_chart foreign key (CsId) references costumer(CsId) ON DELETE CASCADE
);
alter table chart auto_increment = 1;


-- criando tabela de conteudo do carrinho de compras
create table chartContent (
ChId int,
PrId int,
PrQtt int not null,
constraint fk__chart_chartcontent foreign key (ChId) references chart(ChId) ON DELETE CASCADE,
constraint fk_product_chart foreign key (PrId) references product(PrId) ON DELETE CASCADE
);
alter table chartContent auto_increment = 1;

-- criando tabela de pedidos
create table orders (
OrId int primary key auto_increment,
ChId int not null,
AdId int not null,
OrSendValue float,						-- valor total do frete
OrProductValue float not null,			-- valor total dos produtos
OrDiscountValue float,					-- valor do desconto, cupons etc
OrValue float not null,					-- soma dos valores de frete, produtos e desconto
OrStatus enum('aguardando pagamento','gerado')
default 'aguardando pagamento',
constraint fk_chart_adress foreign key (AdId) references address(AdId) ON DELETE CASCADE,
constraint fk_chart_orders foreign key (ChId) references chart(ChId) ON DELETE CASCADE
);
alter table orders auto_increment = 1;


-- criando tabela de entregas
create table delivery (
DeId int primary key auto_increment,
OrId int,
DeStatus enum('em processamento','enviado', 'a caminho para entrega', 'entregue')
default 'em processamento',
DeDtSend date,
DeDtStatus date,							-- data da última atualização
DeDt date,
constraint fk_delivery_OrId foreign key (OrId) references orders(OrId) ON DELETE CASCADE
);
alter table delivery auto_increment = 1;



-- criando a tablea de cartões
create table cards (
CdId int auto_increment primary KEY,
UsId int,
CdNum char(19) not null,
CdName varchar(25) not null,				-- nome no cartão
CdValid date not null,					-- data de validade
constraint fk_cards_users foreign key (UsId) references users(UsId) ON DELETE CASCADE
);
alter table cards auto_increment = 1;


-- criando tabela de pagamentos
create table payment (
PyId int primary key auto_increment,
OrId int,
PyMethod enum('cartão','boleto','pix') default 'pix',
CdId int,
CdOperation enum('débito','crédito') default 'crédito',
PyStatus enum('aguardando pagamento','pago') DEFAULT 'aguardando pagamento',
constraint fk_payment_orders foreign key (OrId) references orders(OrId) ON DELETE CASCADE,
constraint fk_payment_cards foreign key (CdId) references cards(CdId) ON DELETE CASCADE
);
alter table payment auto_increment = 1;

-- criando tabela vendedor terceiro
create table seller (				 -- vendedor terceiro pode ser pessoas físicas ou jurídicas
EpId int,
UsId int,
constraint fk_seller_enterprise foreign key (EpId) references enterprise(EpId) ON DELETE CASCADE,
constraint fk_seller_users foreign key (UsId) references users(UsId) ON DELETE CASCADE
);
alter table seller auto_increment = 1;


--
-- inserindo dados
--

insert into address (AdId,AdStreet,AdNumber,AdComplement,AdNeighborhood,AdCity,AdState) values 
(1,'rua 1',' num1','comple1','bairro1','cidade1','SP'),
(2,'rua 2',' num2','comple2','bairro2','cidade2','RJ'),
(3,'rua 3',' num3','comple3','bairro3','cidade3','MG'),
(4,'rua 4',' num4','comple4','bairro4','cidade4','ES');

insert into enterprise (EpId,EpName,EpFantasyName,EpInitDate,AdId,EpContact,EpFone,EpEmail,EpCnpj) values
('1','razão1','fant1','2000-02-01','1','contato1','fone1','email1','cnpj1'),
('2','razão12','fant12','2000-02-02','2','contato12','fone12','email12','cnpj12'),
('3','razão123','fant123','2000-02-03','3','contato123','fone123','email123','cnpj123'),
('4','razão1234','fant1234','2000-02-04','4','contato1234','fone1234','email1234','cnpj1234');

insert into users (UsId,UsName,UsBirthDate,AdId,UsFone,UsEmail,UsCpf) values
('1','nome1','2000-02-01','1','fone1','email1','cpf1'),
('2','nome12','2000-02-02','2','fone12','email12','cpf12'),
('3','nome123','2000-02-03','3','fone123','email123','cpf123'),
('4','nome1234','2000-02-04','4','fone1234','email1234','cpf1234');

insert into warehouse (WhId,WhName,AdId,WhPrQtt) values
('1','Ware1','1','101'),
('2','Ware2','2','102'),
('3','Ware3','3','103'),
('4','Ware4','4','104');

insert into product (PrId,EpId,PrDept,PrName,PrDescription,PrDetails,PrMaker,PrValue,PrUnit) values
('1','1','vestuário','calça1','calça jeans1','tamamho 39','maker1','102.10', 'unidade'),
('2','2','vestuário1','calça2','calça jeans2','tamamho 40','maker2','103.10', 'litro'),
('3','3','vestuário2','calça3','calça jeans3','tamamho 41','maker3','104.10', 'dúzia'),
('4','4','vestuário3','calça4','calça jeans4','tamamho 42','maker4','105.10', 'caixae'),
('5','1','vestuário4','calça5','calça jeans5','tamamho 43','maker5','106.10', 'pacote'),
('6','2','vestuário5','calça6','calça jeans6','tamamho 44','maker6','107.10', 'peça'),
('7','3','vestuário6','calça7','calça jeans7','tamamho 45','maker7','108.10', 'metro'),
('8','4','vestuário7','calça8','calça jeans8','tamamho 46','maker8','109.10', 'kg');

insert into stock (StId,PrId,PrQtt,WhId) values
('1','1','6000','1'),
('2','3','2000','1'),
('3','5','3000','1'),
('4','6','4000','1'),
('5','1','6000','2'),
('6','2','5000','2'),
('7','3','4000','2'),
('8','4','3000','2'),
('10','5','2000','2'),
('11','3','7000','3'),
('12','5','6000','3'),
('13','6','5000','3'),
('14','7','4000','3'),
('15','8','3000','3'),
('16','2','3000','4'),
('17','3','4000','4'),
('18','4','5000','4'),
('19','5','6000','4'),
('20','6','7000','4'),
('21','7','8000','4'),
('22','8','1000','4');


insert into costumer (CsId,CsReference,UsId) values
('1','mac1','1'),
('2','mac2','2'),
('3','mac3','3'),
('4','mac4','4');


insert into chart (ChId,CsId) values
('1','1'),
('2','2'),
('3','3'),
('4','4');

insert into chartContent (ChId,PrId,PrQtt) values
('1','1','11'),
('1','2','11'),
('1','3','11'),
('1','4','11'),
('2','2','12'),
('2','3','13'),
('2','5','13'),
('2','6','13'),
('2','7','13'),
('2','8','14'),
('3','1','14'),
('3','3','14'),
('3','5','15'),
('3','6','15'),
('4','1','16'),
('4','2','16'),
('4','6','16'),
('4','7','17'),
('4','8','17');

insert into orders(OrId,ChId,AdId,OrSendValue,OrProductValue,OrDiscountValue,OrValue,OrStatus) value
('1','1','1','101','201','10','1001','gerado'),
('2','2','2','202','202','20','1002','gerado'),
('3','4','3','303','203','30','1003','gerado'),
('4','4','4','404','204','40','1004','aguardando pagamento');

insert into delivery(DeId,OrId,DeStatus,DeDtSend,DeDtStatus,DeDt) values
('1','1','enviado','2010-01-01','2011-01-01','2012-01-01'),
('2','2','entregue','2020-01-01','2012-01-01','2012-02-01'),
('3','3','enviado','2030-01-01','2013-01-01','2012-03-01'),
('4','4','entregue','2040-01-01','2014-01-01','2012-04-01');

insert into cards (CdId,UsId,CdNum,CdName,CdValid) values
('1','1','1234 1234 1234 1234','card name 1','2051-01-01'),
('2','2','2234 1234 1234 1234','card name 2','2052-01-01'),
('3','3','3234 1234 1234 1234','card name 3','2053-01-01'),
('4','4','4234 1234 1234 1234','card name 4','2054-01-01');

insert into payment (PyId,OrId,PyMethod,CdId,CdOperation,PyStatus) values
('1','1','pix','1','crédito','pago'),
('2','2','boleto','2',null,'aguardando pagamento'),
('3','3','pix','3','débito','pago'),
('4','4','cartão','4',null,'aguardando pagamento');

insert into seller(EpId,UsId) values
('1',null),
('2',null),
('3',null),
('4',null),
(null,'1'),
(null,'2'),
(null,'3'),
(null,'4');


-- ************************************
-- PROCEDURES
-- ************************************

-- Parte 2 - Utilização de procedures para manipulação de dados em Banco de Dados 
-- Objetivo:  
-- Criar uma procedure que possua as instruções de inserção, remoção e atualização de dados
-- no banco de dados. As instruções devem estar dentro de estruturas condicionais
-- (como CASE ou IF).  
-- Além das variáveis de recebimento das informações, a procedure deverá possuir uma variável
-- de controle. Essa variável de controle irá determinar a ação a ser executada.
-- Ex: opção 1 – select, 2 – update, 3 – delete. 
-- Sendo assim, altere a procedure abaixo para receber as informações supracitadas. 
-- Entregável: 
-- Script SQL com a procedure criada e chamada para manipular os dados de universidade e
 -- e-commerce. Podem ser criados dois arquivos distintos, assim como a utilização do mesmo
 -- script para criação das procedures. Fique atento para selecionar o banco de dados antes
 -- da criação da procedure.
 
 -- ***********************************
 -- PROCEDURE
 -- ***********************************
DROP PROCEDURE IF EXISTS ManageProduct;

DELIMITER //
CREATE PROCEDURE ManageProduct
(
IN action INT,
IN PrIdParam INT,
IN EpIdParam INT,
IN PrDeptParam VARCHAR(20),
IN PrNameParam VARCHAR(20),
IN PrDescriptionParam VARCHAR(100),
IN PrDetailsParam VARCHAR(100),
IN PrMakerParam VARCHAR(20),
IN PrValueParam FLOAT,
IN PrUnitParam CHAR(15)
)
BEGIN
    DECLARE actionMessage VARCHAR(50);

    -- Determinando a ação com base no parâmetro 'action'
    CASE action
        WHEN 1 THEN SET actionMessage = 'SELECT';
        WHEN 2 THEN SET actionMessage = 'UPDATE';
        WHEN 3 THEN SET actionMessage = 'DELETE';
        ELSE
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid action parameter';
    END CASE;

    -- Executando as ações com base no valor de 'action'
    IF action = 1 THEN
        -- SELECT
        SELECT * FROM product WHERE PrId = PrIdParam;
        
    ELSEIF action = 2 THEN
        -- UPDATE
        UPDATE product
        SET EpId = EpIdParam, PrDept = PrDeptParam, PrName = PrNameParam,
            PrDescription = PrDescriptionParam, PrDetails = PrDetailsParam,
            PrMaker = PrMakerParam, PrValue = PrValueParam, PrUnit = PrUnitParam
        WHERE PrId = PrIdParam;

        SELECT CONCAT('Product ', PrIdParam, ' updated successfully.') AS Message;

    ELSEIF action = 3 THEN
        -- DELETE
		-- Excluindo registros relacionados na tabela 'stock'
        DELETE FROM stock WHERE PrId = PrIdParam;
		-- Excluindo o produto
        DELETE FROM product WHERE PrId = PrIdParam;

        SELECT CONCAT('Product ', PrIdParam, ' deleted successfully.') AS Message;

    END IF;
END //
DELIMITER ;

-- Exemplo de chamada para SELECT
CALL ManageProduct(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Exemplo de chamada para UPDATE
CALL ManageProduct(2, 1, 1, 'novo_departamento', 'novo_nome', 'nova_descricao', 'novos_detalhes', 'novo_maker', 99.99, 'nova_unidade');
CALL ManageProduct(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- Exemplo de chamada para DELETE
CALL ManageProduct(3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
CALL ManageProduct(1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

 
