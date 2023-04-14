# frozen_string_literal: true

require "etc"

class KealDaemon
  def runas(user, dbus)
    u = Etc.getpwnam user
    @gsettings.environment(u.uid, u.dir, dbus)
  end
end
