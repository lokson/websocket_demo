server 'ground', user: 'root', roles: %w{web app}
set :deploy_to, '/home/root/websocket_demo'

# default is master
# set :branch, ''

# custom values
set :rails_env, 'production'
set :wsoc_port, 3002
