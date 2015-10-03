require './result'


class UserService

  # Creates a new user.
  # Returns a Result
  def self.create params, &block
    result = Result.parse(&block)
    if params == 1
      result.success
    elsif params == 2
      result.not_found
    else
      result.missing_data
    end
  end
end
