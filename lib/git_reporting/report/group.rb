module GitReporting
  class Report

    module Group
      class Base < Report
      end

      class None < Base
      end

      class Day < Base
        def self.key_for_commit(commit)
          commit.timestamp.to_date
        end
      end

      class Week < Base
        def self.key_for_commit(commit)
          commit.timestamp.beginning_of_week
        end
      end

      class Month < Base
        def self.key_for_commit(commit)
          commit.timestamp.beginning_of_month
        end
      end

      class Year < Base
        def self.key_for_commit(commit)
          commit.timestamp.beginning_of_year
        end
      end
    end

  end
end
