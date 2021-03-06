$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chatty/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chatty"
  s.version     = Chatty::VERSION
  s.authors     = ["Kasper Johansen"]
  s.email       = ["k@spernj.org"]
  s.homepage    = "https://www.github.com/kaspernj/chatty"
  s.summary     = "Chatty is a chat extention for Rails"
  s.description = "Making it easy to set it up a live chat on your website."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency "string-cases"
  s.add_dependency "haml-rails"
  s.add_dependency "simple_form_ransack", ">= 0.0.3"
  s.add_dependency "public_activity"
  s.add_dependency "plugin_migrator", ">= 0.0.1"
  s.add_dependency "devise"
  s.add_dependency "ransack"
  s.add_dependency "gettext_simple_rails", ">= 0.0.12"
  s.add_dependency "simple_form"
  s.add_dependency "sass-rails"
  s.add_dependency "state_machine"
  s.add_dependency "cancan"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "forgery"
end
