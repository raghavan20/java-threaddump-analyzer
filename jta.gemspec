Gem::Specification.new do |s|
  s.name            = "java-threaddump-analyzer"
  s.homepage        = 'https://github.com/raghavan20/java-threaddump-analyzer'
  s.version         = "1.0.1"
  s.licenses        = ['MIT']
  s.authors         = ["Raghavan Chockalingam"]
  s.description     = ["java thread dump analyzer"]
  s.summary         = "helps analyze java thread dumps quickly"
  s.email           = "raghavan20@gmail.com"
  
  s.files           = `git ls-files`.split("\n")
  s.test_files      = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables     = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths   = ["lib"]
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-reporters'
end
