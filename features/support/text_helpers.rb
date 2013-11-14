module TextHelpers

  # Teh private capybara methodt can be used when we get not-normalized 
  # space out of, for instance, a javascript call
  #
  # File 'lib/capybara/helpers.rb', line 18  (capybara version 2.1.0)
  def normalize_whitespace(text)
    text.to_s.gsub(/[[:space:]]+/, ' ').strip
  end


end

World(TextHelpers)
