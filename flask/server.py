from flask import Flask, g
import sqlite3

INIT_SQL = './init.sql'
DATABASE = './main.db'

app = Flask(__name__)


def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
        def make_dicts(cursor, row):
            return dict((cursor.description[idx][0], value)
                        for idx, value in enumerate(row))

        db.row_factory = make_dicts
        # db.row_factory = sqlite3.Row
    return db


with app.app_context():
    db = get_db()
    with app.open_resource(INIT_SQL, 'r') as f:
        db.executescript(f.read())
        db.commit()


def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv


def insert_db(title, content):
    cur = get_db().execute('INSERT INTO posts (title, content) VALUES(?, ?)', (title, content))
    get_db().commit()
    cur.close()


@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()


@app.route("/api")
def hello_world():
    return "Hello, World!"


@app.route("/api/get")
def get():
    res = query_db("SELECT * FROM posts")
    return str(res)


@app.route("/api/put")
def put():
    res = insert_db("title", "Content")
    return 'ok'
