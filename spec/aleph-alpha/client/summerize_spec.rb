RSpec.describe AlephAlpha::Client do
  describe "#summarize", :vcr do
    let(:cassette) { "#{model} summarize".downcase }
    let(:response) do
      AlephAlpha::Client.new.summarize(
        parameters: {
          model: model,
          document: {
            text: "The gray wolf (Canis lupus) is a species of placental mammal of the carnivore order. The earliest fossil record dates back eight hundred thousand years. Wolves are native to North America and Eurasia, where they were once widely distributed and abundant. Today, they inhabit only a very limited portion of their former territory."
          }
        }
      )
    end

    context "with model: luminous-base" do
      let(:model) { "luminous-base" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["model_version"]).to eq("2022-05")
          expect(response["summary"]).to eq("Wolves are native to North America and Eurasia, where they were once widely distributed and abundant. Today, they inhabit only a very limited portion of their former territory.")
        end
      end
    end
  end
end
