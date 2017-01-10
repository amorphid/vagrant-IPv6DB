require "spec_helper"

describe Vagrant::IPv6DB do

  subject { described_class }

  before { subject.send(:delete_addresses) }
  after  { subject.send(:delete_addresses) }

  it "has a version number" do
    expect(Vagrant::IPv6DB::VERSION).not_to be nil
  end

  context "::find_or_create_address_by_id" do
    it "increases address count by 1" do
      expect { subject.find_or_create_address_by_id(1) }
        .to change { subject.send(:address_count) }
        .from(0)
        .to(1)
    end
  end
end
