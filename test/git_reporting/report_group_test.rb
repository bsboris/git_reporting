require "test_helper"

class GitReporting::Report

  describe Group do
    describe Group::None do
      let(:commits) { [mock_commit, mock_commit] }

      it "builds" do
        report = Group::None.build(commits) do |group_commits|
          Type::Simple.build(group_commits)
        end

        report.must_be_kind_of Array
        report.size.must_equal 1
        report.first.must_be_kind_of Group::None
        report.first.children.size.must_equal 1
        report.first.children.first.must_be_kind_of Type::Simple
      end
    end

    describe Group::Day do
      let(:commits) { [mock_commit(timestamp: DateTime.parse("11 Aug 2015")), mock_commit(timestamp: DateTime.parse("12 Aug 2015"))] }

      it "builds" do
        report = Group::Day.build(commits) do |group_commits|
          Type::Simple.build(group_commits)
        end

        report.must_be_kind_of Array
        report.size.must_equal 2
        report.first.must_be_kind_of Group::Day
        report.first.children.size.must_equal 1
        report.first.children.first.must_be_kind_of Type::Simple
      end
    end

    describe Group::Week do
      let(:commits) { [mock_commit(timestamp: DateTime.parse("11 Aug 2015")), mock_commit(timestamp: DateTime.parse("20 Aug 2015"))] }

      it "builds" do
        report = Group::Week.build(commits) do |group_commits|
          Type::Simple.build(group_commits)
        end

        report.must_be_kind_of Array
        report.size.must_equal 2
        report.first.must_be_kind_of Group::Week
        report.first.children.size.must_equal 1
        report.first.children.first.must_be_kind_of Type::Simple
      end
    end
  end

end
