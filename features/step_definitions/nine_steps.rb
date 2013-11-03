
Given(/^I should see the following employees:$/) do |expected_table|
	names = elems_of_type_within('.info', '.darkroom')

	names_and_positions = names.map{|line| line.split(/\w+@/).first.strip}
	#$logger.info expected_table
	#$logger.info names.zip
	expected_table.diff! names_and_positions.zip
end


