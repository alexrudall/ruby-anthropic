RSpec.describe Anthropic::Client do
  context "when using beta APIs" do
    let(:client) { Anthropic::Client.new.beta("message-batches-2024-09-24") }

    it "sends the appropriate header value" do
      expect(client.send(:headers)["anthropic-beta"]).to eq "message-batches-2024-09-24"
    end

    context "when chaining multiple betas" do
      let(:client) { Anthropic::Client.new.beta("feature1").beta("feature2") }

      it "maintains both beta values" do
        expect(client.send(:headers)["anthropic-beta"]).to eq "feature1,feature2"
      end
    end

    context "when using comma-separated betas" do
      let(:client) { Anthropic::Client.new.beta("feature1,feature2") }

      it "sends the combined header value" do
        expect(client.send(:headers)["anthropic-beta"]).to eq "feature1,feature2"
      end
    end
  end

  describe "per-client URL configuration" do
    it "uses the client-specific URI base and API version" do
      client = Anthropic::Client.new(
        uri_base: "https://example.test/",
        api_version: "v2"
      )

      expect(client.send(:uri, path: "/messages")).to eq("https://example.test/v2/messages")
    end
  end
end
