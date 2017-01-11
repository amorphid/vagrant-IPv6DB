require "vagrant/IPv6DB/address_generator"
require "vagrant/IPv6DB/version"

module Vagrant
  module IPv6DB
    class << self
      def find_or_create_address_by_id(id)
        create_address
      end

      private

      def addresses
        @addresses ||= []
      end

      def address_count
        addresses.count
      end

      def create_address
        addresses << Vagrant::IPv6DB::AddressGenerator.generate
      end

      def delete_addresses
        @addresses = []
      end
    end
  end
end
