RSpec.describe AlephAlpha::Client do
  describe "#permissions", :vcr do
    let(:cassette) { "permissions" }
    let(:response) do
      AlephAlpha::Client.new.permissions(parameters: [])
    end

    it "succeeds" do
      VCR.use_cassette(cassette) do
        expect(response).to eq([])
      end
    end
  end
end
