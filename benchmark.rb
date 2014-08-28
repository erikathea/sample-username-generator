require 'benchmark'
require_relative 'usernameGenerator'

puts 'Benchmark for hash implementation'
generator = UsernameGenerator.new(2)

10.times do |x| puts Benchmark.measure { generator.generate('john@email.com') } end
10.times do |x| puts Benchmark.measure { generator.generate('gilda@email.com') } end

puts 'Benchmark for array implementation'
generator = UsernameGenerator.new

10.times do |x| puts Benchmark.measure { generator.generate('john@email.com') } end
10.times do |x| puts Benchmark.measure { generator.generate('gilda@email.com') } end


