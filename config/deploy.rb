# config valid only for current version of Capistrano
lock "3.9.1"

set :application, 'viethan'
set :repo_url, 'git@github.com:astrocket/viethan.git'

# cap production deploy BRANCH=master
set :branch, ENV['BRANCH'] if ENV['BRANCH']

set :migration_role, :app

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, File.read('.ruby-version').strip

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deploy/apps/viethan'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Nginx Configuration
set :nginx_domains, "vietsinkorea.com"
set :nginx_use_ssl, true

# Name of SSL certificate file
set :nginx_ssl_certificate, '/etc/letsencrypt/live/vietsinkorea.com/fullchain.pem'
set :nginx_ssl_certificate_key, '/etc/letsencrypt/live/vietsinkorea.com/privkey.pem'

before 'deploy:check:linked_files', 'config:push'
before 'deploy:starting', 'figaro_yml:setup'
after 'figaro_yml:setup', 'puma:nginx_config'
set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
