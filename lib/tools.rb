

# Public: Various methods shared by all classes.
module Tools


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
