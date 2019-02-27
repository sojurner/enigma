require './lib/enigma'
require 'pry'
require 'csv'

file_reader = File.open(ARGV[0], 'r')
message = file_reader.read.split(/\n/)
enigma = Enigma.new
encrypted = enigma.encrypt(message[0], ARGV[2], ARGV[3])
file_writer = File.open(ARGV[1], 'w')
file_writer.write(encrypted[:encryption])


puts "Created #{ARGV[1]} with the key #{encrypted[:key]} and date #{encrypted[:date]}"

file_reader.close
file_writer.close