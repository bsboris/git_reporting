module GitReporting
  class Report

    class Commit < Report
      def time
        key.time
      end
    end

  end
end
