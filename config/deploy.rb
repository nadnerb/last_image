require 'bundler/capistrano'

set :application, "lastmeme"
set :repository,  "https://github.com/nadnerb/last_image.git"

set :scm, :git

set :git_shallow_clone, 1
set :use_sudo, false
set :applicationdir, "/opt/#{application}"
set :deploy_to, applicationdir
set :keep_releases, 5

set :use_sudo, false
set :default_shell, "bash -l"
set :ruby_version, "1.9.3"
set :chruby_config, "/etc/profile.d/chruby.sh"
set :set_ruby_cmd, "source #{chruby_config} && source /etc/profile.d/lastmeme.sh && chruby #{ruby_version}"
set(:bundle_cmd) {
  "#{set_ruby_cmd} && exec bundle"
}

default_run_options[:pty] = true

set :user, "deployer"
set :group, "www"

server "lastmeme.com", :web, :app, :db, :primary => true

set :rack_env, :production

set :unicorn_conf, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

set :public_children, ["css","img","js"]

ssh_options[:keys] = ENV['DEPLOY_KEY']

namespace :deploy do

  task :restart do
    run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{current_path} && #{set_ruby_cmd} && bundle exec unicorn -c #{unicorn_conf} -E #{rack_env} -D; fi"
  end

  task :start do
    run "cd #{current_path} && #{set_ruby_cmd} && bundle exec unicorn -c #{unicorn_conf} -E #{rack_env} -D"
  end

  task :stop do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

end
