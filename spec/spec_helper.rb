RSpec.configure do |config|
  config.alias_it_should_behave_like_to :behavior_when, 'when'

  config.disable_monkey_patching = true

  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random

  # This allows us to set the random seed with, e.g., --seed 1234
  Kernel.srand config.seed
end
