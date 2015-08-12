require "test_helper"

class GitReporting::Report

  describe Type do
    let(:commits) { [mock_commit(author: "john"), mock_commit(author: "jack")] }

    describe Type::Simple do
      it "builds" do
        report = Type::Simple.build(commits)

        report.size.must_equal 1
        report.first.must_be_kind_of Type::Simple
        report.first.children.size.must_equal 2
        report.first.children.first.must_be_kind_of Commit
      end
    end

    describe Type::Timesheet do
      it "builds" do
        report = Type::Timesheet.build(commits)

        report.size.must_equal 2
        report.first.must_be_kind_of Type::Timesheet
        report.first.children.size.must_equal 1
        report.first.children.first.must_be_kind_of Commit
      end
    end
  end

end
