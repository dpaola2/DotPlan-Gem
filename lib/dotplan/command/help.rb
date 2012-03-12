module DotPlan
  module Command
    class Help

      def self.run(*args)
        helpstring = <<-eos
    Usage: 
      dotplan [auth | register | log | finger]
    
    If a command is omitted, you'll be dropped into $EDITOR to interact with today's .plan.

    Commands:
      auth            Authenticate by entering your username and password
      register        Register for a new account
      log             See your recent .plans
      finger <user>   Retrieve the .plan stream for <user>

eos
        puts helpstring
      end
    end
  end
end
