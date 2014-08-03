# Sample generator only

class UsernameGenerator

	# names 		- cache, list of usernames
	# db_count 	- flag, number of usernames
	attr_accessor :names, :db_count

	def initialize
		# it may take a while, depends on the
		# size of file: usernames.txt
		loadDatabase
	end

	def generate(email)
		# extract username from email address given
		# e.g. paul-angelo@mail.com to paulangelo
		username = email.split('@').first.gsub(/-|_/, '')
		listed_names = @names.select { |name| name.include? username }

		# appends number if username is taken
		# e.g. paulangelo to paulangelo1
		username = "#{username}#{@names.size}" unless listed_names.empty?

		# add username to cache
		@names << username
		return username
	end

	def refresh
		updateDatabase
	end

	private

	def loadDatabase
		# usernames.txt serves as db storage
		file = File.open('usernames.txt', 'r')
		@names = ((file.read).split("\n"))
		@db_count = @names.size
		file.close
	end

	def updateDatabase
		file = File.open('usernames.txt', 'a+')

		# add new usernames to usernames.txt file
		# start_index = @db_count -1
		# end_index = @names.size
		@names[(@db_count - 1)...@names.size].each do |name|
			file.write("\n#{name}")
		end

		file.close
		@db_count = @names.size
	end
end
