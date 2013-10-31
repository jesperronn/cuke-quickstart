#require 'yaml'
# This class loads the data and environment details from a /testdata/<env>.yml file
#
# usage
#   MyData.env('<key>') will retrieve environment details from the "env"-part of the yml file
#
#   MyData.lookup('<key>') will retrieve details from the "testdata"-part of the yml file
#
class MyData
  def self.load_test_data(root, env)
    filename = "#{root}/testdata/#{env}.yml"
    puts "loading data from root: #{filename}"
    @data = YAML::load( File.open(filename))
    puts "data loaded (#{@data.size} items)"
  end

  def self.data
    @data
  end

  def self.lookup(key)
    found = @data['testdata'][key]
    return key unless found
    return found
  end

  def self.env(key = nil)
    return @data['environment'] if key.nil?
    found = @data['environment'][key]
    return '' unless found
    return found
  end

  def self.env_is_not_default_port?
    return env('port') != "80" || env('port') != nil
  end
end
