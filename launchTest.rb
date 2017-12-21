#!/usr/bin/ruby

require 'rubygems'

path = %x(pwd)
status = %x(git status #{path} | grep '^\s*modified:' | cut -f 2- -d :)

puts status

#files = Array.new
#files.push(
