require 'rvm/capistrano'
require 'whenever/capistrano'
set :application, "bankofdad.eu"
set :scm, :git
set :repository,  "git@github.com:kh2ouija/bankofdad.git"
set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }

role :web, "bankofdad.eu"
role :app, "bankofdad.eu"
role :db,  "bankofdad.eu", :primary => true

set :use_sudo, false
default_run_options[:pty] = true

namespace :derp do
end

namespace :deploy do

  desc "Inject configuration files with sensitive data"
  task :copy_configs do
    run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "cp #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
    run "cp #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end

  desc "Restart unicorn"
  task :restart do
    run "#{sudo} service unicorn restart"
  end

  before "deploy:assets:precompile", "deploy:copy_configs"
  after "deploy:create_symlink", "deploy:restart_unicorn"
end
