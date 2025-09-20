CREATE TYPE tipo AS ENUM ('Física', 'Online');

CREATE TABLE "Produto" (
    "prodId" INT NOT NULL,
    "nome" VARCHAR(255) NOT NULL,
    "categoria" VARCHAR(255) NOT NULL,
    "cor" VARCHAR(255),
    "descricao" VARCHAR(255),
    "tamanho" VARCHAR(50),
    "preco" NUMERIC(10,2) NOT NULL,
    "custoAquisicao" NUMERIC(10,2) NOT NULL,
    "imagem" VARCHAR(255),
    CONSTRAINT "Produto_PK" PRIMARY KEY ("prodId")
);

CREATE TABLE "Avaliacao" ( 
	"prodId" 		INT		NOT NULL,
	"avaliacao"		NUMERIC(10,2)	NOT NULL,
	"comentario" 	VARCHAR(255),
	CONSTRAINT "Avaliacao_Produto_FK" FOREIGN KEY ("prodId") REFERENCES "Produto" ("prodId")
);

CREATE TABLE "Loja" (
	"lojaId" 		INT 			NOT NULL,
	"nome"			VARCHAR(255)	NOT NULL,
	"regiao" 		VARCHAR(255)	NOT NULL,
	"cidade"		VARCHAR(255)	NOT NULL,
	"tipo"			tipo NOT NULL,
	CONSTRAINT "Loja_PK" PRIMARY KEY ("lojaId")
);

CREATE TABLE "Campanha" (
	"campanhaId"	INT		NOT NULL,
	"lojaId"		INT		NOT NULL,
	"nome"			VARCHAR(255)	NOT NULL,
	"canal"			VARCHAR(255)	NOT NULL,
	"investimento"	NUMERIC(10,2)	NOT NULL,
	"vendasGeradas"	INT		NOT NULL,
	"dataInicio" 	TIMESTAMP	NOT NULL,
	"dataFim"		TIMESTAMP	NOT NULL,
	CONSTRAINT "Campanha_PK" PRIMARY KEY ("campanhaId"),
	CONSTRAINT "Campanha_Loja_FK" FOREIGN KEY ("lojaId") REFERENCES "Loja" ("lojaId")
);

CREATE TABLE "Cliente" (
	"clienteId"		INT 	NOT NULL,
	"nome"			VARCHAR(255) NOT NULL,	
	"idade"			INT 	NOT NULL,
	"genero"		CHAR(1)	NOT NULL,
	"cidade"		VARCHAR(255)	NOT NULL,
	"canalCompra"	tipo NOT NULL,
	"totalCompra"	NUMERIC(10,2)	NOT NULL,
	"imagem"		VARCHAR(255),
	CONSTRAINT "Cliente_PK" PRIMARY KEY ("clienteId")
);

CREATE TABLE "Colaborador" (
	"colaboradorId"		INT		NOT NULL,
	"lojaId"			INT		NOT NULL,
	"nome"				VARCHAR(255)	NOT NULL,
	"funcao" 			VARCHAR(255)	NOT NULL,
	"horasSemanais"		INT		NOT NULL,
	"avaliacaoDesempenho"	NUMERIC(10,2),
	"vendasRealizadas"	INT,
	"naturalidade"		VARCHAR(255)	NOT NULL,
	"imagem"			VARCHAR(255)	NOT NULL,
	CONSTRAINT "Colaborador_PK" PRIMARY KEY ("colaboradorId"),
	CONSTRAINT "Colaborador_Loja_FK" FOREIGN KEY ("lojaId") REFERENCES "Loja" ("lojaId")
);

CREATE TABLE "CustoOperacional" (
	"custoId"			INT		NOT NULL,
	"lojaId"			INT		NOT NULL,
	"tipoCusto"			VARCHAR(255)	NOT NULL,
	"valorMensal"		NUMERIC(10,2)	NOT NULL,
	"data"				TIMESTAMP	NOT NULL,
	CONSTRAINT "CustoOperacional_PK" PRIMARY KEY ("custoId"),
	CONSTRAINT "CustoOperacional_Loja_FK" FOREIGN KEY ("lojaId") REFERENCES "Loja" ("lojaId")
);

CREATE TABLE "Fornecedor" (
    "fornecedorId" 		INT 	NOT NULL,
    "nome" 				VARCHAR(255) 	NOT NULL,
    "historicoFornecimento" 	INT,
    "custoTransporte" 	NUMERIC(10,2),
    "prazoMedioEntregas" 		INT,
    "cidade" 			VARCHAR(255) NOT NULL,
    "logo" 				VARCHAR(255),
    CONSTRAINT "Fornecedor_PK" PRIMARY KEY ("fornecedorId")
);

CREATE TABLE "Satisfacao" (
    "clienteId" INT NOT NULL,
    "inqueritoId" INT NOT NULL,
    "pontuacao" INT NOT NULL,
    "comentario" TEXT,
    "dataInquerito" TIMESTAMP NOT NULL,
    CONSTRAINT "Satisfacao_PK" PRIMARY KEY ("inqueritoId"),
	CONSTRAINT "Satisfacao_Cliente_FK" FOREIGN KEY ("clienteId") REFERENCES "Cliente" ("clienteId")
);

CREATE TABLE "Stock" (
    "prodId" INT NOT NULL,
    "quantidadeStock" INT NOT NULL,
    "nivelMin" INT NOT NULL,
    "nivelMax" INT NOT NULL,
    "tempoMedioEntrega" INT NOT NULL,
	CONSTRAINT "Stock_Produto_FK" FOREIGN KEY ("prodId") REFERENCES "Produto" ("prodId")
);

CREATE TABLE "Venda" (
    "vendaId" INT NOT NULL,
    "lojaId" INT NOT NULL,
    "prodId" INT NOT NULL,
    "clienteId" INT NOT NULL,
    "colaboradorId" INT NOT NULL,
    "quantidade" INT NOT NULL,
    "precoUnitario" NUMERIC(10,2) NOT NULL,
    "dataVenda" TIMESTAMP NOT NULL,
    "canalVenda" tipo NOT NULL,
    CONSTRAINT "Venda_PK" PRIMARY KEY ("vendaId"),
    CONSTRAINT "Venda_Lojas_FK" FOREIGN KEY ("lojaId") REFERENCES "Loja" ("lojaId"),
    CONSTRAINT "Venda_Produto_FK" FOREIGN KEY ("prodId") REFERENCES "Produto" ("prodId"),
    CONSTRAINT "Venda_Clientes_FK" FOREIGN KEY ("clienteId") REFERENCES "Cliente" ("clienteId"),
    CONSTRAINT "Venda_Colaboradores_FK" FOREIGN KEY ("colaboradorId") REFERENCES "Colaborador" ("colaboradorId")
);

CREATE TABLE "PedidoCompra" (
    "pedidoId" INT NOT NULL,
    "fornecedorId" INT NOT NULL,
    "prodId" INT NOT NULL,
    "quantidade" INT NOT NULL,
    "dataPedido" TIMESTAMP NOT NULL,
    CONSTRAINT "PedidoCompra_PK" PRIMARY KEY ("pedidoId"),
    CONSTRAINT "PedidoCompra_Fornecedor_FK" FOREIGN KEY ("fornecedorId") REFERENCES "Fornecedor" ("fornecedorId"),
    CONSTRAINT "PedidoCompra_Produto_FK" FOREIGN KEY ("prodId") REFERENCES "Produto" ("prodId")
);

CREATE TABLE "HistoricoVendas" (
    "vendaId" INT NOT NULL,
    "lojaId" INT NOT NULL,
    "prodId" INT NOT NULL,
    "clienteId" INT NOT NULL,
    "colaboradorId" INT NOT NULL,
    "quantidade" INT NOT NULL,
    "precoUnitario" NUMERIC(10,2) NOT NULL,
    "dataVenda" TIMESTAMP NOT NULL,
    "canalVenda" tipo NOT NULL,
    CONSTRAINT "HistoricoVenda_PK" PRIMARY KEY ("vendaId"),
    CONSTRAINT "HistoricoVenda_Loja_FK" FOREIGN KEY ("lojaId") REFERENCES "Loja" ("lojaId"),
    CONSTRAINT "HistoricoVenda_Produto_FK" FOREIGN KEY ("prodId") REFERENCES "Produto" ("prodId"),
    CONSTRAINT "HistoricoVenda_Cliente_FK" FOREIGN KEY ("clienteId") REFERENCES "Cliente" ("clienteId"),
    CONSTRAINT "HistoricoVenda_Colaborador_FK" FOREIGN KEY ("colaboradorId") REFERENCES "Colaborador" ("colaboradorId")
);

CREATE TABLE "Devolucao" (
    "devolucaoId" INT NOT NULL,
    "vendaId" INT NOT NULL,
    "prodId" INT NOT NULL,
    "clienteId" INT NOT NULL,
    "quantidade" INT NOT NULL,
    "motivoDevolucao" VARCHAR(255) NOT NULL,
    "dataDevolucao" TIMESTAMP NOT NULL,
    CONSTRAINT "Devolucao_PK" PRIMARY KEY ("devolucaoId"),
    CONSTRAINT "Devolucao_Venda_FK" FOREIGN KEY ("vendaId") REFERENCES "Venda" ("vendaId"),
    CONSTRAINT "Devolucao_Produto_FK" FOREIGN KEY ("prodId") REFERENCES "Produto" ("prodId"),
    CONSTRAINT "Devolucao_Cliente_FK" FOREIGN KEY ("clienteId") REFERENCES "Cliente" ("clienteId")
);