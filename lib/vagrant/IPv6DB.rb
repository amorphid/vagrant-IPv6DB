require "fileutils"
require "sqlite3"

require "vagrant/IPv6DB/address_generator"
require "vagrant/IPv6DB/client"
require "vagrant/IPv6DB/version"

module Vagrant
  module IPv6DB
    class << self
      def find_or_create_address_by_id(id)
        record = Vagrant::IPv6DB::Client.address_select(id)

        if record.nil?
          Vagrant::IPv6DB::Client.address_insert(
            id,
            Vagrant::IPv6DB::AddressGenerator.generate)
          Vagrant::IPv6DB::Client.address_select(id)
        else
          record
        end
      end
    end
  end
end
