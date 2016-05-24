require 'api_m8'
require 'yaml'
require 'erb'

_api_m8_config_file = Pathname(File.join(Rails.root, 'config', 'api_m8.yml'))
if _api_m8_config_file.exist?
  yml_config = YAML.load(ERB.new(_api_m8_config_file.read).result)[Rails.env]
  ApiM8::Connection.configure do |config|
    yml_config.each{|k,v| config.send("#{k}=", v)}
  end
end
ApiM8.log = Rails.logger
RestClient.log = Rails.logger