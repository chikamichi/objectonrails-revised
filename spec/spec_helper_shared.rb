require File.expand_path('../../config/environment', __FILE__)
require 'rr'
require 'minitest/reporters'

Minitest::Reporters.use!(Minitest::Reporters::DefaultReporter.new)
# Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

module SpecHelpers
  def self.stub_module(full_name)
    full_name.to_s.split(/::/).inject(Object) do |context, name|
      begin
        context.const_get(name)
      rescue NameError
        context.const_set(name, Module.new)
      end
    end
  end

  def self.stub_class(full_name)
    full_name.to_s.split(/::/).inject(Object) do |context, name|
      begin
        context.const_get(name)
      rescue NameError
        context.const_set(name, Class.new)
      end
    end
  end
end
