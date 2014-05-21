module ResponseState
  class Service

    def self.call(*args, &block)
      self.new(*args).call(&block)
    end

    def call(&block)
      yield send_state(:unimplemented, "A ResponseState::Service should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponseState::Response object.\n")
    end

    def send_state(state, message=nil, context=nil, valid_states=nil)
      ResponseState::Response.new(state, message, context, valid_states)
    end
  end
end
