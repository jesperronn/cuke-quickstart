# this file is nicked from
# https://gist.github.com/pcreux/1662281
Then /^I should see the following "([^"]*)" table:$/ do |table_selector, expected_table|
  step %Q(the element "#{table_selector}" should be visible)
  expected_table.diff!(table_at(table_selector).to_a)
end

def table_at(selector)
  Nokogiri::HTML(page.body).css(selector).map do |table|
    table.css('tr').map do |tr|
      tr.css('th, td').map { |td| td.text.gsub(/\s+/,' ').strip }
    end
  end[0].reject(&:empty?)
end
