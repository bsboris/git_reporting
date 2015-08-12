# GitReporting

[![Code Climate](https://codeclimate.com/github/bsboris/git_reporting/badges/gpa.svg)](https://codeclimate.com/github/bsboris/git_reporting)

    reporter = GitReporting::Reporter.new(source: :github, login: "...", password: "...", repo: "my/repo")

    reporter.build_report #=> simple report for all time
    reporter.build_report(type: :timesheet) #=> report per user for all time
    reporter.build_report(type: :timesheet, from: "2015-01-01", to: "2015-01-31") #=> report per user for given period
    reporter.build_report(type: :timesheet, group: :week, from: "2015-01-01", to: "2015-01-31") #=> report per user for given period groupped by week

More docs are coming.
