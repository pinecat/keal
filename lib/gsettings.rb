# frozen_string_literal: true

require_relative "gsettings/version"

class GSettings
  def idle_delay(s = nil)
    return get_idle_delay if s.nil?
    set_idle_delay(s)
  end

  def disable_lock_screen(l = nil)
    return get_lock_screen if l.nil?
    set_lock_screen(l)
  end

  def environment(uid, home, dbus)
    set_environment(uid, home, dbus)
  end
end

require "gsettings/gsettings"
