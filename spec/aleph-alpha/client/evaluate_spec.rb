RSpec.describe AlephAlpha::Client do
  describe "#evaluate", :vcr do
    let(:input) { "An apple a day" }
    let(:cassette) { "#{model} evaluate #{input}".downcase }
    let(:response) do
      AlephAlpha::Client.new.evaluate(
        parameters: {
          model: model,
          prompt: input,
          completion_expected: "keeps the doctor away."
        }
      )
    end

    context "with model: luminous-base" do
      let(:model) { "luminous-base" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["model_version"]).to eq("2022-04")
          expect(response.dig("result", "completion")).to eq(" keepseps the doctor away.")
        end
      end
    end
  end
end
