require "active_support"
require "active_support/core_ext"
require "git_reporting/version"
require "git_reporting/commit"
require "git_reporting/report"
require "git_reporting/source"

module GitReporting
  def self.configure
    yield(configuration) if block_given?
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration!
    @configuration = Configuration.new
  end

  class Configuration
    attr_accessor :prefix

    def initialize
      @prefix = nil
    end
  end

  class Reporter
    attr_reader :source

    def initialize(source_options)
      @source = case source_options
      when Source then source_options
      when Array then Source::Array.new(source_options)
      when Hash then Source.from_options(source_options)
      else
        raise ArgumentError, "You should initialize GitReporting::Reporter with array, hash of source options or GitReporting::Source instance."
      end
    end

    def build_report(options = {})
      type = options[:type] || :simple
      group = options[:group] || :none
      from_time = options[:from].present? ? parse_time(options[:from]) : Time.at(0)
      to_time = options[:to].present? ? parse_time(options[:to]) : Time.current

      commits = source.fetch(from_time..to_time)

      root = Report.new("Report")
      root << Report::Group.const_get(group.to_s.capitalize).build(commits) do |group_commits|
        Report::Type.const_get(type.to_s.capitalize).build(group_commits)
      end
    end

    private

    def parse_time(time)
      DateTime.parse(time.to_s)
    rescue ArgumentError
      raise ArgumentError, "#{time} is not a valid date"
    end
  end
end
