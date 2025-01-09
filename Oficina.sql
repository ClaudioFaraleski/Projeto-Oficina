-- Criação da tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único do cliente
    nome VARCHAR(255) NOT NULL,                 -- Nome do cliente
    endereco VARCHAR(255),                      -- Endereço do cliente
    telefone VARCHAR(15),                       -- Telefone do cliente
    email VARCHAR(100)                          -- Email do cliente
);

-- Criação da tabela Veículo
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,    -- Identificador único do veículo
    id_cliente INT,                               -- ID do cliente (chave estrangeira)
    placa VARCHAR(10) NOT NULL,                   -- Placa do veículo
    marca VARCHAR(50),                            -- Marca do veículo
    modelo VARCHAR(50),                           -- Modelo do veículo
    ano_fabricacao YEAR,                          -- Ano de fabricação do veículo
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE  -- Relacionamento com Cliente
);

-- Criação da tabela Mecânico
CREATE TABLE Mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,   -- Identificador único do mecânico
    nome VARCHAR(255) NOT NULL,                    -- Nome do mecânico
    endereco VARCHAR(255),                         -- Endereço do mecânico
    especialidade VARCHAR(100)                     -- Especialidade do mecânico (ex: suspensão, motor, etc.)
);

-- Criação da tabela Ordem de Serviço (OS)
CREATE TABLE Ordem_Servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,          -- Identificador único da OS
    numero_os VARCHAR(20) NOT NULL,                 -- Número da ordem de serviço
    id_veiculo INT,                                -- ID do veículo (chave estrangeira)
    data_emissao DATE,                             -- Data de emissão da OS
    data_conclusao DATE,                           -- Data prevista de conclusão
    valor_total DECIMAL(10, 2) NOT NULL,           -- Valor total da OS
    status ENUM('Em Andamento', 'Concluída', 'Cancelada') NOT NULL,  -- Status da OS
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo) ON DELETE CASCADE  -- Relacionamento com Veículo
);

-- Criação da tabela Serviço
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,    -- Identificador único do serviço
    descricao VARCHAR(255) NOT NULL,               -- Descrição do serviço (ex: troca de óleo, revisão de motor)
    valor_unitario DECIMAL(10, 2) NOT NULL         -- Valor unitário do serviço
);

-- Criação da tabela OS_Serviço (Relacionamento entre OS e Serviços)
CREATE TABLE OS_Servico (
    id_os INT,                                    -- ID da ordem de serviço (chave estrangeira)
    id_servico INT,                               -- ID do serviço (chave estrangeira)
    quantidade INT NOT NULL,                      -- Quantidade do serviço executado (ex: 2 trocas de óleo)
    valor_total DECIMAL(10, 2) NOT NULL,          -- Valor total do serviço na OS (quantidade * valor_unitario)
    PRIMARY KEY (id_os, id_servico),              -- Chave composta para identificar a relação
    FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os) ON DELETE CASCADE,   -- Relacionamento com Ordem de Serviço
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico) ON DELETE CASCADE  -- Relacionamento com Serviço
);

-- Criação da tabela Tabela_Referencia_Mao_Obra
CREATE TABLE Tabela_Referencia_Mao_Obra (
    id_referencia INT AUTO_INCREMENT PRIMARY KEY,    -- Identificador único da referência
    descricao_servico VARCHAR(255) NOT NULL,          -- Descrição do serviço de mão-de-obra
    valor_hora DECIMAL(10, 2) NOT NULL                -- Valor da hora de mão-de-obra
);

-- Criação da tabela Equipe (Relacionamento entre Mecânicos e Ordens de Serviço)
CREATE TABLE Equipe (
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,       -- Identificador único da equipe
    id_mecanico INT,                                -- ID do mecânico (chave estrangeira)
    id_os INT,                                      -- ID da ordem de serviço (chave estrangeira)
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico) ON DELETE CASCADE, -- Relacionamento com Mecânico
    FOREIGN KEY (id_os) REFERENCES Ordem_Servico(id_os) ON DELETE CASCADE  -- Relacionamento com Ordem de Serviço
);

-- Índices para otimizar consultas
CREATE INDEX idx_cliente_nome ON Cliente(nome);
CREATE INDEX idx_veiculo_placa ON Veiculo(placa);
CREATE INDEX idx_os_status ON Ordem_Servico(status);
CREATE INDEX idx_servico_descricao ON Servico(descricao);
CREATE INDEX idx_mecanico_nome ON Mecanico(nome);
