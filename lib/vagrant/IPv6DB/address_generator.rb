module Vagrant
  module IPv6DB
    module AddressGenerator
      class << self
        def generate
          IPV6_TEMPLATE % seven_random_unsigned_16_bit_numbers
        end

        private

        IPV6_TEMPLATE = "fc00:%04x:%04x:%04x:%04x:%04x:%04x:%04x".freeze
        UNPACK_FORMAT = "nnnnnnn".freeze

        def seven_random_unsigned_16_bit_numbers
          SecureRandom
          .random_bytes(14)
          .unpack(UNPACK_FORMAT)
        end
      end
    end
  end
end
