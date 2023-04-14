# frozen_string_literal: true

require_relative "gsettings"
require_relative "keald/mask"
require_relative "keald/monkey"
require_relative "keald/unmask"
require_relative "keald/user"
require_relative "keald/version"
require_relative "pref"
require "dbus/systemd"
require "drb/drb"

class KealDaemon
  def initialize(options)
    @options = options
    @uri = Preferences::URI
    @targets = ["sleep.target", "suspend.target", "hibernate.target", "hybrid-sleep.target"]
    @procs = {}
    @gsettings = GSettings.new
    @mgr = DBus::Systemd::Manager.new
  end

  def signals
    Signal.trap("SIGINT") { exit 0 }
    Signal.trap("SIGHUP") { exit 0 }
  end

  def ping
    true
  end

  def run
    signals
    DRb.start_service(@uri, self)
    DRb.thread.join
    DRb.stop_service
  end
end
