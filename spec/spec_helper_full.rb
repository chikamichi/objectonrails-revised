require_relative 'spec_helper_shared'
require 'database_cleaner'
require 'pathname'

module DBHelpers
  def setup_database
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.start
  end

  def teardown_database
    DatabaseCleaner.clean
  end
end

class IntegrationSpec < MiniTest::Spec
  include DBHelpers

  before do
    setup_database
  end

  after do
    teardown_database
  end

  def self.is_model?(target)
    target <= ActiveRecord::Base ||
      # Some models which are not AR-backed might still leverage AR through
      # dependencies. If spec_helper_full was loaded, it is worth the
      # (quite expensive) check.
      self.find_pathname(target).dirname.fnmatch('*/app/models')
  end

  register_spec_type(self) do |desc|
    IntegrationSpec.is_model?(desc)
  end

  private

  def self.find_pathname(target)
    Pathname.new(target.instance_methods(false).map { |m|
      target.instance_method(m).source_location.first
    }.uniq.first)
  end
end
