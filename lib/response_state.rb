class ResponseState

  # Possible states:
  # :client_registration = the clients of the method using this class
  #                        subscribe to results.
  # :server_result = the method using this class defines its result(s).
  attr_accessor :status


  def self.init
    ResponseState.new.tap do |result|
      yield result
      result.status = :frozen
    end
  end


private

  # Adds a method with the given name and body only to the current instance,
  # not the class itself.
  def define_instance_method name, &block
    (class << self; self; end).class_eval do
      define_method name, &block
    end
  end


  def initialize allowed_states
    @status = :registration
    @allowed_states = allowed_states
  end


  def method_missing name, *args, &block
    verify_is_known_state name
    if @status == :registration
      define_instance_method name, &block
    end
  end


  def verify_is_known_state state
    if @allowed_states && !@allowed_states.include?(state)
      raise "Unknown state: #{state}"
    end
  end

end
