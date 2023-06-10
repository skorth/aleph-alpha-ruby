RSpec.describe AlephAlpha::Client do
  describe "#completions" do
    context "with a prompt and max_tokens", :vcr do
      let(:prompt) { "An apple a day" }
      let(:maximum_tokens) { 12 }

      let(:response) do
        AlephAlpha::Client.new.completions(
          parameters: {
            model: model,
            prompt: prompt,
            maximum_tokens: maximum_tokens
          }
        )
      end
      let(:cassette) { "#{model} completions #{prompt}".downcase }

      context "with model: luminous-base" do
        let(:model) { "luminous-base" }

        it "succeeds" do
          VCR.use_cassette(cassette) do
            expect(response["model_version"]).to eq("2023-05")
            expect(response.dig("completions", 0,
                                "completion")).to eq(" keeps the doctor away, but what about a banana a day")
            expect(response.dig("completions", 0, "finish_reason")).to eq("maximum_tokens")
          end
        end
      end

      context "with model: luminous-extended" do
        let(:model) { "luminous-extended" }

        it "succeeds" do
          VCR.use_cassette(cassette) do
            expect(response["model_version"]).to eq("2023-05")
            expect(response.dig("completions", 0,
                                "completion")).to eq(" keeps the doctor away, but what about the dentist?\n")
            expect(response.dig("completions", 0, "finish_reason")).to eq("maximum_tokens")
          end
        end
      end
    end
  end
end
