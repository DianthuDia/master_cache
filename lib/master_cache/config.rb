require 'active_support/configurable'

module MasterCache
  # Configures global settings for MasterCache
  #   MasterCache.configure do |config|
  #     config.all_name = :instances
  #   end
  def self.configure(&block)
    yield @config ||= MasterCache::Configuration.new
  end

  # Global settings for MasterCache
  def self.config
    @config
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :all_name
    config_accessor :const_name
    config_accessor :order_name

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer (copied from AS::Configurable)
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line
  end

  # default
  configure do |config|
    config.all_name = 'INSTANCES'
    config.const_name = :name
    config.order_name = :position
  end
end

