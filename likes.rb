#coding:utf-8

require 'open-uri'
require 'rubygems'
require 'json'
require 'clockwork'
include Clockwork

handler do |job|
	f = open("likes.json").read
	file = JSON.parse(f)
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
	if count!=like_count
		write_file = open("likes.json", "w")
			write_file.write(json_hash)
		write_file.close
	end
end

every(10.seconds, 'frequent.job')
