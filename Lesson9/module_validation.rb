# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(name, type, *args)
      @validations ||= []
      @validations << { var: name, type: type, args: args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:var]}")
        send("validate_#{validation[:type]}", value, *validation[:args])
      end
    end

    def validate_presence(value)
      raise 'Введите данные!' if value.nil? || value == ''
    end

    def validate_format(value, args)
      raise 'Неверный формат!' if value !~ args
    end

    def validate_type(value, args)
      raise 'Неверный тип класса!' if value.class != args
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
