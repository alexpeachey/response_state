module ResponsiveService
  class Responder

    attr_reader :type, :message, :context

    def initialize(type, message=nil, context=nil)
      @type = type
      @context = context
      @message = message
    end

    def method_missing(method, *args, &block)
      yield if method == type
    end
  end
end