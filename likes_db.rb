#coding:utf-8
require 'sqlite3'
db = SQLite3::Database.new("data.db")
sql = <<SQL
create table facebook (
  likes integer
);
SQL
db.execute(sql)
db.close
