require 'highline/import'

# Public: Various methods shared by all classes.
module Tools

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

  def check_value(val)
    %w(X O).include?(val)
  end

  def normalize_square_number(number)
    number - 1
  end

  def other_mark(selected_mark)
    %w(X O).reject { |m| m == selected_mark }.first
  end
end
