require './lib/enigma'
require 'pry'
require 'csv'

file_reader = File.open(ARGV[0], 'r')
message = file_reader.read.split(/,/)
enigma = Enigma.new
decrypt = enigma.decrypt(message[0], ARGV[2], ARGV[3])
file_writer = File.open(ARGV[1], 'w')
file_writer.write(decrypt[:decryption])
puts "Created #{ARGV[1]} with the key #{decrypt[:key]} and date #{decrypt[:date]}"

file_reader.close
file_writer.close