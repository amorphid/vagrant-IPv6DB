require "vagrant/IPv6DB/version"

module Vagrant
  module IPv6DB
    class << self
      def find_or_create_address_by_id(id)
        create_address
      end

      private

      def address_count
        @address_count ||= 0
      end

      def create_address
        @address_count += 1
      end

      def delete_addresses
        @address_count = 0
      end
    end
  end
end
