class MyLog < Logger

  class << self
    def init_log
      directory_name = 'test-results'
      Dir::mkdir(directory_name) unless FileTest::directory?(directory_name)
      $logger = Logger.new(directory_name + '/cucumber.log', 'daily')
      $logger.level = Logger::INFO
      $logger.debug "Log file initialized"
      $logger
    end

  end
end
