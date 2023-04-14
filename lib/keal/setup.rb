# frozen_string_literal: true

class Keal
  def setup
    if @options[:force]
      unless @kd.runas(@user, @dbus)
        puts "keal: Daemon cannot switch user contexts"
        exit 1
      end

      @kd.mask(@pid, @options)
      return
    end

    if daemon?
      unless @daemon.runas(@user, @dbus)
        puts "keal: Daemon cannot switch user contexts"
        exit 1
      end

      @daemon.mask(@pid, @options)
    else
      exit 1
    end
  end
end
