require './result'


# An example service that creates a new user.
# Signals its results via a ResponseState.
def create_user params, &block
  result = Result.init(&block)
  if params == 1
    result.success
  elsif params == 2
    result.not_found
  else
    result.missing_data
  end
end
