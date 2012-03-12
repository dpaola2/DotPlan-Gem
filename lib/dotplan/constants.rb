module DotPlan
  DOTPLAN_URL = ENV['DOTPLAN_URL'] || "http://dotplanstream.herokuapp.com"
  CREDENTIALS_PATH = File.join(ENV["HOME"], ".dotplan", "credentials.json")
  TEMP_PATH = File.join(ENV["HOME"], ".dotplan", "temp")
end
