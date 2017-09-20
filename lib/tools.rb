# Public: Utility methods useful to all classes.
module Tools

  # Public: Check that the value is a valid mark for our game.
  #
  # val - The String value to check.
  #
  # Returns TrueClass or FalseClass.
  def check_value(val)
    %w(X O).include?(val)
  end

  # Public: (Most) Humans start counting at one. Computers start at zero.
  #
  # number - The Integer number to normalize.
  #
  # Returns an Integer with the number reduced by one.
  def normalize_square_number(number)
    number - 1
  end

  # Public: The mark for the AI to use.
  #
  # selected_mark - The mark the Human player has selected.
  #
  # Returns a String.
  def other_mark(selected_mark)
    %w(X O).reject { |m| m == selected_mark }.first
  end
end
