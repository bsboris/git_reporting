require "git_reporting/message_parser"

module GitReporting

  class Commit
    attr_accessor :sha, :author, :message, :time, :timestamp

    def initialize(attrs = {})
      @time = 0
      attrs.each do |key, value|
        send "#{key}=", value
      end
    end

    def message=(value)
      parsed = MessageParser.parse(value)
      @message = parsed.first
      @time = parsed.last if parsed.last.present?
    end

    def to_s
      "Commit #{sha}"
    end
  end

end
