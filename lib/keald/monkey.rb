# frozen_string_literal: true

module Monkey
  module Procs
    def has_one?
      length == 1
    end

    def idling?
      each do |k, v|
        if !v[:s].nil?
          return true
        end
      end
      false
    end

    def lock_disabled?
      each do |k, v|
        return v[:l] unless v[:l].nil?
      end
      nil
    end
  end
end

Hash.include Monkey::Procs
