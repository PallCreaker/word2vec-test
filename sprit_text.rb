#coding: utf-8

require 'rubygems'
require 'bundler'
require 'natto'

# m = MeCab::Tagger.new ("-Ochasen")
# print m.parse ("ようこそ...『男の世界』へ....")


nm = Natto::MeCab.new
puts nm.version

open("./data/oogiri.csv") do |file|
  140000.times do
    l = file.gets
    next if l.nil?

    no, title, answer, _, _ = l.split(',')
    text = title.to_s + answer.to_s
    text = "" if answer == "投稿なし" || text.nil?
    nm_result = nm.parse(text)
    puts nm_result.split("\n")
      .map {|line| line.split("\t")}
      .select {|line| line.size > 1}
      .map { |line|
      raw = line[1].split(",")[-3]
      raw == "*" ? line[0] : raw 
    }
      .join(" ")
  end
end