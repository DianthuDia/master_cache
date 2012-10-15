module MasterCache::Generators
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

    desc <<DESC
Description:
  Copies master_cache configuration file to your application's initializer directory.
DESC

    def copy_config_file
      template 'master_cache_config.rb', 'config/initializers/master_cache_config.rb'
    end
  end
end
