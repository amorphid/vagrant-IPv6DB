module Vagrant
  module IPv6DB
    module Client
      class << self
        def address_count
          records = connection.execute("SELECT COUNT(id) FROM addresses;")
          record  = records.first
          count   = record.first
          count
        end

        def address_delete_all
          connection.execute("DELETE FROM addresses;")
        end

        def address_insert(id, address)
          connection.execute(
            "INSERT INTO addresses (id, address) values (?,?);",
            [id, address])
        end

        def address_select(id)
          records =
            connection.execute(
              "SELECT address FROM addresses WHERE id = ?;",
              [id])

          if records.empty?
            nil
          else
            record  = records.first
            address = record.first
            address
          end
        end

        private

        def connection
          @connection ||= SQLite3::Database.new(path).tap do |conn|
            conn.execute <<-EOM
              CREATE TABLE IF NOT EXISTS addresses (
                id int PRIMARY KEY,
                address varchar(39) NOT NULL
              );
            EOM
          end
        end

        def path
          File.join(
            ENV.fetch("VAGRANT_CWD"),
            ".vagrant",
            "machines",
            "default",
            "virtualbox",
            "IPv6DB.sqlite3")
            .tap { |file| FileUtils.mkdir_p(File.dirname(file)) }
        end
      end
    end
  end
end
