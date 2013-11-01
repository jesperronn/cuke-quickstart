# WE use these steps to interact with select2 autocomplete boxes
#
# NOTE: Requries javascript methods to be available on page -- we could however
#       pass them in via evaluate_script
#
When /^(?:|I )select first option from "(.*?)" in "(.*?)"$/ do |text, selector |
  page.evaluate_script(%[ select2TypeAndOpen("#{selector}", "#{text}") ])
  sleep(0.2)
  step %(I should see ignorecase "#{text}" within .select2-result-label)
  sleep(0.2)
  #screenshot "select_first_option_#{selector}"
  page.evaluate_script(%[ select2SelectFirst("#{selector}") ])
  sleep(0.2)
  step %(I should see ignorecase "#{text}" within #{selector.gsub('#','#s2id_')} .select2-choice)
  sleep(0.2)
  page.evaluate_script(%[ select2Close("#{selector}") ])
  sleep(0.2)
end

When /^(?:|I )select2 "(.*?)" in "(.*?)"$/ do |text, selector |
  page.evaluate_script(%[ select2Select("#{selector}", "#{text}") ])
  sleep(1.2)
end

