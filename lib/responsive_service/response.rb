module ResponsiveService
  class Response
    attr_reader :type, :message, :context, :valid_states

    def initialize(type, message=nil, context=nil, valid_states=nil)
      @valid_states = Array(valid_states || self.class.class_valid_states)
      raise "Invalid type of response: #{type}" unless (@valid_states.empty? || @valid_states.include?(type))
      @type = type
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
      if valid_states.empty? || valid_states.include?(method)
        yield if method == type
      else
        super
      end
    end
  end

  Responder = Response
end