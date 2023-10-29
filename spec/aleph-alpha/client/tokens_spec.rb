RSpec.describe AlephAlpha::Client do
  describe "#tokens", :vcr do
    describe "#list" do
      let(:cassette) { "tokens list" }
      let(:response) { AlephAlpha::Client.new.tokens.list }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response[0].keys).to eq(%w[token_id description])
        end
      end
    end

    describe "#create" do
      let(:cassette) { "tokens create" }
      let(:response) do
        VCR.use_cassette(cassette) do
          AlephAlpha::Client.new.tokens.create(
            parameters: {
              description: "token used on my laptop"
            }
          )
        end
      end

      it "succeeds" do
        expect(response.dig("metadata", "description")).to eq("token used on my laptop")
        expect(response["token"]).to eq("SomeToken")
      end
    end

    describe "#delete" do
      let(:cassette) { "tokens delete" }
      let(:response) { AlephAlpha::Client.new.tokens.delete(id: 123) }

      it "returns an error" do
        VCR.use_cassette(cassette) do
          expect(response["error"]).to include("The API token you specified was not found")
        end
      end
    end
  end
end
