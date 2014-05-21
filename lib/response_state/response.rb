module ResponseState
  class Response
    attr_reader :state, :message, :context, :valid_states

    def initialize(state, message=nil, context=nil, valid_states=nil)
      @valid_states = Array(valid_states || self.class.class_valid_states)
      raise "Invalid state of response: #{state}" unless (@valid_states.empty? || @valid_states.include?(state))
      @state = state
      @context = context
      @message = message
    end

    def self.valid_states(*args)
      @class_valid_states = Array(args)
    end

    def self.class_valid_states
      @class_valid_states
    end

    def method_missing(method, *args, &block)
      if validate_state?(method)
        yield if method == state
      else
        super
      end
    end

    private

    def validate_state?(call_state)
      return true if valid_states.empty?
      return true if valid_states.include?(call_state)
      raise "Invalid state: #{call_state}"
    end
  end
end
