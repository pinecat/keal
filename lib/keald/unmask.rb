# frozen_string_literal: true

class KealDaemon
  def unmask(pid)
    info = unmask_targets(pid)
    return if info.nil?
    unmask_idle(info) if info[:idle]
    unmask_lock(info) if info[:lock]
  end

  def unmask_targets(pid)
    return nil unless @procs.has_key? pid

    begin
      @mgr.UnmaskUnitFiles(@targets, false) if @procs.has_one?
    rescue DBus::Error
      puts "keal: Unable to unmask targets, are you running as root?"
      return nil
    end

    info = @procs[pid]
    @procs.delete pid
    info
  end

  def unmask_idle(info)
    return if @procs.idling?
    @gsettings.idle_delay info[:s]
  end

  def unmask_lock(info)
    return if @procs.lock_disabled?
    @gsettings.disable_lock_screen info[:l]
  end
end
