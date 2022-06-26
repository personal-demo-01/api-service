import sqlite3

conn = sqlite3.connect('database.db')
print ("Opened database successfully")

conn.execute('CREATE TABLE clients \
( id INTEGER PRIMARY KEY, \
  name varchar(30) NOT NULL, \
  money INTEGER NOT NULL\
)')
print ("Table created successfully")
conn.close()