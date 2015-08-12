require "git_reporting/source/array"
require "git_reporting/source/github"

module GitReporting
  module Source
    def self.from_options(options = {})
      source = options.delete(:source)
      const_get(source.to_s.capitalize).new(options)
    end
  end
end
