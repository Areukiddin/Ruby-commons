module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, *args)
      validators = '@validators'
      instance_variable_set(validators, {}) unless instance_variable_defined?(validators)
      instance_variable_get(validators)[name] = *args
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get('@validators').each do |name, args|
        send("validate_#{args[0]}", name, *args[1, args.size])
      end
      true
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def validate_presence(name)
      value = instance_variable_get("@#{name}")
      raise "Value can't be nil or blank" if value.nil? || value.empty?
    end

    def validate_format(name, format)
      value = instance_variable_get("@#{name}")
      raise "Value must match #{format}" unless value =~ format
    end

    def validate_type(name, type)
      var_type = instance_variable_get("@#{name}").to_s
      raise "Value must be instance of #{type}" if var_type != type
    end
  end
end
