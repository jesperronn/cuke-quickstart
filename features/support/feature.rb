require 'logger'
module NavigationHelpers

### helper methods used in the step_definitions
  def get(path)
    $logger.info("visit: '#{path}'")
    visit path
  end


# standard functionality: map name directly if it has an exact match in ROUTES
#
def path_to(page_name)
  $logger.warn "Warning: No valid route found in routes.rb for '#{page_name}'" if ROUTES[page_name].nil?
  selected_route = ""
  routes_key = page_name.gsub(/^((.+?)) for.*/,'\1')
  if ROUTES[routes_key] && ROUTES[routes_key].include?("_TOKEN_")

    #{}"shipment binder overview for a typical booking" => "/shipmentbinder/b/_TOKEN_/overview",

    testdata_key = page_name.gsub(/^(.+?) for /, '')
    booking_number = testdata(testdata_key)

    $logger.debug "key: " + testdata_key + " number: " + booking_number
    $logger.debug "path_to: (selecting 'a typical....')"
    selected_route = ROUTES[routes_key].gsub("_TOKEN_", booking_number)
  else
    selected_route = ROUTES[routes_key] || page_name
  end

  $logger.info "path_to (selected_route): #{selected_route}"
  raise "FATAL: No valid route found for \n'#{page_name}' => '#{selected_}" if selected_route == ""
  raise "FATAL: no valid _TOKEN_ replacement found for \n'#{page_name}' => '#{ROUTES[page_name]}'" if selected_route.include? "_TOKEN_"
  prefix = MyData.env('path_prefix')

  return "#{prefix}#{selected_route}"
end

def testdata(key)
  MyData.lookup key
end

end




World(NavigationHelpers)
