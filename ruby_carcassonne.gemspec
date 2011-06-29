# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby_carcassonne/version"

Gem::Specification.new do |s|
  s.name        = "ruby_carcassonne"
  s.version     = RubyCarcassonne::VERSION
  s.authors     = ["Michel Belleville"]
  s.email       = ["michel.belleville@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Carcassonne game engine for Ruby}
  s.description = %q{Extensible implementation of Carcassonne's game mechanics as a Ruby gem}

  s.rubyforge_project = "ruby_carcassonne"

  s.add_development_dependency "shoulda"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
