#coding:utf-8
require 'open-uri'
require 'rubygems'
require 'json'
require 'clockwork'
include Clockwork

handler do |job|
  file = ""
  File.open("likes.json") do |f|
    file = JSON.parse(f.read)
  end
  count = file["like"]
  res = open("https://graph.facebook.com/http://web.sfc.keio.ac.jp/~t10064ai/like_kun/index.html").read
  res2 = JSON.parse(res)
  if res2["shares"].nil?
    like_count = 0
  else
    like_count = res2["shares"]
  end

  ruby_hash = {"like"=>like_count}
  json_hash = ruby_hash.to_json
  puts like_count
  if count.to_i!=like_count.to_i
    write_file = open("likes.json", "w")
    write_file.write(json_hash)
    write_file.close
  end
end

every(1.seconds, 'frequent.job')
