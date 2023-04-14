# frozen_string_literal: true

require "timeout"

RSpec.describe Keal do
  it "has a version number" do
    expect(Keal::VERSION).not_to be nil
  end

  keald = KealDaemon.new({})
  thread = Thread.new do
    keald.run
  end
  Timeout.timeout(10) { thread.join(0.1) until keald.ping }

  it "connects to the daemon" do
    k = Keal.new({}, [])
    expect(k.daemon?).to be true
  end

  it "parses commands" do
    k = Keal.new({}, [])
    expect(k.filter(["-i", "-l", "sleep", "20"])).to eq("sleep 20")
  end
end
