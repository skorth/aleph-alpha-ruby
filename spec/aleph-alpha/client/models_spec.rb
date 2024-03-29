RSpec.describe AlephAlpha::Client do
  describe "#models" do
    describe "#list", :vcr do
      let(:response) { AlephAlpha::Client.new.models.list }
      let(:cassette) { "models list" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response.length).to eq(12)
          expect(response.first).to eq(
            {
              "name" => "luminous-extended-control-20240215",
              "description" => "Version 20240215 of the control fine-tuning for luminous-base",
              "max_context_size" => 2048,
              "hostings" => ["aleph-alpha"],
              "image_support" => false,
              "qa_support" => false,
              "summarization_support" => false,
              "embedding_types" => [],
              "maximum_completion_tokens" => nil
            }
          )
        end
      end
    end
  end
end
