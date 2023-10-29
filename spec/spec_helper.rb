require "bundler/setup"
require "dotenv/load"
require "aleph-alpha"
require "vcr"

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.default_cassette_options = {
    record: ENV.fetch("ALEPH_ALPHA_ACCESS_TOKEN", nil) ? :all : :new_episodes,
    match_requests_on: %i[method uri]
  }
  c.filter_sensitive_data("<ALEPH_ALPHA_ACCESS_TOKEN>") { AlephAlpha.configuration.access_token }
  c.before_record do |i|
    i.response.body.force_encoding("UTF-8")
  end
end

RSpec.configure do |c|
  c.filter_run_when_matching :focus

  if ENV.fetch("ALEPH_ALPHA_ACCESS_TOKEN", nil)
    warning = "WARNING! Specs are hitting the Aleph-Alpha API using your ALEPH_ALPHA_ACCESS_TOKEN!.".freeze
    warning = RSpec::Core::Formatters::ConsoleCodes.wrap(warning, :bold_red)

    c.before(:suite) { RSpec.configuration.reporter.message(warning) }
    c.after(:suite) { RSpec.configuration.reporter.message(warning) }
  end

  c.before(:all) do
    AlephAlpha.configure do |config|
      config.access_token = ENV.fetch("ALEPH_ALPHA_ACCESS_TOKEN", "dummy-token")
    end
  end
end

RSPEC_ROOT = File.dirname __FILE__
