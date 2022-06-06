-- Gerado por Oracle SQL Developer Data Modeler 21.4.2.059.0838
--   em:        2022-06-05 22:31:19 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_avaliacao (
    cd_avaliacao NUMBER(5) NOT NULL,
    t_cl_cd_cl   NUMBER(5) NOT NULL,
    ds_avaliacao VARCHAR2(255) NOT NULL
);

ALTER TABLE t_avaliacao ADD CONSTRAINT t_avaliacao_pk PRIMARY KEY ( cd_avaliacao,
                                                                    t_cl_cd_cl );

CREATE TABLE t_bairro (
    cd_bairro          NUMBER(5) NOT NULL,
    t_cidade_cd_cidade NUMBER(5) NOT NULL,
    nm_bairro          VARCHAR2(120) NOT NULL
);

ALTER TABLE t_bairro ADD CONSTRAINT t_bairro_pk PRIMARY KEY ( cd_bairro );

CREATE TABLE t_cidade (
    cd_cidade          NUMBER(5) NOT NULL,
    t_estado_cd_estado NUMBER(5) NOT NULL,
    nm_cidade          VARCHAR2(120) NOT NULL
);

ALTER TABLE t_cidade ADD CONSTRAINT t_cidade_pk PRIMARY KEY ( cd_cidade );

CREATE TABLE t_cl (
    cd_cliente             NUMBER(5) NOT NULL,
    nm_cliente             VARCHAR2(255) NOT NULL,
    nr_cpf                 CHAR(11) NOT NULL,
    nr_telefone            CHAR(11) NOT NULL,
    ds_email               VARCHAR2(255) NOT NULL,
    t_endereco_cd_endereco NUMBER(5) NOT NULL
);

ALTER TABLE t_cl ADD CONSTRAINT t_cliente_pk PRIMARY KEY ( cd_cliente );

CREATE TABLE t_empresa (
    cd_empresa             NUMBER(5) NOT NULL,
    t_endereco_cd_endereco NUMBER(5) NOT NULL,
    nm_empresa             VARCHAR2(50) NOT NULL,
    nr_telefone            CHAR(11) NOT NULL
);

ALTER TABLE t_empresa ADD CONSTRAINT t_empresa_pk PRIMARY KEY ( cd_empresa );

CREATE TABLE t_endereco (
    cd_endereco                NUMBER(5) NOT NULL,
    t_bairro_cd_bairro         NUMBER(5) NOT NULL,
    t_logradouro_cd_logradouro NUMBER(5) NOT NULL,
    nr_cep                     VARCHAR2(10) NOT NULL
);

ALTER TABLE t_endereco ADD CONSTRAINT t_endereco_pk PRIMARY KEY ( cd_endereco );

CREATE TABLE t_entrega (
    cd_entrega                 NUMBER(5) NOT NULL,
    t_emp_cd_empresa           NUMBER(5) NOT NULL,
    t_ent_cd_entregador        NUMBER(5) NOT NULL,
    t_ent_t_av_cd_avalia       NUMBER(5) NOT NULL,
    t_ent_t_av_t_cl_cd_cliente NUMBER(5) NOT NULL,
    t_regiao_cd_regiao         NUMBER(5) NOT NULL,
    ds_pedido                  VARCHAR2(255) NOT NULL,
    dt_hr_pedido               DATE NOT NULL,
    vl_entrega                 NUMBER NOT NULL
);

ALTER TABLE t_entrega
    ADD CONSTRAINT t_entrega_pk PRIMARY KEY ( cd_entrega,
                                              t_emp_cd_empresa,
                                              t_ent_cd_entregador,
                                              t_ent_t_av_cd_avalia,
                                              t_ent_t_av_t_cl_cd_cliente,
                                              t_regiao_cd_regiao );

CREATE TABLE t_entregador (
    cd_entregador        NUMBER(5) NOT NULL,
    t_av_cd_aval         NUMBER(5) NOT NULL,
    t_av_t_cl_cd_cliente NUMBER(5) NOT NULL,
    nm_entregador        VARCHAR2(255) NOT NULL,
    nr_cpf               CHAR(11) NOT NULL,
    dt_nascimento        DATE NOT NULL,
    vl_recebe            NUMBER NOT NULL,
    ds_veiculo           VARCHAR2(20) NOT NULL
);

CREATE UNIQUE INDEX t_entregadorv1__idx ON
    t_entregador (
        t_av_cd_aval
    ASC,
        t_av_t_cl_cd_cliente
    ASC );

ALTER TABLE t_entregador
    ADD CONSTRAINT t_entregador_pk PRIMARY KEY ( t_av_cd_aval,
                                                 t_av_t_cl_cd_cliente,
                                                 cd_entregador );

CREATE TABLE t_estado (
    cd_estado NUMBER(5) NOT NULL,
    nm_estado VARCHAR2(50) NOT NULL,
    sg_estado VARCHAR2(3) NOT NULL
);

ALTER TABLE t_estado ADD CONSTRAINT t_estado_pk PRIMARY KEY ( cd_estado );

CREATE TABLE t_historico (
    cd_historico               NUMBER(5) NOT NULL,
    t_ent_cd_entregador        NUMBER(5) NOT NULL,
    t_ent_t_av_cd_avalia       NUMBER(5) NOT NULL,
    t_ent_t_av_t_cl_cd_cliente NUMBER(5) NOT NULL,
    ds_dias_trab               DATE NOT NULL
);

ALTER TABLE t_historico
    ADD CONSTRAINT t_historico_pk PRIMARY KEY ( t_ent_cd_entregador,
                                                t_ent_t_av_cd_avalia,
                                                t_ent_t_av_t_cl_cd_cliente,
                                                cd_historico );

CREATE TABLE t_logradouro (
    cd_logradouro NUMBER(5) NOT NULL,
    ds_logradouro VARCHAR2(20) NOT NULL
);

ALTER TABLE t_logradouro ADD CONSTRAINT t_logradouro_pk PRIMARY KEY ( cd_logradouro );

CREATE TABLE t_pedido (
    cd_pedido         unknown 
--  ERROR: Datatype UNKNOWN is not allowed 
     NOT NULL,
    t_emp_cd_empresa  NUMBER(5) NOT NULL,
    t_cl_cd_cl        NUMBER(5) NOT NULL,
    t_ras_cd_rastreio NUMBER(5) NOT NULL,
    ds_destino        VARCHAR2(255) NOT NULL,
    ds_pedido         VARCHAR2(255) NOT NULL,
    ds_pagamento      VARCHAR2(20) NOT NULL,
    dt_hr_pedido      DATE NOT NULL
);

CREATE UNIQUE INDEX t_pedido__idx ON
    t_pedido (
        t_ras_cd_rastreio
    ASC );

ALTER TABLE t_pedido
    ADD CONSTRAINT t_pedido_pk PRIMARY KEY ( cd_pedido,
                                             t_emp_cd_empresa,
                                             t_cl_cd_cl );

CREATE TABLE t_ranking (
    cd_ranking                 NUMBER(5) NOT NULL,
    t_ent_cd_entregador        NUMBER(5) NOT NULL,
    t_ent_t_av_cd_avalia       NUMBER(5) NOT NULL,
    t_ent_t_av_t_cl_cd_cliente NUMBER(5) NOT NULL,
    nm_entregador              VARCHAR2(255) NOT NULL,
    ds_posicao                 INTEGER NOT NULL
);

ALTER TABLE t_ranking
    ADD CONSTRAINT t_ranking_pk PRIMARY KEY ( t_ent_cd_entregador,
                                              t_ent_t_av_cd_avalia,
                                              t_ent_t_av_t_cl_cd_cliente,
                                              cd_ranking );

CREATE TABLE t_rastreio (
    cd_rastreio        NUMBER(5) NOT NULL,
    t_pedido_cd_pedido NUMBER(5) NOT NULL,
    ds_status          CHAR(1) NOT NULL,
    ds_localizacao     VARCHAR2(255) NOT NULL
);

CREATE UNIQUE INDEX t_rastreamento__idx ON
    t_rastreio (
        t_pedido_cd_pedido
    ASC );

ALTER TABLE t_rastreio ADD CONSTRAINT t_rastreamento_pk PRIMARY KEY ( cd_rastreio );

CREATE TABLE t_regiao (
    cd_regiao  NUMBER(5) NOT NULL,
    nm_regiao  VARCHAR2(50) NOT NULL,
    qt_chamado INTEGER NOT NULL
);

ALTER TABLE t_regiao ADD CONSTRAINT t_regiao_pk PRIMARY KEY ( cd_regiao );

ALTER TABLE t_avaliacao
    ADD CONSTRAINT t_aval_t_cl_fk FOREIGN KEY ( t_cl_cd_cl )
        REFERENCES t_cl ( cd_cliente );

ALTER TABLE t_bairro
    ADD CONSTRAINT t_bairro_t_cidade_fk FOREIGN KEY ( t_cidade_cd_cidade )
        REFERENCES t_cidade ( cd_cidade );

ALTER TABLE t_cidade
    ADD CONSTRAINT t_cidade_t_estado_fk FOREIGN KEY ( t_estado_cd_estado )
        REFERENCES t_estado ( cd_estado );

ALTER TABLE t_cl
    ADD CONSTRAINT t_cl_t_endereco_fk FOREIGN KEY ( t_endereco_cd_endereco )
        REFERENCES t_endereco ( cd_endereco );

ALTER TABLE t_empresa
    ADD CONSTRAINT t_empresa_t_endereco_fk FOREIGN KEY ( t_endereco_cd_endereco )
        REFERENCES t_endereco ( cd_endereco );

ALTER TABLE t_endereco
    ADD CONSTRAINT t_endereco_t_bairro_fk FOREIGN KEY ( t_bairro_cd_bairro )
        REFERENCES t_bairro ( cd_bairro );

ALTER TABLE t_endereco
    ADD CONSTRAINT t_endereco_t_logradouro_fk FOREIGN KEY ( t_logradouro_cd_logradouro )
        REFERENCES t_logradouro ( cd_logradouro );

ALTER TABLE t_entrega
    ADD CONSTRAINT t_entrega_t_empresa_fk FOREIGN KEY ( t_emp_cd_empresa )
        REFERENCES t_empresa ( cd_empresa );

ALTER TABLE t_entrega
    ADD CONSTRAINT t_entrega_t_entregador_fk FOREIGN KEY ( t_ent_t_av_cd_avalia,
                                                           t_ent_t_av_t_cl_cd_cliente,
                                                           t_ent_cd_entregador )
        REFERENCES t_entregador ( t_av_cd_aval,
                                  t_av_t_cl_cd_cliente,
                                  cd_entregador );

ALTER TABLE t_entrega
    ADD CONSTRAINT t_entrega_t_regiao_fk FOREIGN KEY ( t_regiao_cd_regiao )
        REFERENCES t_regiao ( cd_regiao );

ALTER TABLE t_entregador
    ADD CONSTRAINT t_entregador_t_aval_fk FOREIGN KEY ( t_av_cd_aval,
                                                        t_av_t_cl_cd_cliente )
        REFERENCES t_avaliacao ( cd_avaliacao,
                                 t_cl_cd_cl );

ALTER TABLE t_historico
    ADD CONSTRAINT t_historico_t_entregador_fk FOREIGN KEY ( t_ent_t_av_cd_avalia,
                                                             t_ent_t_av_t_cl_cd_cliente,
                                                             t_ent_cd_entregador )
        REFERENCES t_entregador ( t_av_cd_aval,
                                  t_av_t_cl_cd_cliente,
                                  cd_entregador );

ALTER TABLE t_pedido
    ADD CONSTRAINT t_pedido_t_cl_fk FOREIGN KEY ( t_cl_cd_cl )
        REFERENCES t_cl ( cd_cliente );

ALTER TABLE t_pedido
    ADD CONSTRAINT t_pedido_t_empresa_fk FOREIGN KEY ( t_emp_cd_empresa )
        REFERENCES t_empresa ( cd_empresa );

ALTER TABLE t_pedido
    ADD CONSTRAINT t_pedido_t_rastreio_fk FOREIGN KEY ( t_ras_cd_rastreio )
        REFERENCES t_rastreio ( cd_rastreio );

ALTER TABLE t_ranking
    ADD CONSTRAINT t_ranking_t_entregador_fk FOREIGN KEY ( t_ent_t_av_cd_avalia,
                                                           t_ent_t_av_t_cl_cd_cliente,
                                                           t_ent_cd_entregador )
        REFERENCES t_entregador ( t_av_cd_aval,
                                  t_av_t_cl_cd_cliente,
                                  cd_entregador );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             3
-- ALTER TABLE                             31
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   1
-- WARNINGS                                 0
