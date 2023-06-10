RSpec.describe AlephAlpha::Client do
  describe "#embeddings", :vcr do
    let(:input) { "An apple a day keeps the doctor away." }
    let(:cassette) { "#{model} embeddings #{input}".downcase }
    let(:response) do
      AlephAlpha::Client.new.embeddings(
        parameters: {
          model: model,
          prompt: input,
          layers: [
            0,
            1
          ],
          tokens: false,
          pooling: [
            "max"
          ]
        }
      )
    end

    context "with model: luminous-base" do
      let(:model) { "luminous-base" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["model_version"]).to eq("2023-05")
          expect(response.dig("embeddings", "layer_1", "max").length).to eq(5120)
          expect(response.dig("embeddings", "layer_0", "max").length).to eq(5120)
        end
      end
    end
  end
end
