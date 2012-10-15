module MasterCache::ModelExtension
  extend ActiveSupport::Concern

  module ClassMethods
    # MasterModel should be called (optional arguments):
    #
    #   master_cache(:const_name => :name, :order_name => :position, :all_name => 'INSTANCES')
    #
    # const_name: const name
    # order_name: 'order' name
    # all_name: cached all instance name
    def master_cache(options = {})
      MasterCache.config.tap do |c|
        options.reverse_merge! :const_name => c.const_name, :order_name => c.order_name, :all_name => c.all_name
      end

      return if const_defined?(options[:all_name]) && const_get(options[:all_name]).present?

      # default order
      default_scope order: options[:order_name]

      # Constantize all instances
      _all = all rescue [] # return [] this before migration
      const_set options[:all_name], _all

      # Constantize each instance
      _all.each do |instance|
        const_name = instance.send(options[:const_name]).to_s.upcase
        next if const_name.empty? || const_defined?(const_name)

        const_set const_name, instance
        send :define_method, "#{const_name.downcase}?" do; self === instance end
      end
    end
  end
end
