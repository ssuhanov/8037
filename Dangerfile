ignored_change_files = [".png",".jpg",".jpeg",".pdf",".svg",".xcassets",".lock",".json"]

lineChanges = 0
git.diff.stats[:files].each do |file, stats|
  if ignored_change_files.any? { |path| file.include?(path) }
    puts "Ignoring file for Big PR calculation #{file}"
  else
    lineChanges += stats[:insertions] + stats[:deletions]
  end
end

# Fail or warn when there is a big PR
if lineChanges > 500
  fail "Big PR, split it into smaller ones"
elsif lineChanges > 250
  warn "Big PR, consider splitting into smaller ones"
end

# Linting all Swift files
swiftlint.lint_all_files = true
swiftlint.lint_files inline_mode: true
swiftlint.lint_files fail_on_error: true

# Milestones are required to track what's included in each release
fail('This PR does not have a milestone.', sticky: false) unless !github.pr_json['milestone'].nil?

# ensure that all prs has assignees
warn "This PR does not have any assignees." unless github.pr_json["assignee"]
