# frozen_string_literal: true

class Keal
  def teardown
    if @options[:force]
      @kd.runas(@user, @dbus)
      @kd.unmask(@pid)
      return
    end

    if daemon? false
      @daemon.runas(@user, @dbus)
      @daemon.unmask(@pid)
    else
      exit 1
    end
  end
end
