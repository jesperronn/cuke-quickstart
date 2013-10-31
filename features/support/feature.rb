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

    actual_route = ROUTES[routes_key]

    if actual_route && actual_route.include?("_TOKEN_")
      selected_route = replace_token_with_testdata page_name, routes_key
    else
      selected_route = actual_route || page_name
    end

    $logger.info "path_to (selected_route): #{selected_route}"
    raise "FATAL: No valid route found for \n'#{page_name}' => '#{selected_}" if selected_route == ""
    raise "FATAL: no valid _TOKEN_ replacement found for \n'#{page_name}' => '#{ROUTES[page_name]}'" if selected_route.include? "_TOKEN_"
    prefix = MyData.env('path_prefix')

    return "#{prefix}#{selected_route}"
  end

  def replace_token_with_testdata(page_name, actual_route)
      # example from route:
      # "shipment binder overview for a typical booking" 
      #          => "/shipmentbinder/b/_TOKEN_/overview"

      testdata_key = page_name.gsub(/^(.+?) for /, '')
      substitution = MyData.lookup(testdata_key)

      $logger.debug "key: " + testdata_key + " substitution: " + substitution
      $logger.debug "path_to: (selecting 'a typical....')"

      return actual_route.gsub("_TOKEN_", substitution)
  end


end




World(NavigationHelpers)
