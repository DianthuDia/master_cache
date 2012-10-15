require "master_cache/version"
require 'master_cache/config'

require 'active_record'

ActiveSupport.on_load(:active_record) do
  require 'master_cache/model_extension'
  ::ActiveRecord::Base.send :include, MasterCache::ModelExtension
end

