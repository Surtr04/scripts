#!/usr/bin/env ruby


#deletes files of a particular extension in a folder or checking all subfolders

args = Hash.new

#sub
args["-s"] = :sub
#in
args["-i"] = :in



abort "isuficient number of arguments" if ARGV.size < 3

if args.has_key? ARGV[0]
	args[ARGV[0]].method.call
end

def sub 
	Dir.chdir(File.absolute_path(ARGV[0]))
	delete_ext = ".*." + ARGV[2]

	folders = `ls`

	folders = folders.split("\n")

	folders.reject! {|entry|
		!File.directory? entry
	}

	to_delete = Array.new

	folders.each do |folder|
		Dir.chdir folder

		(Dir.entries Dir.pwd).each do |x|
			if /#{delete_ext}/.match x
				#File.delete x
				to_delete << File.absolute_path(x)
			end
		end

		Dir.chdir ".."
	end

	puts "The following files will be deleted:\n\n"

	to_delete.each do |d|
		puts d
	end

	puts "Are you sure you want to proceed? (y/n)"
	answer = STDIN.gets

	if answer.chomp.eql? "y"
		to_delete.each do |d|
			File.delete d
		end
	end
end

def in

	Dir.chdir(File.absolute_path(ARGV[0]))
	delete_ext = ".*." + ARGV[2]

	files = `ls`
	files = files.split("\n")

	files.reject! {|entry|
		File.directory? entry
	}

	to_delete = Array.new

	files.each do |file|				
		if /#{delete_ext}/.match file				
			to_delete << File.absolute_path(file)
		end
	end

	puts "The following files will be deleted:\n\n"

	to_delete.each do |d|
		puts d
	end

	puts "Are you sure you want to proceed? (y/n)"
	answer = STDIN.gets

	if answer.chomp.eql? "y"
		to_delete.each do |d|
			File.delete d
		end
	end

end