class Result

  attr_accessor :status

  def initialize
    @status = :learning
  end


  # Learns about the response states
  # that the caller has subscribed to.
  def self.parse
    result = Result.new
    yield result
    result.status = :frozen
    result
  end


  def method_missing name, *args, &block
    if @status == :learning
      self.class.send(:define_method, name, &block)
    end
  end

end
