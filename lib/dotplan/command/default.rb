require 'date'
require 'uri'

module DotPlan
  module Command
    class Default
      def self.run(*args)
        begin
          credentials = JSON.parse(File.read(DotPlan::CREDENTIALS_PATH))
        rescue => e
          raise "There was a problem reading your credentials.  Run dotplan auth first.".red
        end
        username = credentials["username"]
        password = credentials["password"]
        date = Date.today.strftime("%m-%d-%Y")
        url = "#{DotPlan::DOTPLAN_URL}/user/#{username}/plan/#{date}"
        resource = RestClient::Resource.new(url, :Password => password)
        begin
          response = resource.get(:Password => password)
        rescue RestClient::ResourceNotFound => e
          begin
            response = resource.put(nil, :Password => password)
          rescue => e
            response = JSON.parse(e.response)
            raise response["error"].red
          end
        rescue => e
          response = JSON.parse(e.response)
          raise response["error"].red
        end

        plan = JSON.parse(response)
        puts plan

        File.open(DotPlan::TEMP_PATH, "w") do |f|
          f.write(plan["text"])
        end

        result = system("$EDITOR #{DotPlan::TEMP_PATH}")

        if result
          new_text = URI.escape(File.read DotPlan::TEMP_PATH)
          begin
            resource = RestClient::Resource.new("#{url}?text=#{new_text}", :Password => password)
            response = resource.put nil, :Password => password
          rescue => e
            puts e.message
          end
        end
      end
    end
  end
end
