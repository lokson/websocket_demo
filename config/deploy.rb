# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'mi'
set :repo_url, 'git@internal.motabi.pl:mi-backend'
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
  def execute_in_current(*args)
    on roles(:app) do
      within release_path do
        execute *args
      end
    end
  end

  task :permit_temp do
    execute_in_current :chmod, "777 -R tmp"
  end

  task :restart do
    execute_in_current :touch, 'touch tmp/restart.txt'
  end

  task :assets_clean do
    return if !fetch :rails_env
    execute_in_current :bundle, "exec rake assets:clean RAILS_ENV=#{fetch :rails_env}"
  end

  task :assets_precompile do
    return if !fetch :rails_env
    execute_in_current :bundle, "exec rake assets:precompile RAILS_ENV=#{fetch :rails_env}"
  end

  task :update_bins do
    execute_in_current :bundle, "exec rake rails:update:bin"
  end

  task :db_reset do
    return if !fetch :rails_env
    execute_in_current :bundle, "exec rake db:reset RAILS_ENV=#{fetch :rails_env}"
  end

  task :bundle do
    execute_in_current :bundle
  end

  task :websocket_start do
    execute_in_current :bundle, 'exec rake websocket_rails:start_server'
  end

  task :websocket_stop do
    execute_in_current :bundle, 'exec rake websocket_rails:stop_server'
  end

  # list all here:
  before :publishing, :websocket_stop
  after :publishing, :permit_temp
  after :publishing, :assets_clean
  after :publishing, :assets_precompile
  # after :publishing, :update_bins
  # after :publishing, :db_reset
  after :publishing, :restart
  after :publishing, :websocket_start

  # bundle seems to be part of deploy as default
  # after :publishing, :bundle
end
