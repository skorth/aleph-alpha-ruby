require "bundler/setup"
require "dotenv/load"
require "aleph-alpha"
require "vcr"

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.default_cassette_options = {
    record: ENV.fetch("ALEPHALPHA_ACCESS_TOKEN", nil) ? :all : :new_episodes,
    match_requests_on: %i[method uri]
  }
  c.filter_sensitive_data("<ALEPHALPHA_ACCESS_TOKEN>") { AlephAlpha.configuration.access_token }
end

RSpec.configure do |c|
  c.filter_run_when_matching :focus

  if ENV.fetch("ALEPHALPHA_ACCESS_TOKEN", nil)
    warning = "WARNING! Specs are hitting the Aleph-Alpha API using your ALEPHALPHA_ACCESS_TOKEN!.".freeze
    warning = RSpec::Core::Formatters::ConsoleCodes.wrap(warning, :bold_red)

    c.before(:suite) { RSpec.configuration.reporter.message(warning) }
    c.after(:suite) { RSpec.configuration.reporter.message(warning) }
  end

  c.before(:all) do
    AlephAlpha.configure do |config|
      config.access_token = ENV.fetch("ALEPHALPHA_ACCESS_TOKEN", "dummy-token")
    end
  end
end

RSPEC_ROOT = File.dirname __FILE__
