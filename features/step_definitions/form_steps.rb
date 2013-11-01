#form_steps.rb from https://raw.github.com/kucaahbe/cucumber-websteps/master/lib/cucumber/websteps/form_steps.rb

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number                  | 5002       |
#     | Expiry date                     | 2009-11-01 |
#     | Note                            | Nice guy   |
#     | Wants Email?                    |            |
#     | Sex                  (select)   | Male       |
#     | Accept user agrement (checkbox) | check      |
#     | Send me letters      (checkbox) | uncheck    |
#     | radio 1              (radio)    | choose     |
#     | Avatar               (file)     | avatar.png |
#
When /^(?:|I )fill in the following:$/ do |fields|

  select_tag    = /^(.+\S+)\s*(?:\(select\))$/
  check_box_tag = /^(.+\S+)\s*(?:\(checkbox\))$/
  radio_button  = /^(.+\S+)\s*(?:\(radio\))$/
  file_field    = /^(.+\S+)\s*(?:\(file\))$/

  fields.rows_hash.each do |name, value|
    case name
    when select_tag
      step %(I select "#{value}" from "#{$1}")
    when check_box_tag
      case value
      when 'check'
        step %(I check "#{$1}")
      when 'uncheck'
        step %(I uncheck "#{$1}")
      else
        raise 'checkbox values: check|uncheck!'
      end
    when radio_button
      step %{I choose "#{$1}"}
    when file_field
      step %{I attach the file "#{value}" to "#{$1}"}
    else
      step %{I fill in "#{name}" with "#{value}"}
    end
  end
end


# Sets @today as a constant so that we can later compare dates with @today 
# example
#   Given today is "2012-10-01"
#
# Used by 'I fill in "" with today plus x'
# 
Given /^today is "(.+?)"$/ do |date|
  @today = Date.parse(date)
end


When /^I fill in "(.*?)" with today plus (\d+)$/ do |field, dateDiff|
  element = find_field(field)
  val = (@today + dateDiff.to_i).strftime(DateFormat::uk)
  element.set(val)

  find('body').trigger "mousedown"
end

When /^I fill in "(.*?)" with today plus (\d+) with dot-format$/ do |field, dateDiff|
  element = find_field(field)
  val = (@today + dateDiff.to_i).strftime(DateFormat::eu)
  element.set(val)

  find('body').trigger "mousedown"
end

When /^(?:|I )fill in "(.*?)" with "(.*?)"$/ do |field, value|
  fill_in(field, :with => value, :visible => true, :exact => true)
end

When /^(?:|I )fill in "(.*?)" with:$/ do |field, value|
  fill_in(field, :with => value, :visible => true)
end

When /^(?:|I )select "(.*?)" from "(.*?)"$/ do |value, field|
  begin
    select(value, :from => field)
  rescue Capybara::ElementNotFound
    the_select = find_field field
    if(the_select.nil?)
      raise "No select named '#{field}' found"
    end
    raise "No element with value '#{value}' found in selectbox '#{field}'. Options: #{the_select.all('option').map(&:text).join(',')}"
  end
end

When /^(?:|I )check "(.*?)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "(.*?)"$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "(.*?)"$/ do |field|
  choose(field)
end

Then(/^"(.*?)" should not be checked$/) do |field|
  find_field(field, :checked => false)
end

Then(/^"(.*?)" should be checked/) do |field|
  find_field(field, :checked => true)
end

When /^(?:|I )attach the file "(.*?)" to "(.*?)"$/ do |file, field|
  path = File.expand_path(File.join(ROOT,"testdata/attachments/#{file}"))
  raise RuntimeError, "file '#{path}' does not exists" unless File.exists?(path)

  attach_file(field, path)
end

Then(/^the "(.*?)" field should be empty$/) do |locator|
  page.should have_field(locator, :with => "")
end

Then(/^the "(.*?)" field should not be empty$/) do |field|
  should_not have_field field, with: ""
end

Then /^the "(.*?)" field should contain "(.*?)"$/ do |field, value|
  page.should have_field field, :with => value
end

Then /^the "(.*?)" field should contain:$/ do |field, value|
  find_field(field, :with => value, :visible => true)
end

Then /^the "(.*?)" field should not contain "(.*?)"$/ do |locator, value|
  #TODO find should be find_field so we avoid unnecessary #id hashes
  field = page.find_field(locator)
  if(field)
    field.value.should_not =~ /#{value}/
  else
    fail "Found field but has value #{field.value}"
  end
end

Then /^the invisible field "(.*?)" should contain "(.*?)"$/ do |locator, text|
  page.find_field(locator, :visible => false, :with => text)
end

Then /^the invisible field "(.*?)" should contain:$/ do |locator, text|
  begin
    page.find_field(locator, :visible => false, :with => text)
  rescue Capybara::ElementNotFound
    elem = find_field(locator, :visible => false)
    message = %(Unable to find field "#{locator}" with value "#{value}" -- found #{elem})

    #the line below will raise exception if text not matching
    elem.value.should eq(value) if elem

    message += %( -- value: '#{elem.value}') if elem
    raise message
  end
end


#      | label, name or id | value |
#      | #i-containers-1-equipmentStuffings-1-cargo-hsCode |070310 |
#
#   And the "#i-containers-1-equipmentStuffings-1-cargo-hsCode" field should contain "070310"
When(/^I should verify content of the following fields:$/) do |table|
  # table is a | |
  table.hashes.each do |item|
    raise "FATAL: item['label, name or id'] not available, did you remember heading for your table" if item['label, name or id'].nil? or item['label, name or id'].empty?
    raise "FATAL: item[:value] not available, did you remember heading for your table" if item[:value].nil?
    step %(the "#{item['label, name or id']}" field should contain "#{item[:value]}")
  end
end


When /^(?:|I )press "(.*?)"$/ do |button|
  click_button(button)
end

Then /^the select "(.*?)" should have the following options:$/ do |field, options|
  options = options.transpose.raw
  raise 'table should have only one column in this step!' if options.size > 1
  options = options.first

  page.should have_select field, :options => options
end




Then /^the select "(.*?)" should have the following visible options:$/ do |field, options|
  #visible is defined here as the <option> elements inside optgroups without class="hide"
  locator_exp = "optgroup:not(.hide) option"

  options = options.transpose.raw
  raise 'table should have only one column in this step!' if options.size > 1
  options = options.first

  select = find_field(field)
  
  actual_options = select.all(locator_exp).map { |option| option.text }

  if options.respond_to?(:should)
    actual_options.should eq(options)
  else
    assert_equal options, actual_options
  end
end



When /^(?:I|i) select following values from "(.*?)":$/ do |field, values|
  values = values.transpose.raw
  if values.size > 1
    raise 'table should have only one column in this step!'
  else
    values = values.first
  end

  values.each do |value|
    select(value, :from => field)
  end
end

When /^(?:I|i) unselect following values from "(.*?)":$/ do |field, values|
  values = values.transpose.raw
  if values.size > 1
    raise 'table should have only one column in this step!'
  else
    values = values.first
  end

  values.each do |value|
    unselect(value, :from => field)
  end
end

Then /^the option "(.*?)" should be selected in "(.*?)"$/ do |value, selector|
  #begin
    page.should have_select(selector, :selected => value)
  #rescue RSpec::Expectations::ExpectationNotMetError
  #    begin
  #      select_box=find_field(selector)
  #      select_box.value.should eq(value)
  #    rescue RSpec::Expectations::ExpectationNotMetError
  #      select_box.find("option[selected]").text.should eq(value)
  #    end
  #end
end


Then /^the following values should be selected in "(.*?)":$/ do |select_box, values|
  values = values.transpose.raw
  if values.size > 1
    raise 'table should have only one column in this step!'
  else
    values = values.first
  end

  select_box=find_field(select_box)
  unless select_box['multiple']
    raise "this is not multiple select box!"
  else
    values.each do |value|
      if select_box.respond_to?(:should)
	select_box.value.should include(value)
      else
	assert select_box.value.include?(value)
      end
    end
  end
end

Then /^the following values should not be selected in "(.*?)":$/ do |select_box, values|
  values = values.transpose.raw
  if values.size > 1
    raise 'table should have only one column in this step!'
  else
    values = values.first
  end

  select_box=find_field(select_box)
  unless select_box['multiple']
    raise "this is not multiple select box!"
  else
    values.each do |value|
      if select_box.respond_to?(:should)
	select_box.value.should_not include(value)
      else
	assert !select_box.value.include?(value)
      end
    end
  end
end

