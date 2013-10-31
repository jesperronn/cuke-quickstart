# Twitter bootstrap general interaction
# with the modal windows
# We use with Twitter Bootstrap 2.3.2
#
When /^I submit the modal window "(.*?)"$/ do |element|
  page.find(element+" .modal-footer a.btn-primary").trigger("click")
end

When /^I cancel the modal window "(.*?)"$/ do |element|
  page.find(element+" .modal-footer .btn:not(.btn-primary)").trigger("click")
end

When /^I close the modal window "(.*?)"$/ do |element|
  page.find(element+" .modal-header .close").trigger("click")
end

Then /^the modal window "(.*?)" should be hidden$/ do |element|
  page.find(element + ":not(.in)")

end

Then /^the modal window "(.*?)" should be visible$/ do |element|
  find(element + ".in")
  #page.find(element + ".in")
end
