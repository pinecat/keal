# frozen_string_literal: true

class Keal
  def daemon?(msg = true)
    unless @options[:force]
      begin
        return @daemon.ping
      rescue DRb::DRbConnError, Errno::ECONNREFUSED
        puts "keal: Please ensure 'keald.service' is running, or use the '-f' option (requires sudo, not recommended)" if msg
        return false
      end
    end
    false
  end
end
