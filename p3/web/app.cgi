#!/usr/bin/python3

import re
from wsgiref.handlers import CGIHandler
from flask import Flask, render_template, request

#Bibliotecas postgres
import psycopg2
import psycopg2.extras

app = Flask(__name__)

## SGBD configs
DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="ist194179" 
DB_DATABASE=DB_USER
DB_PASSWORD="1234"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)

@app.route('/')
def ops():
    return render_template("app.html")

@app.route('/categoria')
def categoria_ops():
    return render_template("categoria.html")

@app.route('/categoria/inserir')
def categoria_inserir_op():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT nome FROM categoria;" 
        cursor.execute(query)
        return render_template("inserir_categoria.html", categorias = cursor)
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()

@app.route('/categoria/inserir/update', methods=["POST"])
def categoria_inserir():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        cursor.execute("START TRANSACTION;")

        nova_categoria = request.form["nova_categoria"]
        super_categoria = request.form["super_categoria"]

        query = "INSERT INTO categoria (nome) VALUES (%s);"
        values = (nova_categoria,)

        query += "INSERT INTO categoria_simples (nome) VALUES (%s);"
        values += (nova_categoria,)

        if super_categoria != "":
            query_count = "SELECT COUNT(*) FROM super_categoria WHERE nome = (%s);"
            values_count = (super_categoria,)
            cursor.execute(query_count, values_count)

            if cursor.fetchone()['count'] == 0:
                query += "INSERT INTO super_categoria (nome) VALUES (%s);"
                values += (super_categoria,)

                query += "DELETE FROM categoria_simples WHERE nome = (%s);"
                values += (super_categoria,)

            query += "INSERT INTO tem_outra (super_categoria, categoria) VALUES (%s, %s);"
            values += (super_categoria, nova_categoria)

        cursor.execute(query, values)

        cursor.execute("COMMIT;")
        dbConn.commit()
        return query
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()

@app.route('/categoria/remover')
def categoria_remover_op():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        cursor.execute("START TRANSACTION;")

        query = "SELECT nome FROM super_categoria;" 
        cursor.execute(query)
        super_categorias = cursor.fetchall()

        query = "SELECT nome FROM categoria_simples INTERSECT SELECT cat FROM produto;" 
        cursor.execute(query)
        categorias_simples = cursor.fetchall()

        query = "SELECT nome FROM categoria_simples EXCEPT SELECT cat FROM produto;" 
        cursor.execute(query)

        html = render_template("remover_categoria.html", super_categorias = super_categorias, categorias_simples = categorias_simples, simples_sem_produtos = cursor)

        cursor.execute("COMMIT;")
        return html
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()

@app.route('/categoria/remover/update', methods=["POST"])
def categoria_remover():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        cursor.execute("START TRANSACTION;")

        categoria = request.form["nome"]

        query = "DELETE FROM tem_outra WHERE categoria = (%s);"
        values = (categoria,)

        query_outra = "SELECT super_categoria FROM tem_outra WHERE categoria = (%s)"
        values_outra = (categoria,)
        cursor.execute(query_outra, values_outra)
        for tem_outra in cursor.fetchall():
            query_outra = "SELECT COUNT(*) FROM tem_outra WHERE super_categoria = (%s)"
            super_categoria = tem_outra['super_categoria']
            values_outra = (super_categoria,)
            cursor.execute(query_outra, values_outra)
            if (cursor.fetchone()['count']) == 1:
                query += "DELETE FROM super_categoria WHERE nome = (%s);"
                values += (super_categoria,)

                query += "INSERT INTO categoria_simples (nome) VALUES (%s);"
                values += (super_categoria,)

        query += "DELETE FROM categoria_simples WHERE nome = (%s);"
        values += (categoria,)

        query += "DELETE FROM categoria WHERE nome = (%s);"
        values += (categoria,)
        cursor.execute(query, values)

        cursor.execute("COMMIT;")
        dbConn.commit()
        return query
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()

@app.route('/retalhista')
def retalhista_ops():
    return render_template("retalhista.html")

@app.route('/retalhista/inserir')
def retalhista_inserir_op():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

        return render_template("inserir_retalhista.html")

    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()

@app.route('/retalhista/inserir/update', methods=["POST"])
def retalhista_inserir():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

        tin_retalhista = request.form["tin_novo_retalhista"]
        nome_retalhista = request.form["nome_novo_retalhista"]

        query = "INSERT INTO retalhista (tin,nome) VALUES (%s, %s);"
        values = (tin_retalhista,nome_retalhista,)

        cursor.execute(query, values)

        cursor.execute("COMMIT;")
        dbConn.commit()
        return query
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()


@app.route('/retalhista/remover')
def retalhista_remover_op():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT tin, nome FROM retalhista;" 
        cursor.execute(query)
        return render_template("remover_retalhista.html", retalhistas = cursor)
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()


@app.route('/retalhista/remover/update', methods=["POST"])
def retalhista_remover():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

        retalhista = request.form["retalhista_remove"]

        query = "DELETE FROM evento_reposicao WHERE tin = (%s);"
        values = (retalhista,)

        query += "DELETE FROM responsavel_por WHERE tin = (%s);"
        values += (retalhista,)

        query += "DELETE FROM retalhista WHERE tin = (%s);"
        values += (retalhista,)
        cursor.execute(query, values)

        cursor.execute("COMMIT;")
        dbConn.commit()
        return query
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()


@app.route('/evento_reposicao')
def evento_reposicao():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT num_serie FROM evento_reposicao group by num_serie;"
        cursor.execute(query)
        return render_template("evento_reposicao.html", nums_serie = cursor)
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()

@app.route('/evento_reposicao/result', methods=["POST"])
def evento_reposicao_result():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

        cursor.execute("START TRANSACTION;")

        num_serie = request.form["num_serie"]

        query = "SELECT cat, SUM(unidades) FROM evento_reposicao NATURAL JOIN produto WHERE num_serie=(%s) GROUP BY cat;"
        values = (num_serie,)
        cursor.execute(query, values)
        eventos_cat_ = cursor.fetchall()

        query = "SELECT * FROM evento_reposicao WHERE num_serie=(%s);"
        values = (num_serie,)
        cursor.execute(query, values)

        html = render_template("evento_reposicao_result.html", eventos = cursor, eventos_cat = eventos_cat_, num_serie = num_serie)

        cursor.execute("COMMIT;")
        dbConn.commit()
        
        return html
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()

@app.route('/sub_categorias')
def listar_subcategorias():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT nome FROM super_categoria group by nome;"
        cursor.execute(query)
        return render_template("listar_subcategorias.html", categorias = cursor)
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()

@app.route('/sub_categorias/result', methods=["POST"])
def listar_subcategorias_result():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

        nome_cat = request.form["nome_cat"]

        query = "WITH RECURSIVE super AS ( SELECT tem_outra.categoria FROM tem_outra WHERE super_categoria = (%s) UNION ALL SELECT tem_outra.categoria FROM super, tem_outra WHERE super.categoria = tem_outra.super_categoria) SELECT * FROM super;"
        values = (nome_cat,)
        cursor.execute(query, values)

        return render_template("listar_subcategorias_result.html", sub_categorias = cursor, nome_cat = nome_cat)
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()


    
CGIHandler().run(app)