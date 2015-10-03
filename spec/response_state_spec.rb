require 'spec_helper'

# An example service that creates a new user.
# Signals its results via a ResponseState.
def create_user param, &block
  result = ResponseState.init(&block)
  if param == 1
    result.success
  elsif param == 2
    result.success
    result.success
  else
    result.failure
  end
end


describe ResponseState do

  it 'calls the state handler for the given response' do
    called = false
    create_user 1 do |result|
      result.success   { called = true }
      result.failure { fail }
    end
    expect(called).to be true
  end

  it 'can call state handlers multiple times' do
    call_count = 0
    create_user 2 do |result|
      result.success   { call_count += 1 }
      result.failure { fail }
    end
    expect(call_count).to eq 2
  end

end
