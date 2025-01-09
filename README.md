
# Projeto-Oficina
```markdown
# Projeto-Oficina

## Entidades e Relacionamentos

Com base na narrativa fornecida, podemos identificar várias entidades essenciais para o modelo de dados e seus relacionamentos. Aqui estão as entidades principais e seus atributos:

### Cliente

**Descrição:** Representa os clientes da oficina que trazem os veículos para manutenção.  
**Atributos:**
- `id_cliente` (chave primária)
- `nome` (nome do cliente)
- `endereco` (endereço do cliente)
- `telefone` (telefone do cliente)
- `email` (email do cliente)

### Veículo

**Descrição:** Representa os veículos que são trazidos à oficina para serviços.  
**Atributos:**
- `id_veiculo` (chave primária)
- `id_cliente` (chave estrangeira, referência ao cliente proprietário)
- `placa` (placa do veículo)
- `marca` (marca do veículo)
- `modelo` (modelo do veículo)
- `ano_fabricacao` (ano de fabricação do veículo)

### Mecânico

**Descrição:** Representa os mecânicos que irão executar os serviços nas ordens de serviço.  
**Atributos:**
- `id_mecanico` (chave primária)
- `nome` (nome do mecânico)
- `endereco` (endereço do mecânico)
- `especialidade` (especialidade do mecânico, ex: suspensão, motor, etc.)

### Ordem de Serviço (OS)

**Descrição:** Representa uma ordem de serviço gerada para um veículo, com os serviços que precisam ser executados.  
**Atributos:**
- `id_os` (chave primária)
- `numero_os` (número da ordem de serviço)
- `id_veiculo` (chave estrangeira, referência ao veículo)
- `data_emissao` (data de emissão da ordem de serviço)
- `data_conclusao` (data para conclusão dos serviços)
- `valor_total` (valor total da ordem de serviço)
- `status` (status da OS, como "Em Andamento", "Concluída", "Cancelada")

### Serviço

**Descrição:** Representa os serviços que podem ser realizados nas ordens de serviço. Cada serviço tem um valor, que pode ser de mão-de-obra ou peças.  
**Atributos:**
- `id_servico` (chave primária)
- `descricao` (descrição do serviço, ex: troca de óleo, revisão de motor)
- `valor_unitario` (valor unitário do serviço)

### OS_Serviço

**Descrição:** Relacionamento entre a ordem de serviço e os serviços a serem realizados.  
**Atributos:**
- `id_os` (chave estrangeira, referência à OS)
- `id_servico` (chave estrangeira, referência ao serviço)
- `quantidade` (quantidade de vezes que o serviço será executado, se necessário)
- `valor_total` (valor total do serviço na OS, calculado com base no valor unitário)

### Tabela de Referência de Mão-de-Obra

**Descrição:** Representa os valores de referência dos serviços de mão-de-obra. O sistema irá consultar esta tabela para calcular o valor de cada serviço a ser executado.  
**Atributos:**
- `id_referencia` (chave primária)
- `descricao_servico` (descrição do serviço)
- `valor_hora` (valor por hora de mão-de-obra)

### Equipe

**Descrição:** Representa a equipe de mecânicos designada para executar os serviços em cada ordem de serviço.  
**Atributos:**
- `id_equipe` (chave primária)
- `id_mecanico` (chave estrangeira, referência ao mecânico)
- `id_os` (chave estrangeira, referência à ordem de serviço)

## Relacionamentos

- **Cliente - Veículo:** Um cliente pode ter vários veículos, mas um veículo pertence a um único cliente (1:N).
- **Veículo - OS:** Cada veículo pode ter várias ordens de serviço, mas uma ordem de serviço está associada a um único veículo (1:N).
- **OS - Serviço:** Uma ordem de serviço pode ter vários serviços, e um serviço pode ser executado em várias ordens de serviço. Este é um relacionamento N:M, que será modelado pela tabela OS_Serviço.
- **Mecânico - OS:** Uma ordem de serviço pode ser executada por vários mecânicos, e cada mecânico pode executar serviços em várias ordens de serviço. Este é um relacionamento N:M, que será modelado pela tabela Equipe.
- **Serviço - Tabela de Referência de Mão-de-Obra:** Cada serviço tem um valor de mão-de-obra associado, que pode ser consultado na tabela de referência (1:1).

## Diagrama ER (Entidade-Relacionamento)

```csharp
[Cliente] 
    |---< id_cliente, nome, endereco, telefone, email
        |
[Veículo]
    |---< id_veiculo, id_cliente, placa, marca, modelo, ano_fabricacao
        |
[Ordem de Serviço (OS)]
    |---< id_os, numero_os, id_veiculo, data_emissao, data_conclusao, valor_total, status
        |
[OS_Serviço]
    |---< id_os, id_servico, quantidade, valor_total
        |
[Serviço] 
    |---< id_servico, descricao, valor_unitario
        |
[Tabela de Referência de Mão-de-Obra]
    |---< id_referencia, descricao_servico, valor_hora
        |
[Equipe]
    |---< id_equipe, id_mecanico, id_os
        |
[Mecânico]
    |---< id_mecanico, nome, endereco, especialidade
```

## Explicação do Código SQL

### Tabela Cliente:

Armazena os dados dos clientes da oficina, como nome, endereço, telefone e email.  
A chave primária é `id_cliente`.

### Tabela Veículo:

Contém os veículos dos clientes, incluindo o número da placa, marca, modelo e ano de fabricação.  
A tabela possui uma chave estrangeira `id_cliente`, que se refere à tabela Cliente.

### Tabela Mecânico:

Armazena os dados dos mecânicos, incluindo nome, endereço e especialidade.  
A chave primária é `id_mecanico`.

### Tabela Ordem de Serviço (OS):

Registra as ordens de serviço, incluindo o número da OS, veículo relacionado, data de emissão, data de conclusão e o valor total.  
A chave estrangeira `id_veiculo` se relaciona com a tabela Veiculo.

### Tabela Serviço:

Contém os serviços disponíveis na oficina, como troca de óleo, revisão de motor, etc.  
O campo `valor_unitario` indica o preço de cada serviço.

### Tabela OS_Serviço:

Relaciona as ordens de serviço com os serviços executados.  
A chave primária é composta por `id_os` (referência à OS) e `id_servico` (referência ao serviço), o que permite associar múltiplos serviços a uma única ordem de serviço.

### Tabela Tabela_Referencia_Mao_Obra:

Armazena os valores de referência para os serviços de mão-de-obra. Cada serviço tem uma descrição e um valor por hora de trabalho.  
Esses valores são usados para calcular o custo da mão-de-obra de cada serviço executado.

### Tabela Equipe:

Representa a equipe de mecânicos responsável por cada ordem de serviço. Cada equipe pode ser composta por vários mecânicos.  
Possui duas chaves estrangeiras: `id_mecanico` (referência ao mecânico) e `id_os` (referência à ordem de serviço).

### Índices:

Para otimizar o desempenho em consultas frequentes, foram criados índices nas colunas `nome` da tabela Cliente, `placa` da tabela Veiculo, `status` da tabela Ordem_Servico, `descricao` da tabela Servico e `nome` da tabela Mecanico.

## Exemplo de Inserção de Dados

Aqui estão alguns exemplos de inserção de dados no banco para testar a estrutura:

```sql
-- Inserir um cliente
INSERT INTO Cliente (nome, endereco, telefone, email) 
VALUES ('João Silva', 'Rua das Flores, 123', '987654321', 'joao@exemplo.com');

-- Inserir um veículo
INSERT INTO Veiculo (id_cliente, placa, marca, modelo, ano_fabricacao)
VALUES (1, 'ABC-1234', 'Fiat', 'Uno', 2015);

-- Inserir um mecânico
INSERT INTO Mecanico (nome, endereco, especialidade) 
VALUES ('Carlos Souza', 'Rua do Carro, 45', 'Suspensão');

-- Inserir um serviço
INSERT INTO Servico (descricao, valor_unitario) 
VALUES ('Troca de óleo', 150.00);

-- Inserir uma ordem de serviço
INSERT INTO Ordem_Servico (numero_os, id_veiculo, data_emissao, data_conclusao, valor_total, status) 
VALUES ('OS001', 1, '2025-01-01', '2025-01-05', 200.00, 'Em Andamento');

-- Relacionar uma ordem de serviço com um serviço
INSERT INTO OS_Servico (id_os, id_servico, quantidade, valor_total) 
VALUES (1, 1, 1, 150.00);

-- Inserir uma referência de mão-de-obra
INSERT INTO Tabela_Referencia_Mao_Obra (descricao_servico, valor_hora)
VALUES ('Troca de óleo', 50.00);

-- Relacionar mecânico à ordem de serviço
INSERT INTO Equipe (id_mecanico, id_os)
VALUES (1, 1);
```

### Cliente

**Descrição:** <span style="color:blue;">Representa os clientes da oficina que trazem os veículos para manutenção.</span>  
**Atributos:**
- <span style="color:green;">`id_cliente`</span> (chave primária)
- <span style="color:green;">`nome`</span> (nome do cliente)
- <span style="color:green;">`endereco`</span> (endereço do cliente)
- <span style="color:green;">`telefone`</span> (telefone do cliente)
- <span style="color:green;">`email`</span> (email do cliente)

### Veículo

**Descrição:** <span style="color:blue;">Representa os veículos que são trazidos à oficina para serviços.</span>  
**Atributos:**
- <span style="color:green;">`id_veiculo`</span> (chave primária)
- <span style="color:green;">`id_cliente`</span> (chave estrangeira, referência ao cliente proprietário)
- <span style="color:green;">`placa`</span> (placa do veículo)
- <span style="color:green;">`marca`</span> (marca do veículo)
- <span style="color:green;">`modelo`</span> (modelo do veículo)
- <span style="color:green;">`ano_fabricacao`</span> (ano de fabricação do veículo)

### Mecânico

**Descrição:** <span style="color:blue;">Representa os mecânicos que irão executar os serviços nas ordens de serviço.</span>  
**Atributos:**
- <span style="color:green;">`id_mecanico`</span> (chave primária)
- <span style="color:green;">`nome`</span> (nome do mecânico)
- <span style="color:green;">`endereco`</span> (endereço do mecânico)
- <span style="color:green;">`especialidade`</span> (especialidade do mecânico, ex: suspensão, motor, etc.)

### Ordem de Serviço (OS)

**Descrição:** <span style="color:blue;">Representa uma ordem de serviço gerada para um veículo, com os serviços que precisam ser executados.</span>  
**Atributos:**
- <span style="color:green;">`id_os`</span> (chave primária)
- <span style="color:green;">`numero_os`</span> (número da ordem de serviço)
- <span style="color:green;">`id_veiculo`</span> (chave estrangeira, referência ao veículo)
- <span style="color:green;">`data_emissao`</span> (data de emissão da ordem de serviço)
- <span style="color:green;">`data_conclusao`</span> (data para conclusão dos serviços)
- <span style="color:green;">`valor_total`</span> (valor total da ordem de serviço)
- <span style="color:green;">`status`</span> (status da OS, como "Em Andamento", "Concluída", "Cancelada")

### Serviço

**Descrição:** <span style="color:blue;">Representa os serviços que podem ser realizados nas ordens de serviço. Cada serviço tem um valor, que pode ser de mão-de-obra ou peças.</span>  
**Atributos:**
- <span style="color:green;">`id_servico`</span> (chave primária)
- <span style="color:green;">`descricao`</span> (descrição do serviço, ex: troca de óleo, revisão de motor)
- <span style="color:green;">`valor_unitario`</span> (valor unitário do serviço)

### OS_Serviço

**Descrição:** <span style="color:blue;">Relacionamento entre a ordem de serviço e os serviços a serem realizados.</span>  
**Atributos:**
- <span style="color:green;">`id_os`</span> (chave estrangeira, referência à OS)
- <span style="color:green;">`id_servico`</span> (chave estrangeira, referência ao serviço)
- <span style="color:green;">`quantidade`</span> (quantidade de vezes que o serviço será executado, se necessário)
- <span style="color:green;">`valor_total`</span> (valor total do serviço na OS, calculado com base no valor unitário)

### Tabela de Referência de Mão-de-Obra

**Descrição:** <span style="color:blue;">Representa os valores de referência dos serviços de mão-de-obra. O sistema irá consultar esta tabela para calcular o valor de cada serviço a ser executado.</span>  
**Atributos:**
- <span style="color:green;">`id_referencia`</span> (chave primária)
- <span style="color:green;">`descricao_servico`</span> (descrição do serviço)
- <span style="color:green;">`valor_hora`</span> (valor por hora de mão-de-obra)

### Equipe

**Descrição:** <span style="color:blue;">Representa a equipe de mecânicos designada para executar os serviços em cada ordem de serviço.</span>  
**Atributos:**
- <span style="color:green;">`id_equipe`</span> (chave primária)
- <span style="color:green;">`id_mecanico`</span> (chave estrangeira, referência ao mecânico)
- <span style="color:green;">`id_os`</span> (chave estrangeira, referência à ordem de serviço)
```