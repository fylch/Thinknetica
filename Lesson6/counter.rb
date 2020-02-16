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
      cl = self.class
      cl.instances = cl.instances.to_i + 1
    end
  end
end
