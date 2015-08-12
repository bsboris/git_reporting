require "git_reporting/report/commit"
require "git_reporting/report/type"
require "git_reporting/report/group"

module GitReporting
  class Report
    attr_reader :key, :children

    def self.new_from_collection(collection)
      raise ArgumentError, "#{collection.inspect} is not a collection" unless collection.respond_to?(:each)

      collection.map { |item| new(item) }
    end

    def self.build(commits)
      hash = Hash.new { |h, k| h[k] = [] }
      commits.each { |commit| hash[key_for_commit(commit)] << commit }
      hash.map do |key, commits|
        new(key) << (block_given? ? yield(commits) : Commit.new_from_collection(commits))
      end
    end

    def self.key_for_commit(commit)
      nil
    end

    def initialize(key = nil)
      @key = key
      @children = []
    end

    def append_child(child)
      if child.respond_to?(:each)
        child.each { |c| self.append_child(c) }
      else
        raise ArgumentError, "Attempting to add a nil node" unless child
        raise ArgumentError, "Only Report and its descendants can be added as a children" unless child.is_a?(Report)
        raise ArgumentError, "Attempting add node to itself" if self.equal?(child)

        children << child
      end
      self
    end
    alias << append_child

    def time
      @time ||= children.inject(0) { |time, child| time + child.time }
    end

    def to_s
      "#{self.class.name} : #{key} : #{time}"
    end

    def print
      puts to_s
      children.each do |child|
        child.print
      end
    end
  end
end
