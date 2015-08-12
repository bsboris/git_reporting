require "test_helper"

module GitReporting::Source

  describe Array do
    subject { Array.new(raw_source) }
    let(:raw_source) { 10.times.map { fake_commit_attributes } }

    it "accepts array of hashes as input" do
      subject.fetch_all.size.must_equal raw_source.size
    end

    it "converts hash to Commit" do
      subject.fetch_all.first.class.must_equal ::GitReporting::Commit
    end

    describe "#fetch_all" do
      it "sorts commits" do
        commits = subject.fetch_all
        (commits.first.timestamp < commits.last.timestamp).must_equal true
      end
    end

    describe "#fetch" do
      let(:raw_source) { 10.times.map { |i| fake_commit_attributes(timestamp: DateTime.new(2015, 8, i + 1)) } }

      it "fetches commits for period" do
        commits = subject.fetch(Date.new(2015, 8, 3)..Date.new(2015, 8, 6))

        commits.first.timestamp.must_equal Date.new(2015, 8, 3)
        commits.last.timestamp.must_equal Date.new(2015, 8, 6)
      end
    end
  end

end
