$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

ENV["VAGRANT_CWD"] = File.join(Dir.pwd, "spec", "support")

require "vagrant/IPv6DB"
