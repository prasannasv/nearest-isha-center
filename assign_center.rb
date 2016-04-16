#!/usr/bin/ruby

# From a csv input in the format of zip1, zip2, distance that is sorted by distance in ascending order
# outputs another csv that has zipcode, center_zip where zipcode is one of zip1 and zip2 and center_zip
# is the zipcode among zip1 and zip2 that is actually a Sathsang Centers' zipcode.
#
# The list of zipcodes that represent a Sathsang Center is also provided as input.
#
# Author: Prasanna (to dot srini at gmail dot com)
# Last Updated: 15 Oct 2015

require 'set'

center_zips_file = ARGV[0]
center_zip_sorted_distances = ARGV[1]

center_zips_set = Set.new
File.open(center_zips_file, "r") do |f|
  f.each_line do |line|
    center_zips_set.add(line.chomp)
  end
end

# puts center_zips_set.to_a.join(",")

assigned_zips = Set.new

def print_if_not_assigned(assigned_zips, zipcode, center_zip)
  return if assigned_zips.include? zipcode

  assigned_zips.add(zipcode)
  puts "#{zipcode},#{center_zip}"
end

File.open(center_zip_sorted_distances, "r") do |f|
  f.each_line do |line|
    values = line.split(",")
    if center_zips_set.include?(values[0])
      print_if_not_assigned(assigned_zips, values[1], values[0])
    else
      print_if_not_assigned(assigned_zips, values[0], values[1])
    end
  end
end
