Sample Command line Username Generator
=========================

  Usage:

      require_relative 'usernameGenerator'

      generator = UsernameGenerator.new

      generator.generate('sample@email.com')


  Updating username.txt:

      `generator.refresh`

  Running the benchmark:
      `ruby benchmark.rb`
