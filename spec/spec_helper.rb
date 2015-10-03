require 'rspec'
require 'response_state'

RSpec.configure do |config|
  config.mock_with :rspec
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
