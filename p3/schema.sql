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
    foreign key (nome) references categoria(nome)
);

create table super_categoria (
    nome varchar(100) not null,
    primary key (nome),
    foreign key (nome) references categoria
);

create table tem_outra (
    super_categoria varchar(100) not null,
    categoria varchar(100) not null,
    primary key (categoria),
    foreign key (super_categoria) references super_categoria(nome),
    foreign key (categoria) references categoria(nome),
    check (super_categoria != categoria)
);

create table produto (
    ean char(13) not null,
    cat varchar(100) not null,
    descr varchar(100),
    primary key (ean),
    foreign key (cat) references categoria(nome)
);

create table tem_categoria (
    ean char(13) not null,
    nome varchar(100) not null,
    foreign key(ean) references produto(ean),
    foreign key(nome) references categoria(nome)
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
    foreign key(num_serie, fabricante) references ivm(num_serie, fabricante),
    foreign key(sitio) references ponto_de_retalho(nome)

);

create table prateleira (
    nro int not null,
    num_serie varchar(100) not null,
    fabricante char(100) not null,
    altura float(24) not null,
    nome varchar(100) not null,
    primary key (nro, num_serie, fabricante),
    foreign key (num_serie, fabricante) references ivm(num_serie, fabricante),
    foreign key(nome) references categoria(nome)
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
    foreign key (ean) references produto(ean),
    foreign key (nro, num_serie, fabricante) references prateleira(nro, num_serie, fabricante)
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
    foreign key (tin) references retalhista(tin),
    foreign key (num_serie, fabricante) references ivm(num_serie, fabricante),
    foreign key (nome_cat) references categoria(nome)
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
    foreign key (ean, nro, num_serie, fabricante) references planograma(ean, nro, num_serie, fabricante),
    foreign key (tin) references retalhista(tin)
);
