require "spec_helper"

describe Vagrant::IPv6DB::Client do

  subject { described_class }

  let(:address) { Vagrant::IPv6DB::AddressGenerator.generate }

  before { subject.address_delete_all }
  after  { subject.address_delete_all }

  context "::address_count" do
    it "returns an integer" do
      expect(subject.address_count).to be_an(Integer)
    end
  end

  context "::address_delete_all" do
    before do
      subject.address_insert(1, Vagrant::IPv6DB::AddressGenerator.generate)
      subject.address_insert(2, Vagrant::IPv6DB::AddressGenerator.generate)
    end

    it "deletes all addresses" do
      expect { subject.address_delete_all }
        .to change { subject.address_count }
        .from(2)
        .to(0)
    end
  end

  context "::address_insert" do
    it "creates an address" do
      expect { subject.address_insert(1, address) }
        .to change { subject.address_count }
        .from(0)
        .to(1)
    end
  end

  context "::address_select" do
    let(:id)      { rand(1..1000000) }
    let(:address) { Vagrant::IPv6DB::AddressGenerator.generate }

    it "returns address for existing record" do
      subject.address_insert(id, address)
      expect(subject.address_select(id)).to eq(address)
    end

    it "returns nil for non-existent record" do
      expect(subject.address_select(id)).to eq(nil)
    end
  end
end
