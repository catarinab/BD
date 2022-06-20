insert into categoria values ('Liquidos')
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

insert into tem_categoria values ('8475839485746', 'Bebidas');
insert into tem_categoria values ('8475839485746', 'Refrigerantes');
insert into tem_categoria values ('2938462536475', 'Bebidas');
insert into tem_categoria values ('2938462536475', 'Refrigerantes');
insert into tem_categoria values ('9263414278345', 'Bebidas');
insert into tem_categoria values ('9263414278345', 'Refrigerantes');
insert into tem_categoria values ('6572837465734', 'Bebidas');
insert into tem_categoria values ('6572837465734', 'Refrigerantes');
insert into tem_categoria values ('7354729384673', 'Bebidas');
insert into tem_categoria values ('7354729384673', 'Sumos');
insert into tem_categoria values ('4374957364927', 'Bebidas');
insert into tem_categoria values ('4374957364927', 'Sumos');
insert into tem_categoria values ('8017372178812', 'Bebidas');
insert into tem_categoria values ('8017372178812', 'Sumos');
insert into tem_categoria values ('1829372091828', 'Bebidas');
insert into tem_categoria values ('1829372091828', 'Sumos');
insert into tem_categoria values ('7593743874839', 'Bebidas');
insert into tem_categoria values ('7593743874839', 'Aguas');
insert into tem_categoria values ('3456527892981', 'Bebidas');
insert into tem_categoria values ('3456527892981', 'Aguas');
insert into tem_categoria values ('6472746574636', 'Bebidas');
insert into tem_categoria values ('6472746574636', 'Aguas');
insert into tem_categoria values ('6452628382911', 'Bebidas');
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
insert into responsavel_por values ('Refrigerantes', '8495768', 's213sacs29c8a', 'Rainbow Bridge World Lda.');

insert into evento_reposicao values ('8475839485746', 1, 'y823y7ejdl528', 'Iz*One Inc.', '2007-07-05 00:00:01', 20, '7463857');
insert into evento_reposicao values ('7593743874839', 3, 'y823y7ejdl528', 'Iz*One Inc.', '2007-07-05 00:00:01', 30, '7463857');
insert into evento_reposicao values ('7593743874839', 3, 'y823y7ejdl528', 'Iz*One Inc.', '2008-04-12 00:00:01', 30, '7463857');
insert into evento_reposicao values ('6385763882778', 4, 'y823y7ejdl528', 'Iz*One Inc.', '2013-09-03 00:00:01', 5, '6475869');
insert into evento_reposicao values ('1829372091828', 2, 's213sacs29c8a', 'Rainbow Bridge World Lda.', '2022-06-02 00:00:01', 15, '8495769');
insert into evento_reposicao values ('9127277367632', 5, 's213sacs29c8a', 'Rainbow Bridge World Lda.', '2022-05-10 00:00:01', 25, '9684637');
