module ResponseState
  class Service

    def self.response_states(*states)
      @valid_states = Array(states)
    end

    def self.valid_states
      @valid_states || [:success, :failure]
    end

    def self.call(*args, &block)
      self.new(*args).call(&block)
    end

    def call(&block)
      fail NotImplementedError, "A ResponseState::Service should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponseState::Response object.\n"
    end

    def send_state(state, message=nil, context=nil)
      ResponseState::Response.new(state, message, context, self.class.valid_states)
    end
  end
end
