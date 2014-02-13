module ResponsiveService
  class ResponsiveService
    attr_reader :response_factory

    # Deprecated
    alias_method :responder_factory, :response_factory

    def initialize(dependencies={})
      @response_factory = dependencies[:response_factory] || dependencies.fetch(:responder_factory) { Response }
    end

    def call(&block)
      yield response_factory.new(:unimplemented, "A ResponsiveService should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponsiveService::Response object.\n")
    end
  end
end