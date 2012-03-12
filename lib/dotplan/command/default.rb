module DotPlan
  module Command
    class Default
      def self.run(*args)
        # find a temp file
        puts system("$EDITOR")
      end
    end
  end
end
