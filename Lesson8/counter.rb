# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_accessor :instances

    @instances = 0
  end

  module InstanceMethods
    protected

    def register_instances
      cl = self.class # didn't work with single line
      cl.instances = cl.instances.to_i + 1
    end
  end
end
