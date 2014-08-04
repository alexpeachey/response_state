module ResponseState
  class Response
    attr_reader :state, :message, :context, :valid_states, :called_states

    def initialize(state, message=nil, context=nil, valid_states=nil)
      @valid_states = Array(valid_states || self.class.class_valid_states)
      raise "Invalid state of response: #{state}" unless  @valid_states.include? state
      @state = state
      @context = context
      @message = message
      @called_states = []
    end

    def self.valid_states(*args)
      @class_valid_states = Array(args)
    end

    def self.class_valid_states
      @class_valid_states
    end

    def unhandled_states
      yield uncalled_states unless uncalled_states.empty?
      nil
    end

    def uncalled_states
      valid_states - called_states
    end

    def method_missing(method, *args, &block)
      return super unless valid_state? method
      called_states << method unless called_states.include? method
      yield if method == state
      nil
    end

    private

    def valid_state?(call_state)
      return true if valid_states.include? call_state
      raise "Invalid state: #{call_state}"
    end
  end
end
