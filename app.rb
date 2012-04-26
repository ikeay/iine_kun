require 'sinatra'

get '/' do
  File.open("likes.json") do |f|
    f.read
  end
end
