require "rvm/capistrano"

set :application, "bankofdad.eu"
set :scm, :git
set :repository,  "git@github.com:kh2ouija/bankofdad.git"
set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }

role :web, "beta.bankofdad.eu"                          # Your HTTP server, Apache/etc
role :app, "beta.bankofdad.eu"                          # This may be the same as your `Web` server
role :db,  "beta.bankofdad.eu", :primary => true # This is where Rails migrations will run

set :use_sudo, false

namespace :deploy do
  task :copy_configs do
    run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "cp #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
  end
  before "deploy:assets:precompile", "deploy:copy_configs"
end
