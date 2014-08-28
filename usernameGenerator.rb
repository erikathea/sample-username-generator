# Sample generator only

class UsernameGenerator

	# names 		- cache, list of usernames
	# db_count 	- flag, number of usernames
	attr_accessor :names, :db_count, :hashed_names

	def initialize(version=1)
		# it may take a while, depends on the
		# size of file: usernames.txt
		if version > 1
			loadHashDatabase
		else
			loadArrayDatabase
		end
	end

	def generate(email)
		if @names
			generate_via_array(email)
		elsif @hashed_names
			generate_via_hash(email)
		end
	end

	def refresh
		if @names
			updateArrayDatabase
		elsif @hashed_names
			updateHashDatabase
		end
	end

	private

	def generate_via_array(email)
		username = email.split('@').first.gsub(/-|_/, '')
		listed_names =	@names.select { |name| name.include? username }
		# appends number if username is taken
		# e.g. paulangelo to paulangelo1
		username = "#{username}#{@names.size}" unless listed_names.empty?

		# add username to cache
		@names << username
		return username
	end

	def generate_via_hash(email)
		key = email.split('@').first.gsub(/-|_/, '').split(/\d*\z/)

		if @hashed_names.has_key?(key)
			@hashed_names[key] = "#{(@hashed_names[key]).to_i + 1}"
			username = "#{key.first}#{@hashed_names[key]}"
		else
			@hashed_names[key] = 0
		end

		return username
	end

	def loadArrayDatabase
		# usernames.txt serves as db storage
		file = File.open('usernames.txt', 'r')
		@names = ((file.read).split("\n"))
		@db_count = @names.size
		file.close
	end

	def loadHashDatabase
		names = {}
		file = File.open('usernames.txt', 'r')
		((file.read).split("\n")).each do |name|
			name = name.strip
			unless name.empty?
				key = name.split(/\d*\z/)
				value = name.match(/\d*\z/)[0] # MatchData
				names[key] = value
				#puts value if key == "john"
				#if names.has_key?(key)
				#	names[key] << value
				#else
				#	names[key] = [value]
				#end

			end
		end

		@hashed_names = names
		@db_count = @hashed_names.size
	end

	def updateArrayDatabase
		file = File.open('usernames.txt', 'a+')

		@names[(@db_count - 1)...@names.size].each do |name|
			file.write("\n#{name}")
		end

		file.close
		@db_count = @names.size
	end

	def updateHashDatabase
		file = File.open('usernames.txt', 'a+')

		((@db_count + 1)..@hashed_names.size).each do |index|
			file.write("\n#{@hashed_names[index]}")
		end

		file.close
		@db_count = @hashed_names.size
	end
end
