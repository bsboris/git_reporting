require "test_helper"

module GitReporting

  describe Report do
    subject { Report.new }

    it "has children" do
      subject.children.must_be_kind_of Array
    end

    it "adds child" do
      subject << Report.new

      subject.children.size.must_equal 1
    end

    it "adds children" do
      subject << [Report.new, Report.new]

      subject.children.size.must_equal 2
    end

    it "doesnt add nil as a child" do
      proc { subject << nil }.must_raise ArgumentError
    end

    it "doesnt add self as a child" do
      proc { subject << subject }.must_raise ArgumentError
    end

    it "doesnt add not Report object as a child" do
      proc { subject << Object.new }.must_raise ArgumentError
    end

    it "chains children assignment" do
      subject << Report.new << Report.new << Report.new

      subject.children.size.must_equal 3
    end

    it "calculates time" do
      subject << (Report.new << Report::Commit.new(mock_commit(time: 45)) << Report::Commit.new(mock_commit(time: 15)))

      subject.time.must_equal 60
    end

    it "can be created from collection" do
      array = [nil] * 5

      Report.new_from_collection(array).size.must_equal 5
      Report.new_from_collection(array).first.key.must_equal nil
    end

    it "checks input when creating from collection" do
      proc { Report.new_from_collection(nil) }.must_raise ArgumentError
    end
  end

end
