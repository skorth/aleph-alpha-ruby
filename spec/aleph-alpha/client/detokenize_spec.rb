RSpec.describe AlephAlpha::Client do
  describe "#detokenize", :vcr do
    let(:cassette) { "#{model} detokenize".downcase }
    let(:response) do
      AlephAlpha::Client.new.detokenize(
        parameters: {
          model: model,
          token_ids: [
            556,
            48_741,
            247,
            2983,
            28_063,
            301,
            10_510,
            5469,
            17
          ]
        }
      )
    end

    context "with model: luminous-base" do
      let(:model) { "luminous-base" }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["result"]).to eq(" An apple a day keeps the doctor away.")
        end
      end
    end
  end
end
