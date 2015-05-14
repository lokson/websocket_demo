# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'mi'
set :repo_url, 'git@internal.motabi.pl:mi-backend'
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :permit_temp do
    on 'root@ground' do
      execute "cd #{release_path} && chmod 777 -R tmp"
    end
  end

  task :assets_precompile do
    on 'root@ground' do
      execute "cd #{release_path} && RAILS_ENV=#{rails_env} rake assets:precompile"
    end
  end

  after :publishing, :permit_temp
  after :publishing, :assets_precompile
  after :publishing, :restart
end
