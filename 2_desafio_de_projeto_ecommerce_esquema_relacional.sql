-- Criação do Banco de Dados para o cenário de E-commerce
CREATE DATABASE ecommerce;
USE ecommerce;

-- criar tabela cliente
CREATE TABLE clients(
		idClient INT AUTO_INCREMENT PRIMARY KEY,
        Fname VARCHAR(10),
        Minit CHAR(3),
        Lname VARCHAR(20),
        CPF CHAR(11) NOT NULL,
        Address VARCHAR(255),
        CONSTRAINT unique_cpf_client UNIQUE (CPF)
);
ALTER TABLE clients AUTO_INCREMENT=1;

-- criar tabela produto
-- size = dimensão do produto
CREATE TABLE product(
		idProduct INT AUTO_INCREMENT PRIMARY KEY,
        Pname VARCHAR(255) NOT NULL,
        classification_kids BOOL DEFAULT FALSE,
        category ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
        avaliação FLOAT DEFAULT 0,
        size VARCHAR(10)
);
ALTER TABLE product AUTO_INCREMENT=1;

-- criar tabela pedido
-- drop table orders;
CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderStatus ENUM('Cancelado','Confirmado','Em processamento') DEFAULT 'Em processamento',
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOLEAN DEFAULT FALSE, 
    CONSTRAINT fk_ordes_client FOREIGN KEY (idOrderClient) REFERENCES clients(idClient)
			ON UPDATE CASCADE
);
ALTER TABLE orders AUTO_INCREMENT=1;

-- criar tabela estoque
CREATE TABLE productStorage(
	idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);
ALTER TABLE productStorage AUTO_INCREMENT=1;

-- criar tabela fornecedor
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);
ALTER TABLE supplier AUTO_INCREMENT=1;

-- criar tabela vendedor
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CNPJ CHAR(15),
    CPF CHAR(9),
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);
ALTER TABLE seller AUTO_INCREMENT=1;


-- tabelas de relacionamentos M:N

-- para ser continuado no desafio: termine de implementar a tabela "payments" e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento

CREATE TABLE payments(
	idclient INT,
    idPayment INT,
    typePayment ENUM('Boleto','Cartão','Dois cartões'),
    limitAvailable FLOAT,
    PRIMARY KEY(idClient, idPayment),
    CONSTRAINT fk_payment_client FOREIGN KEY (idclient) REFERENCES clients (idClient),
    CONSTRAINT fk_payment_orders FOREIGN KEY (idPayment) REFERENCES orders (idOrder)
);

CREATE TABLE productSeller(
	idPseller INT,
    idPproduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idPproduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idPproduct) REFERENCES product(idProduct)
);

CREATE TABLE productOrder(
	idPOproduct INT,
    idPOorder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_productorder_product FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productorder_order FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)

);

CREATE TABLE storageLocation(
	idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage)
);

CREATE TABLE productSupplier(
	idPsSupplier INT,
    idPsProduct INT,
    quantity INT NOT NULL,
    PRIMARY KEY (idPsSupplier, idPsProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_product_supplier_prodcut FOREIGN KEY (idPsProduct) REFERENCES product(idProduct)
);