RSpec.describe AlephAlpha::Client do
  describe "#version", :vcr do
    let(:cassette) { "version" }
    let(:response) { AlephAlpha::Client.new.version }

    it "succeeds" do
      VCR.use_cassette(cassette) do
        expect(response).to eq("1.13.0")
      end
    end
  end
end
