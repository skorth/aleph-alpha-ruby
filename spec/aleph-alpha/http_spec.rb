RSpec.describe AlephAlpha::HTTP do
  describe "with an aggressive timeout" do
    let(:timeout_errors) { [Faraday::ConnectionFailed, Faraday::TimeoutError] }
    let(:timeout) { 0 }

    # We disable VCR and WebMock for timeout specs, otherwise VCR will return instant
    # responses when using the recorded responses and the specs will fail incorrectly.
    before do
      VCR.turn_off!
      WebMock.allow_net_connect!
      AlephAlpha.configuration.request_timeout = timeout
    end

    after do
      VCR.turn_on!
      WebMock.disable_net_connect!
      AlephAlpha.configuration.request_timeout = AlephAlpha::Configuration::DEFAULT_REQUEST_TIMEOUT
    end

    describe ".get" do
      let(:response) { AlephAlpha::Client.new.models.list }

      it "times out" do
        expect { response }.to raise_error do |error|
          expect(timeout_errors).to include(error.class)
        end
      end
    end

    describe ".json_post" do
      let(:response) do
        AlephAlpha::Client.new.completions(
          parameters: {
            model: "luminous-base",
            prompt: "An apple a day",
            maximum_tokens: 64
          }
        )
      end

      it "times out" do
        expect { response }.to raise_error do |error|
          expect(timeout_errors).to include(error.class)
        end
      end
    end

    describe ".delete" do
      let(:response) do
        AlephAlpha::Client.new.tokens.delete(id: "123")
      end

      it "times out" do
        expect { response }.to raise_error do |error|
          expect(timeout_errors).to include(error.class)
        end
      end
    end
  end
end
