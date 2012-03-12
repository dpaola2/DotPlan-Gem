# -*- encoding: utf-8 -*-
require "./lib/dotplan/version"

Gem::Specification.new do |s|
  s.name        = "dotplan"
  s.version     = DotPlan::VERSION
  s.authors     = ["Dave Paola"]
  s.email       = ["dpaola2@gmail.com"]
  s.summary     = %q{The simplest way to manage your .plans}
  s.description = %q{The simplest way to manage your .plans}

  s.rubyforge_project = "dotplan"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "json"
  s.add_runtime_dependency "colorize"
  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "hashie"
end
