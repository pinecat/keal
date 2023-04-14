# frozen_string_literal: true

class KealDaemon
  def mask(pid, info)
    mask_targets(pid, info)
    mask_idle(info) if info[:idle]
    mask_lock(info) if info[:lock]
  end

  def mask_targets(pid, info)
    return false if @procs.has_key? pid

    begin
      @mgr.MaskUnitFiles(@targets, false, false) if @procs.empty?
    rescue DBus::Error
      puts "keal: Unable to mask targets, are you running as root?"
      exit 1 if info[:force]
      return false
    end

    @procs[pid] = info
    true
  end

  def mask_idle(info)
    return if @procs.idling?
    info[:s] = @gsettings.idle_delay
    @gsettings.idle_delay 0
  end

  def mask_lock(info)
    info[:l] = @procs.lock_disabled?
    return unless info[:l].nil?
    info[:l] = @gsettings.disable_lock_screen
    @gsettings.disable_lock_screen true
  end
end
