# frozen_string_literal: true

require "open3"
require "rbconfig"

RSpec.describe "require \"loc-marc\" (pre-rename entry point)" do
  it "loads lib/loc_marc.rb instead of its own copy" do
    lib = File.expand_path("../../lib", __dir__)
    script = <<~RUBY
      require "loc-marc"
      puts $LOADED_FEATURES.include?(File.join(#{lib.inspect}, "loc_marc.rb"))
      puts defined?(LocMarc::Codes::Country).inspect
    RUBY

    out, status = Open3.capture2(RbConfig.ruby, "-I", lib, "-e", script)

    expect(status).to be_success
    expect(out.lines.map(&:chomp)).to eq ["true", "\"constant\""]
  end
end
