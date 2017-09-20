require 'highline/import'

module ViewHelpers

    # Public: Request input from the user.
    #
    # prompt - the String to display to the user.
    #
    # Examples
    #
    #   query('What is your name? ')
    #
    # Return a String with the user's input.
    def query(prompt)
      ask(prompt)
    end

    # Public: Output text to the console.
    #
    # message - the String message to display to the user.
    #
    # Returns nothing.
    def output(message)
      say(message)
    end

    # Public: Output text to the console in green.
    #
    # message - the String message to display to the user.
    #
    # Returns nothing.
    def notify(message)
      output("<%= color(\"#{message}\", :green) %>")
    end

    # Public: Output text to the console in yellow.
    #
    # message - the String message to display to the user.
    #
    # Returns nothing.
    def alert(message)
      output("<%= color('#{message}', :yellow) %>")
    end

    # Public: Output text to the console in red.
    #
    # message - the String message to display to the user.
    #
    # Returns nothing.
    def uhoh(message)
      output("<%= color('#{message}', :red) %>")
    end
end
