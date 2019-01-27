require './lib/enigma'
require 'pry'
require 'csv'

message = CSV.read(ARGV[0]).flatten
enigma = Enigma.new
encrypted = enigma.encrypt(message[0], message[1], message[2])
puts "Created #{ARGV[1]} with the key #{encrypted[:key]} and date #{encrypted[:date]}"
