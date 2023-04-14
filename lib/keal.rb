# frozen_string_literal: true

require_relative "keal/setup"
require_relative "keal/shared"
require_relative "keal/teardown"
require_relative "keal/version"
require_relative "keald"
require_relative "pref"
require "dbus/systemd"
require "drb/drb"
require "etc"

class Keal
  class Error < StandardError; end

  def initialize(options, args)
    @options = options
    @uri = Preferences::URI
    @user = Etc.getlogin
    @dbus = ENV["DBUS_SESSION_BUS_ADDRESS"]
    @pid = Process.pid
    @daemon = DRbObject.new_with_uri(@uri)
    @command = filter args
    @kd = KealDaemon.new({}) if @options[:force]
  end

  def signals
    sig = [:INT, :HUP]
    sig.each do |s|
      Signal.trap s do
        exit 0
      end
    end
  end

  def filter(args)
    args.each do |a|
      args = args.drop(1) if a[0, 1] == "-"
      break unless a[0, 1] == "-"
    end
    args.join(" ") unless args[0].nil?
  end

  def run
    signals
    setup
    (@command ? system(@command) : gets)
  ensure
    teardown
  end
end
