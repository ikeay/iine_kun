#coding:utf-8
require 'open-uri'
require 'rubygems'
require 'json'
require 'clockwork'
require 'redis'
include Clockwork

handler do |job|
  uri = URI.parse(ENV["REDISTOGO_URL"])
  redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  count=redis.get("like")
  res = open("https://graph.facebook.com/http://web.sfc.keio.ac.jp/~t10064ai/like_kun/index.html").read
  res2 = JSON.parse(res)
  if res2["shares"].nil?
    like_count = 0
  else
    like_count = res2["shares"]
  end
  puts "redis get:"+ count
  puts "like:" + like_count
  if count.to_i!=like_count.to_i
    redis.set("like", like_count) 
  end
  puts "redis set:" + redis.get("like")
end

every(5.seconds, 'frequent.job')
