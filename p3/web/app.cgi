#!/usr/bin/python3

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

        nova_categoria = request.form["nova_categoria"]
        super_categoria = request.form["super_categoria"]

        query = f'''INSERT INTO categoria VALUES ({(nova_categoria,)});'''
        cursor.execute(query)

        query = f'''INSERT INTO categoria_simples VALUES ({(nova_categoria,)});'''
        cursor.execute(query)

        if super_categoria != "":
            query = f'''SELECT COUNT(*) FROM super_categoria WHERE nome = {super_categoria};'''
            cursor.execute(query)

            if cursor['count'] == 0:
                query = f'''INSERT INTO super_categoria VALUES ({(super_categoria,)});'''
                cursor.execute(query)

                query = f'''DELETE FROM categoria_simples WHERE nome = {super_categoria};'''
                cursor.execute(query)

            query = f'''INSERT INTO tem_outra VALUES ({(super_categoria, nova_categoria)});'''
            cursor.execute(query)
            
        return query
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()

@app.route('/categoria/remover')
def categorias_remover_op():
    dbConn = None 
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        query = "SELECT nome FROM categoria;" 
        cursor.execute(query)
        return render_template("remover_categoria.html", categorias = cursor)
    except Exception as e:
        return str(e) #Renders a page with the error.
    finally: 
        cursor.close()
        dbConn.close()
    
CGIHandler().run(app)