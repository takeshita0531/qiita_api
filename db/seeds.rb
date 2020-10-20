# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8


# for result in items do
#     Folder.create(article_id: result["id"])
# end 

# require 'net/http'
#     require 'json'
  
#     # PER_PAGE = 100
#     ACCESS_TOKEN = 'f0ac82b225df283fcbeee8dbb596b6feae29db03'
#     GET_ITEMS_URI = 'https://qiita.com/api/v2/items'
  
#     # def self.search(query, page: 1)
#     #   puts "API Search Condition: query:'#{query}', page:#{page}"
  
#       # リクエスト情報を作成
#       uri = URI.parse (GET_ITEMS_URI)
#       req = Net::HTTP::Get.new(uri.request_uri)
#       req['Authorization'] = "Bearer #{ACCESS_TOKEN}"
  
#       # リクエスト送信
#       http = Net::HTTP.new(uri.host, uri.port)
#       http.use_ssl = true
#       res = http.request(req)
      
#       hash = JSON.parse(res.body)
      
#       for result in hash do
#           Folder.create(article_id: result["id"])
#       end 
    #  hash['group'].each do |key, value|
    #  Folder.create(article_id: key, user_id: value)
    # end