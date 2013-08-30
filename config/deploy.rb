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

set :user, "sp"
set :use_sudo, false
set :deploy_to, "/home/sp/bankofdad"

namespace :deploy do
  task :copy_configs do
    run "cp /home/sp/database.yml #{release_path}/config/"
    run "cp /home/sp/newrelic.yml #{release_path}/config/"
  end
  after "deploy:update_code", "deploy:copy_configs"
end