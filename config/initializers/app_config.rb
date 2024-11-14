# Load application configuration
require 'ostruct'
require 'yaml'
 
app_config = YAML.load_file("#{Rails.root}/config/app_config.yml")
AppConfig = OpenStruct.new(app_config)