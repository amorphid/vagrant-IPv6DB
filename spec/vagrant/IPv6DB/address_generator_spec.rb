require "spec_helper"

describe Vagrant::IPv6DB::AddressGenerator do

  subject { described_class }

  context "::generate" do
    it "generates an IPv6 address" do
      expect(subject.generate).to match(/fc00(:[0-9a-f]{4}){7}/)
    end
  end
end
