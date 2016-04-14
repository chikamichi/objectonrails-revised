require_relative 'spec_helper_shared'
require 'nulldb'

module DBHelpers
  def setup_database
    NullDB.nullify
  end

  def teardown_database
    NullDB.restore
  end
end

class NonIntegrationSpec < MiniTest::Spec
  include DBHelpers

  before do
    setup_database
  end

  after do
    teardown_database
  end

  def self.is_model?(target)
    target <= ActiveRecord::Base
  end

  register_spec_type(self) do |desc|
    NonIntegrationSpec.is_model?(desc)
  end
end
