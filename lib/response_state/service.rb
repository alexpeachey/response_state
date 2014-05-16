module ResponseState
  class Service

    def self.call(*args, &block)
      self.new(*args).call(&block)
    end

    def call(&block)
      yield Response.new(:unimplemented, "A ResponseState::Service should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponseState::Response object.\n")
    end
  end
end