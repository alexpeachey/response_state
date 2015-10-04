class ResponseState
  attr_accessor :status


  def self.init
    ResponseState.new.tap do |result|
      yield result
      result.status = :frozen
    end
  end


  def method_missing name, *args, &block
    if @status == :registration
      define_instance_method name, &block
    end
  end


private

  def initialize allowed_states
    @status = :registration
    @allowed_states = allowed_states
  end


  # Adds a method with the given name and body only to the current instance,
  # not the class itself.
  def define_instance_method name, &block
    (class << self; self; end).class_eval do
      define_method name, &block
    end
  end

end
