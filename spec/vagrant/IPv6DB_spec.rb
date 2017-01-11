require "spec_helper"

describe Vagrant::IPv6DB do

  subject { described_class }

  before { Vagrant::IPv6DB::Client.address_delete_all }
  after  { Vagrant::IPv6DB::Client.address_delete_all }

  it "has a version number" do
    expect(Vagrant::IPv6DB::VERSION).not_to be nil
  end

  context "::find_or_create_address_by_id" do
    let(:id)      { rand(1..1000000) }
    let(:address) { Vagrant::IPv6DB::AddressGenerator.generate }

    it "returns an IPv6 address" do
      Vagrant::IPv6DB::Client.address_insert(id, address)
      expect(subject.find_or_create_address_by_id(id))
        .to match(/fc00(:[0-9a-f]{4}){7}/)
    end

    it "increases address count by 1 for non-existent record" do
      expect { subject.find_or_create_address_by_id(id) }
        .to change { Vagrant::IPv6DB::Client.address_count }
        .from(0)
        .to(1)
    end

    it "does not change address count for existing record" do
      Vagrant::IPv6DB::Client.address_insert(id, address)
      expect { subject.find_or_create_address_by_id(id) }
        .not_to change { Vagrant::IPv6DB::Client.address_count }
    end
  end
end
