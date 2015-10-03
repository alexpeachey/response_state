# A ResponseState result.
class Result

  # :learning = the caller registers the callbacks to handle the different
  #             result types
  # :frozen = the callee calls the callbacks registered by the caller
  #           to provide a result
  attr_accessor :status

  def initialize
    @status = :learning
  end

  def self.init
    Result.new.tap do |result|
      yield result
      result.status = :frozen
    end
  end

  def method_missing name, *args, &block
    if @status == :learning
      self.class.send(:define_method, name, &block)
    end
  end
end
