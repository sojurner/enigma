require './lib/enigma'
require 'pry'
require 'csv'

file_reader = File.open(ARGV[0], 'r')
message = file_reader.read.split(",")
enigma = Enigma.new
encrypted = enigma.encrypt(message[0], message[1], message[2])

file_writer = File.open(ARGV[1], 'w')
file_writer.write(encrypted)

puts "Created #{ARGV[1]} with the key #{encrypted[:key]} and date #{encrypted[:date]}"

file_reader.close
file_writer.close