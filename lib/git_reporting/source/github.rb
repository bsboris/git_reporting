require "octokit"

module GitReporting
  module Source

    class Github
      attr_reader :client, :repo, :branch

      def initialize(options = {})
        if options[:repo]
          @repo = options.delete(:repo)
        else
          raise ArgumentError, "You must specify repo for GitHub source"
        end
        @branch = options.delete(:branch) || :master
        options[:auto_paginate] ||= true
        @client = Octokit::Client.new(options)
      end

      def fetch_all
        extract_commits_from_array client.commits(repo, branch)
      end

      def fetch(period)
        extract_commits_from_array client.commits_between(repo, period.begin, period.end, sha: branch)
      end

      private

      def extract_commits_from_array(commits_array)
        commits_array.map do |data|
          Commit.new sha: data.sha,
                     author: data.author.login,
                     message: data.commit.message,
                     timestamp: data.commit.author.date
        end
      end
    end

  end
end
