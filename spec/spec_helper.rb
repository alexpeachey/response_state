require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

SimpleCov.start do
  command_name     'spec'
  add_filter       'config/'
  add_filter       'spec'
  add_filter       '.bundle'
  minimum_coverage 100
end


require 'rspec'
require 'response_state'

RSpec.configure do |config|
  config.mock_with :rspec
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
