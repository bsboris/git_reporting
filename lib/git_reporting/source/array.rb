module GitReporting
  module Source

    class Array
      attr_reader :commits

      def initialize(commits_array)
        @commits = extract_commits_from_array(commits_array)
        sort_commits!
      end

      def fetch(period)
        commits.select { |commit| period === commit.timestamp }
      end

      def fetch_all
        commits
      end

      private

      def extract_commits_from_array(commits_array)
        commits_array.map { |commit_hash| Commit.new(commit_hash) }
      end

      def sort_commits!
        @commits = @commits.sort_by { |commit| commit.timestamp }
      end
    end

  end
end
