#! /usr/bin/env ruby

#little script that copies files to the Dropbox folder. 
#if the folder doesn't exist it creates it
#if the file is set for the Public folder, it returns the public link

#ARGV[0] - folder
#ARGV[1] - file

drop_str = "https://dl.dropbox.com/u/1041433/"

abort "no arguments" if ARGV.size < 2

f = File.absolute_path(ARGV[1])

dir = File.join(Dir.home, "/Dropbox/#{ARGV[0]}")

if not File.directory? dir
	Dir.mkdir dir
end


system "cp #{f} ~/Dropbox/#{ARGV[0]}"

str = drop_str + ARGV[1]
str.gsub! /\s/, "%20"

puts str if ARGV[0].eql? "Public" 
