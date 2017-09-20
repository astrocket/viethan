# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Include tasks from other gems included in your Gemfile
require 'capistrano/rbenv'
require 'capistrano/rbenv_install'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano/figaro_yml'
require 'capistrano/upload-config'
require 'capistrano/puma/nginx'   # if you want to upload a nginx site template
require 'capistrano/nginx'
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Nginx

require 'capistrano/rails/collection'

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
