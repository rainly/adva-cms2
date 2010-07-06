# encoding: utf-8

# $: << File.expand_path('../lib', __FILE__)
# require 'adva/core/version'

Gem::Specification.new do |s|
  s.name         = "adva-core"
  s.version      = '0.0.1'
  s.authors      = ["Ingo Weiss", "Sven Fuchs"]
  s.email        = "nobody@adva-cms.org"
  s.homepage     = "http://github.com/svenfuchs/adva-cms2"
  s.summary      = "[summary]"
  s.description  = "[description]"

  s.files        = Dir['{app,config,lib,public}/**/*']
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
  
  s.add_dependency 'rails', '~> 3.0.0.beta4'
  s.add_dependency 'gem_patching'
  s.add_dependency 'resource_awareness'
  s.add_dependency 'inherited_resources', '1.1.2'
end