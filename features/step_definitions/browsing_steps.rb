#browsing_steps.rb from https://raw.github.com/kucaahbe/cucumber-websteps/master/lib/cucumber/websteps/browsing_steps.rb

Given /^(?:|I )am on ([^,]+)$/ do |page_name|
  step "I go to #{page_name}"
end

When /^(?:|I )go to ([^,]+)$/ do |page_name|
  get path_to(page_name)
  step "I am not on an error page"
end

Then /^(?:|I )am not on an error page$/ do
  steps %Q(
      Then I should not see "Internal Server Error"
      Then I should not see "No Office Specified"
      Then I should not see "An error occurred"
  )
end

When /^(?:|I )(?:follow|click) "(.+?)"$/ do |text|
  click_link(text)
end


When /^(?:|I )(?:follow|click) the (.+?) "(.+?)"$/ do |element_type, label|
  find(element_type, :text => label).click
end

Then /^(?:|I )should be redirected to (.+)$/ do |page|
  step "I should be on #{page}"
end

Then /^(?:|I )should see "([^"]+)"$/ do |text|
  page.should have_content(text)
end

Then /^(?:|I )should see '([^']+)'$/ do |text|
  page.should have_content(text)
end


Then /^(?:|I )should see ignorecase "([^"]+)"$/ do |text|
  page.body.should match(%r{#{text}}i)
end

Then /^(?:|I )should not see "([^"]+)"$/ do |text|
  page.should have_no_content(text)
end

Then /^(?:|I )should see \/([^\/]*)\/([imxo])?$/ do |regexp,flags|
  regexp_opts = [regexp,flags].compact
  regexp = Regexp.new(*regexp_opts)

  page.should have_xpath('//*', :text => regexp)
end

Then /^(?:|I )should not see \/([^\/]*)\/([imxo])?$/ do |regexp,flags|
  regexp_opts = [regexp,flags].compact
  regexp = Regexp.new(*regexp_opts)

  page.should have_no_xpath('//*', :text => regexp)

end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

Then /^the page should have status (\w+)$/ do |status_code|
  page.status_code.should == status_code.to_i
end

#how many elements of `locator` type which are actually visible
Then /^(?:|I )should see (\d+) elements? kind of "(.+?)"$/ do |count, locator|
  page.should have_selector(locator, :visible => true, :count => count)
end

Then /^(?:|I )should see at least (\d+) elements? kind of "(.+?)"$/ do |count, locator|
  page.should have_selector(locator, :minimum => count.to_i)
end

Then /^(?:|I )should not see elements? kind of "(.+?)"$/ do |locator|
  page.should have_selector(locator, :visible => true, :count => 0)
end


#example:
#    Then I should verify the following texts:
#      | verify      | visible  | within  |
#      | First text  | visible  | .first  |
#      | Second text | visible  | .second |
#   TODO 12th September. Revisit this step def as it gave problems looking up texts
Then /^(?:|I )should verify the following texts:$/ do |table|
  table.hashes.each do |item|
    raise "FATAL: item[:verify] not available, did you remember heading for your table" if item[:verify].nil? or item[:verify].empty?
    raise "FATAL: item[:visible] not available, did you remember heading for your table" if item[:visible].nil? or item[:visible].empty?
    within = ""
    within = %( within #{item[:within]}) unless item[:within].empty?
    step %(the text "#{item[:verify]}" should be #{item[:visible]}#{within})
  end
end

Then /^the text "(.*?)" should be visible$/ do |text|
  #NOTE: :xpath "//*" will match from ROOT, which actually works correct with the "within" scope selector.
  #page.should have_selector(":contains('#{text}')", :visible => true)
  page.should have_xpath("//*[contains(text(),'#{text}')]", :visible => true)
end

Then /^(?:|I )should not see "(.*?)" visibly$/ do |text|
  #NOTE: :xpath "//*" will match from ROOT, which actually works correct with the "within" scope selector.
  #page.should have_selector(":contains('#{text}')", :visible => true)
  page.should_not have_xpath("//*[contains(text(),'#{text}')]", :visible => true)
end

Then /^the text "(.*?)" should be hidden$/ do |text|
  page.find("*", :text => text, :visible => false, :exact => true)
end

Then /^the text "(.*?)" should not exist$/ do |text|
  page.should_not have_content(text)
end


Then /^the element "(.*?)" should be visible$/ do |selector|
  find(selector, :visible => true )
  #  page.find(selector, :visible => false ).visible?.should be_true
end

Then /^the element "(.*?)" should be hidden$/ do |selector|
  #NOTE: ':visible => false' forces to un-ignore hidden elements. THEN, evaluate `Capybara::Element.visible?` method
  element = nil
  begin
    #NOTE FIXME I think this will also match visible elements!
    find(selector, :visible => false )
  rescue Capybara::TimeoutError
    raise "FATAL: element '#{text}' not found to be hidden, #{element} <#{element.tag_name if element}>, #{"'"+element.text+"'" if element} (#{(element.visible? ? "visible":"hidden" )if element })"
  end
#  page.find(selector, :visible => false ).visible?.should be_false
end

Then /^the element "(.*?)" should be empty$/ do |selector|
  page.find(selector, :text=> '')
end

Then /^the element "(.*?)" should not be empty$/ do |selector|
  page.should have_selector(selector, :text => '')
end

Then /^the element "(.*?)" should contain text "(.*?)"$/ do |selector, value|
 page.should have_selector(selector, :text => value)
end

Then /^the element "(.*?)" should have value "(.*?)"$/ do |selector, text|
  page.should have_selector("#{selector}[value='#{text}']")
end


