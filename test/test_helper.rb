require 'simplecov'
SimpleCov.start

gem "minitest"
require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/district"
require_relative "../lib/district_repository"
require_relative "../lib/enrollment"
require_relative "../lib/enrollment_repository"
require_relative "../lib/headcount_analyst"
require_relative "../lib/economic_profile"
require_relative "../lib/economic_profile_repository"
require_relative "../lib/cleaner"
require_relative "../lib/statewide_test"
require_relative "../lib/statewide_test_repository"
