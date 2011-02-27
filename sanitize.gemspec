Gem::Specification.new do |s|
  s.name               = 'sanitize'
  s.homepage           = 'https://github.com/nerdyworm/sanitize'
  s.summary            = 'A ruby lib to sanitize strings for urls.'
  s.require_path       = 'lib'
  s.authors            = ['Benjamin S. Rhodes']
  s.email              = ['benjamin.s.rhodes@gmail.com']
  s.version            = 0.1
  s.platform           = Gem::Platform::RUBY
  s.files              = Dir.glob("{lib,spec}/**/*") + %w[README.rdoc]

  s.add_dependency 'activesupport',           '~> 3.0.0'
end
