require "chronic_duration"

module GitReporting
  class MessageParser
    attr_reader :input, :regexp

    def self.parse(*args)
      new(*args).parse
    end

    def initialize(input)
      @input = input.to_s
      prefix = GitReporting.configuration.prefix
      @regexp = /\[\s*#{prefix && prefix + "\s*"}\s*(\d[^\[\]]*)\]/m
    end

    def parse
      message = parse_message
      time = parse_time
      [message, time]
    end

    private

    def parse_message
      input.gsub(regexp, "").strip
    end

    def parse_time
      times = input.scan(regexp)
      time = if times[0]
        times[0][0] # we want to take only first time marker
      else
        nil
      end
      return nil unless time.present?

      time = "#{time}:00" if time =~ /^\d{1,2}:\d{1,2}$/

      ChronicDuration.parse(time, keep_zero: true)
    end
  end
end
