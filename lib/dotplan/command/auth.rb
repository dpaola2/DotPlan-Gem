require "colorize"
require "rest-client"

module DotPlan
  module Command
    class Auth
      def self.run(*args)
        login
      end

      def self.login
        print "Username: "
        username = $stdin.gets.chomp

        print "Password: "
        system "stty -echo"
        password = $stdin.gets.chomp
        system "stty echo"

        print "\n"

        begin
          credentials = authenticate(:username => username, :password => password)
          write_credentials(credentials)
          puts "Saved to #{DotPlan::CREDENTIALS_PATH}.".green
        rescue => e
          puts e
        end
      end

      def self.authenticate(options)
        raise "Must provide a username".red unless options[:username]
        raise "Must provide a password".red  unless options[:password]

        response = RestClient.get("#{DotPlan::DOTPLAN_URL}/user/#{options[:username]}/auth", :Password => options[:password])

        credentials = JSON.parse(response.body)
        credentials
      end

      private

      def self.write_credentials(credentials)
        FileUtils.mkdir_p(File.dirname(DotPlan::CREDENTIALS_PATH))
        FileUtils.touch(DotPlan::CREDENTIALS_PATH)

        File.open(DotPlan::CREDENTIALS_PATH, "w+") { |file| file << credentials.to_json }
      end
    end
  end
end
