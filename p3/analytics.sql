/* 1) Num dado período (i.e. entre duas datas), por dia da semana, por concelho e no total. */

SELECT dia_semana, concelho, SUM(unidades)
FROM vendas
WHERE ano BETWEEN 2007 AND 2022
GROUP BY
   CUBE(dia_semana, concelho)
ORDER BY
   dia_semana,
   vendas.concelho;

/* 2) num dado distrito (i.e. “Lisboa”), por concelho, categoria, dia da semana e no total. */

SELECT concelho, cat, dia_semana, SUM(vendas.unidades)
FROM vendas
WHERE distrito = 'Beja'
GROUP BY
   ROLLUP(concelho, cat, dia_semana)
ORDER BY
   concelho,
   cat,
   dia_semana;