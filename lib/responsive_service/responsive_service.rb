module ResponsiveService
  class ResponsiveService
    def call(&block)
      yield Responder.new(:unimplemented, "A ResponsiveService should implement the call method.\nThe call method should perform the relevant work of the service and yield a ResponsiveService::Responder object.\n")
    end
  end
end