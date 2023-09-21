require 'nokogiri'

CoverageData = Struct.new(:covered_lines, :total_lines)

def parse_coverage_report(report)
  xml_report = Nokogiri::XML(File.read(report)) { |coverage| coverage.noblanks }
  coverage_data = xml_report.at_xpath('//coverage')
  covered_lines = coverage_data["branches-covered"].to_i
  total_lines = coverage_data["branches-valid"].to_i


  CoverageData.new(covered_lines, total_lines)
end
