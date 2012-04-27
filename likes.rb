#coding:utf-8
require 'open-uri'
require 'rubygems'
require 'sqlite3'
require 'json'
require 'clockwork'
include Clockwork

handler do |job|
  db = SQLite3::Database.new("data.db")
  db.execute('select * from facebook') do |row|
  @count=row[0].to_i
  end
  db.close
  puts @count
  res = open("https://graph.facebook.com/http://web.sfc.keio.ac.jp/~t10064ai/like_kun/index.html").read
  res2 = JSON.parse(res)
  if res2["shares"].nil?
    like_count = 0
  else
    like_count = res2["shares"]
  end
 
  puts like_count
  if @count.to_i!=like_count.to_i
  	db = SQLite3::Database.new("data.db")
  	db.execute("delete from facebook where likes='#{@count}'")
  	sql = "insert into facebook values (:likes)"
  	db.execute(sql, :likes => like_count)
    db.close
    puts "hoge" 
  end
end

every(10.seconds, 'frequent.job')
