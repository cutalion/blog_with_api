RSpec.configure do |c|
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
  c.expose_current_running_example_as :example
  c.infer_spec_type_from_file_location!
end
