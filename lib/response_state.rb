class ResponseState
  attr_accessor :status

  def initialize
    @status = :learning
  end

  def self.init
    ResponseState.new.tap do |result|
      yield result
      result.status = :frozen
    end
  end

  def method_missing name, *args, &block
    if @status == :learning
      (class << self; self; end).class_eval do
        define_method name, &block
      end
    end
  end
end
