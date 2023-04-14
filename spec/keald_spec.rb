# frozen_string_literal: true

require "drb/drb"

RSpec.describe KealDaemon do
  it "has a version number" do
    expect(KealDaemon::VERSION).not_to be nil
  end

  it "listens for dRuby connections" do
    keald = KealDaemon.new({})
    pid = Process.fork do
      keald.run
    end

    daemon = DRbObject.new_with_uri("druby://127.0.0.1:75656")
    expect(daemon.ping).to be true

    Process.kill(9, pid)
  end
end
