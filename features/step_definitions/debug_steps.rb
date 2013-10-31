#from https://raw.github.com/kucaahbe/cucumber-websteps/master/lib/cucumber/websteps/debug_steps.rb

Then /^show me the page$/ do
  save_and_open_page
end

Then /^I take a screenshot(?: named ([^ ]*))?$/ do |name|
  #page.driver.render("screenshot.png")
  screenshot name
end
When /^I open the debug browser$/ do
  page.driver.debug
end

When /^I log the network traffic for the page$/ do
  $logger.info page.driver.network_traffic
end
