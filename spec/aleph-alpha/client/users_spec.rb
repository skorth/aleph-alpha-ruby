RSpec.describe AlephAlpha::Client do
  describe "#users", :vcr do
    describe "#me" do
      let(:cassette) { "users me" }
      let(:response) { AlephAlpha::Client.new.users.me }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response).to have_key("id")
          expect(response).to have_key("email")
          expect(response).to have_key("role")
        end
      end
    end

    describe "#usage" do
      let(:cassette) { "users usage" }
      let(:response) { AlephAlpha::Client.new.users.usage }

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response.first).to have_key("create_timestamp")
        end
      end
    end

    describe "#settings" do
      let(:cassette) { "users settings" }
      let(:response) do
        AlephAlpha::Client.new.users.settings(
          parameters: {
            out_of_credits_threshold: 0
          }
        )
      end

      it "succeeds" do
        VCR.use_cassette(cassette) do
          expect(response["out_of_credits_threshold"]).to eq("0")
          expect(response).to have_key("id")
          expect(response).to have_key("email")
        end
      end
    end
  end
end
