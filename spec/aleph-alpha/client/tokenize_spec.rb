RSpec.describe AlephAlpha::Client do
  describe "#tokenize", :vcr do
    let(:input) { "An apple a day keeps the doctor away." }
    let(:cassette) { "#{model} tokenize #{input}".downcase }
    let(:response) do
      AlephAlpha::Client.new.tokenize(
        parameters: {
          model: model,
          prompt: input,
          tokens: true,
          token_ids: true
        }
      )
    end

    before { skip("Temporarily disabled") }

    context "with model: luminous-base" do
      let(:model) { "luminous-base" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["model_version"]).to eq("2023-04")
        end
      end
    end
  end
end
