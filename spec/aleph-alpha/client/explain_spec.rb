RSpec.describe AlephAlpha::Client do
  describe "#explain", :vcr do
    let(:input) { "An apple a day" }
    let(:cassette) { "#{model} explain #{input}".downcase }
    let(:response) do
      AlephAlpha::Client.new.explain(
        parameters: {
          model: model,
          hosting: "aleph-alpha",
          prompt: input,
          target: "string",
          control_factor: 0.1,
          contextual_control_threshold: 0,
          control_log_additive: true,
          postprocessing: "none",
          normalize: false,
          prompt_granularity: {
            type: "token",
            delimiter: "string"
          },
          target_granularity: "complete",
          control_token_overlap: "partial"
        }
      )
    end

    context "with model: luminous-base" do
      let(:model) { "luminous-base" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["model_version"]).to eq("2023-05")
          expect(response.dig("explanations", 0, "target")).to eq("string")
        end
      end
    end
  end
end
