drop table tem_outra;
drop table evento_reposicao;
drop table planograma;
drop table tem_categoria;
drop table instalada_em;
drop table ponto_de_retalho;
drop table prateleira;
drop table responsavel_por;
drop table retalhista;
drop table categoria_simples;
drop table super_categoria;
drop table produto;
drop table categoria;
drop table ivm;

drop type loc;

create type loc as enum ('esquerda', 'centro', 'direita');

create table categoria (
    nome varchar(100) not null,
    primary key (nome)
);

create table categoria_simples (
    nome varchar(100) not null,
    primary key (nome),
    foreign key (nome) references categoria(nome) on delete cascade
);

create table super_categoria (
    nome varchar(100) not null,
    primary key (nome),
    foreign key (nome) references categoria on delete cascade
);

create table tem_outra (
    super_categoria varchar(100) not null,
    categoria varchar(100) not null,
    primary key (categoria),
    foreign key (super_categoria) references super_categoria(nome) on delete cascade,
    foreign key (categoria) references categoria(nome) on delete cascade,
    check (super_categoria != categoria)
);

create table produto (
    ean char(13) not null,
    cat varchar(100) not null,
    descr varchar(100),
    primary key (ean),
    foreign key (cat) references categoria(nome) on delete cascade
);

create table tem_categoria (
    ean char(13) not null,
    nome varchar(100) not null,
    foreign key(ean) references produto(ean) on delete cascade,
    foreign key(nome) references categoria(nome) on delete cascade
);

create table ivm (
    num_serie varchar(100) not null,
    fabricante varchar(100) not null,
    primary key (num_serie, fabricante)
);

create table ponto_de_retalho (
    nome varchar(100) not null,
    distrito varchar(100) not null,
    concelho varchar(100) not null,
    primary key(nome)
);

create table instalada_em (
    num_serie varchar(100) not null,
    fabricante char(100) not null,
    sitio char(100) not null,
    primary key(num_serie, fabricante),
    foreign key(num_serie, fabricante) references ivm(num_serie, fabricante) on delete cascade,
    foreign key(sitio) references ponto_de_retalho(nome) on delete cascade

);

create table prateleira (
    nro int not null,
    num_serie varchar(100) not null,
    fabricante char(100) not null,
    altura float(24) not null,
    nome varchar(100) not null,
    primary key (nro, num_serie, fabricante),
    foreign key (num_serie, fabricante) references ivm(num_serie, fabricante) on delete cascade,
    foreign key(nome) references categoria(nome) on delete cascade
);

create table planograma (
    ean char(13) not null,
    nro int not null,
    num_serie varchar(100) not null,
    fabricante char(100) not null,
    face int,
    unidades int,
    loc loc,
    primary key (ean, nro, num_serie, fabricante),
    foreign key (ean) references produto(ean) on delete cascade,
    foreign key (nro, num_serie, fabricante) references prateleira(nro, num_serie, fabricante) on delete cascade
);

create table retalhista (
    tin varchar(100) not null,
    nome varchar(100) not null unique,
    primary key(tin)
);

create table responsavel_por (
    nome_cat varchar(100) not null,
    tin varchar(100) not null,
    num_serie varchar(100) not null,
    fabricante char(100) not null,
    primary key (num_serie, fabricante),
    foreign key (tin) references retalhista(tin) on delete cascade,
    foreign key (num_serie, fabricante) references ivm(num_serie, fabricante) on delete cascade,
    foreign key (nome_cat) references categoria(nome) on delete cascade
);

create table evento_reposicao (
    ean char(13) not null, 
    nro int not null,
    num_serie varchar(100) not null,
    fabricante char(100) not null,
    instante timestamp,
    unidades int,
    tin varchar(100) not null,
    primary key (ean, nro, num_serie, fabricante, instante),
    foreign key (ean, nro, num_serie, fabricante) references planograma(ean, nro, num_serie, fabricante) on delete cascade,
    foreign key (tin) references retalhista(tin) on delete cascade
);

insert into categoria values ('Liquidos');
insert into categoria values ('Bebidas');
insert into categoria values ('Refrigerantes');
insert into categoria values ('Sumos');
insert into categoria values ('Aguas');
insert into categoria values ('Chocolates');
insert into categoria values ('Batatas');

insert into categoria_simples values ('Refrigerantes');
insert into categoria_simples values ('Sumos');
insert into categoria_simples values ('Aguas');
insert into categoria_simples values ('Chocolates');
insert into categoria_simples values ('Batatas');

insert into super_categoria values ('Liquidos');
insert into super_categoria values ('Bebidas');

insert into tem_outra values ('Liquidos', 'Bebidas');
insert into tem_outra values ('Bebidas', 'Refrigerantes');
insert into tem_outra values ('Bebidas', 'Aguas');
insert into tem_outra values ('Bebidas', 'Sumos');

insert into produto values ('8475839485746', 'Refrigerantes', 'Coca-Cola Zero');
insert into produto values ('2938462536475', 'Refrigerantes', 'Pepsi Max Lima');
insert into produto values ('9263414278345', 'Refrigerantes', 'Fanta Uva');
insert into produto values ('6572837465734', 'Refrigerantes', 'Sumol Limao');
insert into produto values ('7354729384673', 'Sumos', 'Compal Maca e Cenoura');
insert into produto values ('4374957364927', 'Sumos', 'Capri-Sun Frutos Vermelhos');
insert into produto values ('8017372178812', 'Sumos', 'Minute Maid Maca Verde');
insert into produto values ('1829372091828', 'Sumos', 'Sunny Delight Morango');
insert into produto values ('7593743874839', 'Aguas', 'Agua Luso');
insert into produto values ('3456527892981', 'Aguas', 'Agua Monchique');
insert into produto values ('6472746574636', 'Aguas', 'Agua das Pedras');
insert into produto values ('6452628382911', 'Aguas', 'Agua Castelo');
insert into produto values ('7465747364567', 'Chocolates', 'Kit-Kat');
insert into produto values ('8546572647374', 'Chocolates', 'Twix');
insert into produto values ('6385763882778', 'Chocolates', 'Toffee Crisp');
insert into produto values ('8374657687987', 'Chocolates', 'Bounty');
insert into produto values ('3524374858675', 'Batatas', 'Lays Forno Original');
insert into produto values ('6253647586345', 'Batatas', 'Ruffles Presunto');
insert into produto values ('9127277367632', 'Batatas', 'Pringles Paprika');
insert into produto values ('5266178267281', 'Batatas', 'Cheetos Flamin Hot');

insert into tem_categoria values ('8475839485746', 'Refrigerantes');
insert into tem_categoria values ('2938462536475', 'Refrigerantes');
insert into tem_categoria values ('9263414278345', 'Refrigerantes');
insert into tem_categoria values ('6572837465734', 'Refrigerantes');
insert into tem_categoria values ('7354729384673', 'Sumos');
insert into tem_categoria values ('4374957364927', 'Sumos');
insert into tem_categoria values ('8017372178812', 'Sumos');
insert into tem_categoria values ('1829372091828', 'Sumos');
insert into tem_categoria values ('7593743874839', 'Aguas');
insert into tem_categoria values ('3456527892981', 'Aguas');
insert into tem_categoria values ('6472746574636', 'Aguas');
insert into tem_categoria values ('6452628382911', 'Aguas');
insert into tem_categoria values ('8546572647374', 'Chocolates');
insert into tem_categoria values ('7465747364567', 'Chocolates');
insert into tem_categoria values ('6385763882778', 'Chocolates');
insert into tem_categoria values ('8374657687987', 'Chocolates');
insert into tem_categoria values ('3524374858675', 'Batatas');
insert into tem_categoria values ('6253647586345', 'Batatas');
insert into tem_categoria values ('9127277367632', 'Batatas');
insert into tem_categoria values ('5266178267281', 'Batatas');

insert into ivm values('y823y7ejdl528', 'Iz*One Inc.');
insert into ivm values('s213sacs29c8a', 'Rainbow Bridge World Lda.');

insert into ponto_de_retalho values ('Intermarche', 'Aveiro', 'Estarreja');
insert into ponto_de_retalho values ('Pingo Doce', 'Beja', 'Mertola');

insert into instalada_em values ('y823y7ejdl528', 'Iz*One Inc.', 'Intermarche');
insert into instalada_em values ('s213sacs29c8a', 'Rainbow Bridge World Lda.', 'Pingo Doce');

insert into prateleira values (1, 'y823y7ejdl528', 'Iz*One Inc.', 160.0, 'Refrigerantes');
insert into prateleira values (2, 'y823y7ejdl528', 'Iz*One Inc.', 120.0, 'Sumos');
insert into prateleira values (3, 'y823y7ejdl528', 'Iz*One Inc.', 80.0, 'Aguas');
insert into prateleira values (4, 'y823y7ejdl528', 'Iz*One Inc.', 40.0, 'Chocolates');
insert into prateleira values (5, 'y823y7ejdl528', 'Iz*One Inc.', 0.0, 'Batatas');
insert into prateleira values (1, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 160.0, 'Refrigerantes');
insert into prateleira values (2, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 120.0, 'Sumos');
insert into prateleira values (3, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 80.0, 'Aguas');
insert into prateleira values (4, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 40.0, 'Chocolates');
insert into prateleira values (5, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 0.0, 'Batatas');

insert into planograma values ('8475839485746', 1, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'esquerda');
insert into planograma values ('2938462536475', 1, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'centro');
insert into planograma values ('9263414278345', 1, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'direita');
insert into planograma values ('7354729384673', 2, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'esquerda');
insert into planograma values ('4374957364927', 2, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'centro');
insert into planograma values ('8017372178812', 2, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'direita');
insert into planograma values ('7593743874839', 3, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'esquerda');
insert into planograma values ('3456527892981', 3, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'centro');
insert into planograma values ('6472746574636', 3, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'direita');
insert into planograma values ('7465747364567', 4, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'esquerda');
insert into planograma values ('8546572647374', 4, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'centro');
insert into planograma values ('6385763882778', 4, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'direita');
insert into planograma values ('7465747364567', 5, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'esquerda');
insert into planograma values ('6253647586345', 5, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'centro');
insert into planograma values ('9127277367632', 5, 'y823y7ejdl528', 'Iz*One Inc.', 1, 30, 'direita');
insert into planograma values ('2938462536475', 1, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'esquerda');
insert into planograma values ('9263414278345', 1, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'centro');
insert into planograma values ('6572837465734', 1, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'direita');
insert into planograma values ('4374957364927', 2, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'esquerda');
insert into planograma values ('8017372178812', 2, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'centro');
insert into planograma values ('1829372091828', 2, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'direita');
insert into planograma values ('3456527892981', 3, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'esquerda');
insert into planograma values ('6472746574636', 3, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'centro');
insert into planograma values ('6452628382911', 3, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'direita');
insert into planograma values ('8546572647374', 4, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'esquerda');
insert into planograma values ('6385763882778', 4, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'centro');
insert into planograma values ('8374657687987', 4, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'direita');
insert into planograma values ('6253647586345', 5, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'esquerda');
insert into planograma values ('9127277367632', 5, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'centro');
insert into planograma values ('5266178267281', 5, 's213sacs29c8a', 'Rainbow Bridge World Lda.', 1, 30, 'direita');

insert into retalhista values ('7463857', 'Nicki Minaj');
insert into retalhista values ('6475869', 'Ariana Grande');
insert into retalhista values ('8828910', 'Taylor Swift');
insert into retalhista values ('8495768', 'Jang Wonyoung');
insert into retalhista values ('8495769', 'Jo Yuri');
insert into retalhista values ('8495770', 'Choi Yena');
insert into retalhista values ('1035576', 'Kang Hyungu');
insert into retalhista values ('9684637', 'Tim Henson');

insert into responsavel_por values ('Bebidas', '7463857', 'y823y7ejdl528', 'Iz*One Inc.');
/*insert into responsavel_por values ('Chocolates', '6475869', 'y823y7ejdl528', 'Iz*One Inc.');
insert into responsavel_por values ('Batatas', '8828910', 'y823y7ejdl528', 'Iz*One Inc.');*/
insert into responsavel_por values ('Refrigerantes', '8495768', 's213sacs29c8a', 'Rainbow Bridge World Lda.');
/*insert into responsavel_por values ('Sumos', '8495769', 's213sacs29c8a', 'Rainbow Bridge World Lda.');
insert into responsavel_por values ('Aguas', '8495770', 's213sacs29c8a', 'Rainbow Bridge World Lda.');
insert into responsavel_por values ('Chocolates', '1035576', 's213sacs29c8a', 'Rainbow Bridge World Lda.');
insert into responsavel_por values ('Batatas', '9684637', 's213sacs29c8a', 'Rainbow Bridge World Lda.');*/

insert into evento_reposicao values ('8475839485746', 1, 'y823y7ejdl528', 'Iz*One Inc.', '2007-07-05 00:00:01', 20, '7463857');
insert into evento_reposicao values ('7593743874839', 3, 'y823y7ejdl528', 'Iz*One Inc.', '2007-07-05 00:00:01', 30, '7463857');
insert into evento_reposicao values ('7593743874839', 3, 'y823y7ejdl528', 'Iz*One Inc.', '2008-04-12 00:00:01', 30, '7463857');
insert into evento_reposicao values ('6385763882778', 4, 'y823y7ejdl528', 'Iz*One Inc.', '2013-09-03 00:00:01', 5, '6475869');
insert into evento_reposicao values ('1829372091828', 2, 's213sacs29c8a', 'Rainbow Bridge World Lda.', '2022-06-02 00:00:01', 15, '8495769');
insert into evento_reposicao values ('9127277367632', 5, 's213sacs29c8a', 'Rainbow Bridge World Lda.', '2022-05-10 00:00:01', 25, '9684637');
