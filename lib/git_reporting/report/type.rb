module GitReporting
  class Report

    module Type
      class Base < Report
      end

      class Simple < Base
      end

      class Timesheet < Base
        def self.key_for_commit(commit)
          commit.author
        end
      end
    end

  end
end
