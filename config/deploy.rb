# config valid only for current version of Capistrano
lock '3.4.1'

set :scm,                         :git
set :repo_url,                    'git@github.com:thefoolsrl/brimir.git'
set :ssh_options,                 {user: 'deployer', forward_agent: true}

set :stages,                      %w(production staging)
set :default_stage,               'staging'

set :user,                        'deployer'
set :group,                       'deployer'

set :format,                      :pretty
set :log_level,                   :debug

set :linked_files,                %w{config/database.yml config/secrets.yml config/unicorn.rb config/initializers/mail.rb config/secrets.yml}
set :linked_dirs,                 %w{bin log sockets tmp/pids pids tmp/sockets data}

set :rvm_ruby_version,            '2.4.9@ticketing'
set :rvm_type,                    :auto

namespace :deploy do
  # desc 'Start application'
  # task :start do
  #   on roles(:app), in: :sequence, wait: 5 do
  #       execute "sudo service nginx start"
  #   end
  # end
  #
  # desc 'Stop application' do
  #   task :stop do
  #     on roles(:app), in: :sequence, wait: 5 do
  #         execute 'sudo service nginx stop'
  #     end
  #   end
  # end
  #
  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #       execute 'sudo service nginx reload'
  #   end
  # end
end

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end