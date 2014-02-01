module ResponsiveService
  class ResponsiveService
    attr_reader :responder_factory

    def initialize(dependencies={})
      @responder_factory = dependencies.fetch(:responder_factory, Responder)
    end

    def call(&block)
      yield responder_factory.new(:unimplemented, "A ResponsiveService should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponsiveService::Responder object.\n")
    end
  end
end