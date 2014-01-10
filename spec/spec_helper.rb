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
require 'responsive_service'

RSpec.configure do |config|
  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
