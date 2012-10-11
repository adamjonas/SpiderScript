 
require 'rubygems'
require 'sqlite3'

db =  SQLite3::Database.open('studentinfo.sqlite')

jack = "jaferferfeck"
nolan = "noerferferflan"

db.execute ( "INSERT INTO students (first_name, last_name)
				VALUES (\"#{jack}\", \"#{nolan}\")")
