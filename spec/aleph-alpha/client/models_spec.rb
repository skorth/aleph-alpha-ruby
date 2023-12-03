RSpec.describe AlephAlpha::Client do
  describe "#models" do
    describe "#list", :vcr do
      let(:response) { AlephAlpha::Client.new.models.list }
      let(:cassette) { "models list" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response.length).to eq(6)
          expect(response.first).to eq(
            {
              "name" => "luminous-base-control",
              "description" => "A variant of the Luminous-base model that is optimized for downstream task performance",
              "max_context_size" => 2048,
              "hostings" => ["aleph-alpha"],
              "image_support" => false,
              "qa_support" => false,
              "summarization_support" => false,
              "embedding_types" => ["symmetric_128", "asymmetric_128_document", "asymmetric_128_query", "symmetric", "asymmetric_document", "asymmetric_query"],
              "maximum_completion_tokens" => nil
            }
          )
        end
      end
    end
  end
end
