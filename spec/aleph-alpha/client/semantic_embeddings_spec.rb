RSpec.describe AlephAlpha::Client do
  describe "#semantic_embeddings", :vcr do
    let(:input) { "An apple a day keeps the doctor away." }
    let(:cassette) { "#{model} semantic_embeddings #{input}".downcase }
    let(:response) do
      AlephAlpha::Client.new.semantic_embeddings(
        parameters: {
          model: model,
          prompt: input,
          representation: "symmetric",
          compress_to_size: 128
        }
      )
    end

    context "with model: luminous-base" do
      let(:model) { "luminous-base" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["model_version"]).to eq("2023-05")
          expect(response["embedding"].length).to eq(128)
        end
      end
    end
  end
end
