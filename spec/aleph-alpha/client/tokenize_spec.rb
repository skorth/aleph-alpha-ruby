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

    context "with model: luminous-base" do
      let(:model) { "luminous-base" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["tokens"]).to eq(["ĠAn", "Ġapple", "Ġa", "Ġday", "Ġkeeps", "Ġthe",
                                            "Ġdoctor", "Ġaway", "."])
          expect(response["token_ids"]).to eq([556, 48_741, 247, 2983, 28_063, 301, 10_510, 5469,
                                               17])
        end
      end
    end
  end
end
