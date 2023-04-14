# config valid for current version and patch releases of Capistrano
lock "~> 3.17.2"

set :application, 'customer_loan_database'
set :repo_url, 'https://github.com/nileshdigarse/customer_loan_database.git' # should match git repo
set :branch, :main
set :deploy_to, '/home/ubuntu/customer_loan'
set :pty, true
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 3
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-3.2.0' # Should match ruby version

set :puma_rackup, -> { File.join('/home/ubuntu/customer_loan/', 'config.ru') }
set :puma_state, "/home/ubuntu/customer_loan/shared/tmp/pids/puma.state"
set :puma_pid, "/home/ubuntu/customer_loan/shared/tmp/pids/puma.pid"
set :puma_bind, "unix:///home/ubuntu/customer_loan/shared/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "/home/ubuntu/customer_loan/shared/puma.rb"
set :puma_access_log, "/home/ubuntu/customer_loan/shared/log/puma_error.log"
set :puma_error_log, "/home/ubuntu/customer_loan/shared/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

desc 'Restart Puma server using nohup'
task :restart_puma do
  on roles(:app) do
    execute "rm /home/ubuntu/customer_loan/shared/tmp/sockets/puma.sock" 
    run "cd /home/ubuntu/customer_loan/current && nohup bundle exec puma -e production -b unix:/home/ubuntu/customer_loan/shared/tmp/sockets/puma.sock &"
  end
end
after :deploy, :restart_puma