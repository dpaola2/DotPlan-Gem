module DotPlan
  module Command
    class Log
      def self.run(*args)
        begin
          credentials = JSON.parse(File.read(DotPlan::CREDENTIALS_PATH))
        rescue => e
          raise "There was a problem reading your credentials. Run dotplan auth first.".red
        end

        username = credentials["username"]
        password = credentials["password"]
        url = "#{DotPlan::DOTPLAN_URL}/user/#{username}/plans"
        resource = RestClient::Resource.new(url)
        begin
          response = resource.get(:accept => "application/json")
        rescue => e
          response = JSON.parse(e.response)
          raise response["error"].red
        end
        begin
          plans = JSON.parse(response)
          plans.each do |plan|
            puts plan["date"].red
            puts plan["text"].green
          end
        rescue => e
          puts e.message.red
        end
      end
    end
  end
end
