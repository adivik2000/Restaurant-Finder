### Restaurant Finder ###
## December 2005 
## Run via: ruby init.rb
## Resurrected for training purposes

APP_ROOT = File.dirname(__FILE__)
# require "#{APP_ROOT}/lib/guide"
# require File.join(APP_ROOT, 'lib', 'guide.rb')  # Uses OS specific path delimeters
# require File.join(APP_ROOT, 'lib', 'guide')     # Same as above minus the file extension
# best approach:

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'guide'

guide = Guide.new('restaurants.txt')
guide.launch!