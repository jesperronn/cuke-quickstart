require 'rubygems'
require 'bundler/setup'

require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'capybara/poltergeist/version'
require 'capybara/cucumber'
require 'capybara/rspec/matchers'

require 'test/unit'
require 'rspec'
require 'yaml'

# primitive logger feature
require File.dirname(__FILE__) + '/my_log'

#load of data/environments
require File.dirname(__FILE__) + '/my_data'

#hooks Before/After 
require File.dirname(__FILE__) + '/hooks'

$logger = MyLog.init_log
#$logger.level = Logger::INFO

# Determine environment and root
ROOT = File.dirname(__FILE__) + '/../../'#in the root of /cucumber dir.

MyData.load_test_data "#{ROOT}/", ENV['SELECTED_ENV'].upcase

DEFAULT_PORT = ":#{MyData.env('port')}" if MyData.env_is_not_default_port?
#mac
CHROME_BIN="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
#CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/GoChrome --user-data-dir=/tmp"
#linux (tested on fedora)
#CHROME_BIN="/opt/google/chrome/google-chrome"


#local server running?
if MyData.env('has_local_server')
  #EXIT if local test server is not running
  host = "127.0.0.1"
  res = system "exec 6<>/dev/tcp/#{host}/#{MyData.env('port')}" #returns false if server not running
  if !res
    puts
    puts
    puts "FATAL: Play server not running. Expected http://#{host}:#{MyData.env('port')}"
    puts "Start play test server: 'cdplay && play test --http.port=#{MyData.env('port')}'"
    exit
  end
end

def startup_info
  txt = []
  txt << "Starting up test with the following configuration:"
  txt << MyData.env()
  txt << 
  txt << "versions:"
  txt << "    Capybara    #{Capybara::VERSION}"
  txt << "    Poltergeist #{Capybara::Poltergeist::VERSION}"
  txt << "    Cucumber    #{Cucumber::VERSION}"
  txt << "    Nokogiri    #{Nokogiri::VERSION}"
  return txt
end



# Configure Capybara

Capybara.configure do |config|
  config.app_host          = "#{MyData.env('url')}#{DEFAULT_PORT}"
  config.default_driver    = :poltergeist
  config.javascript_driver = :poltergeist
  config.run_server        = false
  config.default_wait_time = 2 #default is 2 seconds
  config.save_and_open_page_path = "/tmp"

  #smooth update from capybara 1.x to 2.1 see http://www.elabs.se/blog/60-introducing-capybara-2-1
  config.match             = :prefer_exact
  config.ignore_hidden_elements = false

  puts
  puts "ENV['SELECTED_ENV']: " + ENV['SELECTED_ENV']
  puts "Host: \e[0;103m#{config.app_host}\e[00m to change add more profiles into cucumber.yml"
  puts
  puts ""
  $logger.info startup_info
end

def phantom_options
  opts = []
  opts.push '--proxy-type=none' if MyData.env('use_no_proxy') || true
  opts.push '--ignore-ssl-errors=yes'
end



# Configure Poltergeist
Capybara.register_driver :poltergeist do |app|

  Capybara::Poltergeist::Driver.new(app,
    :inspector => CHROME_BIN, # usage (via capybara): page.driver.debug
    :phantomjs_options => phantom_options,
    :debug => ENV['POLTERGEIST_DEBUG'] || false,
    #:timeout => 55,
    :window_size => [1020, 1024]
  )
end



#hack to preserve cookies between tests
After do
  $cookies = page.driver.cookies
  $logger.debug("cookies: #{$cookies.map{|name, c| %(#{name} #{c.value} ) } }")
end


#hack to preserve cookies between tests. Snippet to load cookies after
#poltergeist has reset the browser session and cleared cookies (and before login)
Before do
  if $cookies
    $cookies.each do |name,cookie|
      page.driver.set_cookie(name, cookie.value)
    end
  end
end

