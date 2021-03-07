import psycopg2
from psycopg2 import pool, extras


connection_pool = None


def get_connection_pool():
    global connection_pool

    if not connection_pool:
        connection_pool = psycopg2.pool.SimpleConnectionPool(
            1, 20, user="test", password="test", host="127.0.0.1", port="5433", database="test"
        )
    return connection_pool


class PGConnection:
    pgpool = get_connection_pool()

    def __init__(self):
        self.connection = self.pgpool.getconn()
        self.connection.autocommit = True

    def __enter__(self):
        return self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

    def __exit__(self, exc_type, exc_val, exc_tb):
        # self.connection.commit()
        pass


if __name__ == '__main__':
    connection = PGConnection()

    with connection as db:
        db.execute('INSERT INTO book (title, author) values (%s, %s)', ('Ololo', 'me'))

    with connection as db:
        db.execute('SELECT * FROM book')
        books = db.fetchall()


    # pgpool = get_connection_pool()
    # connection = pgpool.getconn()
    # cursor = connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # cursor.execute('INSERT INTO book (title, author) values (%s, %s)', ('Ololo', 'me'))
    # connection.commit()

    # print()
