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
if lineChanges > 600
  fail "Big PR, split it into smaller ones"
elsif lineChanges > 400
  warn "Big PR, consider splitting into smaller ones"
end

# Milestones are required to track what's included in each release
fail('All pull requests should have a milestone attached.', sticky: false) unless !github.pr_json['milestone'].nil?

# ensure that all prs has assignees
warn "This PR does not have any assignees yet." unless github.pr_json["assignee"]
