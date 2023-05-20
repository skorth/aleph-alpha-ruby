RSpec.describe AlephAlpha do
  it "has a version number" do
    expect(AlephAlpha::VERSION).not_to be nil
  end

  describe "#configure" do
    let(:access_token) { "Token123" }
    let(:api_version) { "1.12" }
    let(:custom_uri_base) { "" }
    let(:custom_request_timeout) { 25 }

    before do
      AlephAlpha.configure do |config|
        config.access_token = access_token
      end
    end

    it "returns the config" do
      expect(AlephAlpha.configuration.access_token).to eq(access_token)
      expect(AlephAlpha.configuration.uri_base).to eq("https://api.aleph-alpha.com")
      expect(AlephAlpha.configuration.request_timeout).to eq(120)
    end

    context "without an access token" do
      let(:access_token) { nil }

      it "raises an error" do
        expect { AlephAlpha::Client.new.completions }.to raise_error(AlephAlpha::ConfigurationError)
      end
    end

    context "with custom timeout and uri base" do
      before do
        AlephAlpha.configure do |config|
          config.uri_base = custom_uri_base
          config.request_timeout = custom_request_timeout
        end
      end

      it "returns the config" do
        expect(AlephAlpha.configuration.access_token).to eq(access_token)
        expect(AlephAlpha.configuration.uri_base).to eq(custom_uri_base)
        expect(AlephAlpha.configuration.request_timeout).to eq(custom_request_timeout)
      end
    end
  end
end
