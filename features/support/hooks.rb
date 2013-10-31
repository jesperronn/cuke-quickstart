# save screenshot and html copy of DOM if scenario fails
After do |scenario|
  screenshot("__error_"+scenario.name.gsub(/[-\/]/, "_")) if scenario.failed?

end


# enable this to stop at first error by running 'cucumber FAILFAST=true ...'
After do |scenario|
  if(ENV['FAILFAST'])
    Cucumber.wants_to_quit = true if scenario.failed?
  end
end

After('@screenshot') do |scenario|
  screenshot( calculate_name() ) if scenario.passed? && ENV['NEWML_SCREENSHOT']
end


After('@fails') do |scenario|
	#todo register that this is allowed to fail
end



def log_steps(scenario)
  #$logger.debug scenario.backtrace_line
  $logger.debug "[#{page.status_code}] #{current_url}"
end

AfterStep do |scenario|
  log_steps scenario
end

