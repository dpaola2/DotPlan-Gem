module DotPlan
  module Command
    class Register
      def self.run(*args)
        print "Desired username: "
        username = $stdin.gets.chomp

        print "Password: "
        system "stty -echo"
        password = $stdin.gets.chomp
        system "stty echo"

        print "\n"

        begin
          credentials = register(:username => username, :password => password)
          puts 'Registered!  Run "dotplan auth" now.'
        rescue => e
          puts e
        end
      end

      def self.register(options)
        raise "No username provided".red unless options[:username]
        raise "No password provided".red unless options[:password]
        begin
          resource = RestClient::Resource.new("#{DotPlan::DOTPLAN_URL}/user/#{options[:username]}", :Password => options[:password])
          response = resource.post nil, :Password => options[:password]
        rescue => e
          response = JSON.parse(e.response)
          raise response["error"].red
        end
        credentials = JSON.parse(response.body)
        credentials
      end
    end
  end
end
