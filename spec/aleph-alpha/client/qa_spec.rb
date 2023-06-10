RSpec.describe AlephAlpha::Client do
  describe "#qa", :vcr do
    let(:query_text) { "When did wolves first appear?" }
    let(:doc_text) do
      "The gray wolf (Canis lupus) is a species of placental mammal of the carnivore order. The earliest fossil record dates back eight hundred thousand years. Wolves are native to North America and Eurasia, where they were once widely distributed and abundant. Today, they inhabit only a very limited portion of their former territory."
    end
    let(:cassette) { "qa".downcase }
    let(:response) do
      AlephAlpha::Client.new.qa(
        parameters: {
          query: query_text,
          documents: [
            {
              text: doc_text
            }
          ]
        }
      )
    end

    it "succeeds" do
      VCR.use_cassette(cassette) do
        expect(response["model_version"]).to eq("2023-05")
        expect(response.dig("answers", 0,
                            "answer")).to eq("Wolves first appeared eight hundred thousand years ago.")
      end
    end
  end
end
