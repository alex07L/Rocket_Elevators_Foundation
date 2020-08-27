require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

RSpec.configure do |config|
	response = {"location":{"name":"Newark","region":"New Jersey","country":"USA","lat":40.71,"lon":-74.21,"tz_id":"America/New_York","localtime_epoch":1597880635,"localtime":"2020-08-19 19:43"},"current":{"last_updated_epoch":1597879807,"last_updated":"2020-08-19 19:30","temp_c":22.8,"temp_f":73,"is_day":1,"condition":{"text":"Sunny","icon":"//cdn.weatherapi.com/weather/64x64/day/113.png","code":1000},"wind_mph":5.6,"wind_kph":9,"wind_degree":110,"wind_dir":"ESE","pressure_mb":1014,"pressure_in":30.4,"precip_mm":0.3,"precip_in":0.01,"humidity":100,"cloud":0,"feelslike_c":24.9,"feelslike_f":76.9,"vis_km":16,"vis_miles":9,"uv":5,"gust_mph":8.1,"gust_kph":13},"forecast":{"forecastday":[{"date":"2020-08-19","date_epoch":1597795200,"day":{"maxtemp_c":24.2,"maxtemp_f":75.6,"mintemp_c":17,"mintemp_f":62.6,"avgtemp_c":22.4,"avgtemp_f":72.3,"maxwind_mph":7.6,"maxwind_kph":12.2,"totalprecip_mm":3.6,"totalprecip_in":0.14,"avgvis_km":9.4,"avgvis_miles":5,"avghumidity":71,"daily_will_it_rain":1,"daily_chance_of_rain":"83","daily_will_it_snow":0,"daily_chance_of_snow":"0","condition":{"text":"Moderate or heavy rain shower","icon":"//cdn.weatherapi.com/weather/64x64/day/356.png","code":1243},"uv":5},"astro":{"sunrise":"06:12 AM","sunset":"07:48 PM","moonrise":"06:30 AM","moonset":"08:36 PM"}}]},"alert":{"headline":"Coastal Flood Statement issued August 19 at 4:31AM EDT until August 19 at 10:00PM EDT by NWS","msgtype":"Alert","severity":"Unknown","urgency":"Unknown","areas":"Southern Nassau; Southern Queens","category":"Met","certainty":"Unknown","event":"Coastal Flood Statement","note":"Alert for Southern Nassau; Southern Queens (New York) Issued by the National Weather Service","effective":"2020-08-19T20:00:00-04:00","expires":"2020-08-19T22:00:00-04:00","desc":"* WHAT...Less than one half foot of inundation above ground level\nexpected in vulnerable areas near the waterfront and shoreline.\n* WHERE...Southern Nassau and Southern Queens Counties.\n* WHEN...This evening.\n* IMPACTS...Brief minor flooding is possible in the most vulnerable\nlocations near the waterfront and shoreline.","instruction":"Do not drive through flooded roadways."}}
  config.before(:each) do
    stub_request(:get, /api.weatherapi.com/).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: response.to_json, headers: {})
  end
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end
  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # This setting enables warnings. It's recommended, but in some cases may
  # be too noisy due to issues in dependencies.
  config.warnings = true

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end