#!/usr/bin/env puma

# The directory to operate out of.
# The default is the current directory.
# directory '/var/www/hello.sas.vito.local'

# Set the environment in which the rack's app will run. The value must be a string.
environment ENV.fetch("RAILS_ENV") { "production" }

# Store the pid of the server in the file at "path".
# pidfile 'shared/tmp/pids/puma.pid'

# Use "path" as the file to store the server info state. This is
# used by "pumactl" to query and control the server.
# state_path 'shared/tmp/puma/puma.state'

# Redirect STDOUT and STDERR to files specified.
# The 3rd parameter ("append") specifies whether the output is appended,
# the default is "false".
# stdout_redirect 'shared/log/stdout', 'shared/log/stderr'
# stdout_redirect 'shared/log/stdout', 'shared/log/stderr', true

# Disable request logging.
# The default is "false".
# quiet

# Configure "min" to be the minimum number of threads to use to answer
# requests and "max" the maximum.
# The default is "0, 16".
# threads 0, 16

# Bind the server to "url". "tcp://", "unix://" and "ssl://" are the only accepted protocols.
# The default is "tcp://0.0.0.0:9292".
# bind 'tcp://0.0.0.0:9292'
# bind 'unix:///var/run/puma.sock'
# bind 'unix:///var/run/puma.sock?umask=0111'
# bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'
# bind 'unix://shared/tmp/sockets/puma.sock'

# Code to run before doing a restart. This code should close log files, database connections, etc.
# This can be called multiple times to add code each time.
# on_restart do
#   puts 'On restart...'
# end

# Command to use to restart puma. This should be just how to load puma itself (ie. 'ruby -Ilib bin/puma'),
# not the arguments to puma, as those are the same as the original process.
# restart_command '/u/app/lolcat/bin/restart_puma'


# === Cluster mode ===
# How many worker processes to run.  Typically this is set to to the number of available cores.
# The default is "0".
# workers 2

# Code to run immediately before the master starts workers.
before_fork do
  puts "Starting workers..."
  ActiveRecord::Base.connection_pool.disconnect!
end

# Code to run in a worker before it starts serving requests.
# This is called everytime a worker is to be started.
on_worker_boot do
  puts 'On worker boot...'
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Code to run in a worker right before it exits.
# This is called everytime a worker is to about to shutdown.
# on_worker_shutdown do
#   puts 'On worker shutdown...'
# end

# Code to run in the master right before a worker is started. The worker's index is passed as an argument.
# This is called everytime a worker is to be started.
# on_worker_fork do
#   puts 'Before worker fork...'
# end

# Code to run in the master after a worker has been started. The worker's index is passed as an argument.
# This is called everytime a worker is to be started.
# after_worker_fork do
#   puts 'After worker fork...'
# end

# Allow workers to reload bundler context when master process is issued a USR1 signal.
# This allows proper reloading of gems while the master is preserved across a phased-restart.
# (incompatible with preload_app) (off by default)
# prune_bundler

# Preload the application before starting the workers;
# this conflicts with phased restart feature. (off by default)
# preload_app!

# Additional text to display in process listing
# If you do not specify a tag, Puma will infer it. If you do not want Puma to add a tag, use an empty string.
# tag 'app name'

# Verifies that all workers have checked in to the master process within the given timeout.
# If not the worker process will be restarted. This is not a request timeout, it is to protect against a hung or dead process.
# Setting this value will not protect against slow requests.
# Default value is 60 seconds.
# worker_timeout 60

# Change the default worker timeout for booting
# If unspecified, this defaults to the value of worker_timeout.
# worker_boot_timeout 60

# === Puma control rack application ===
# Start the puma control rack application on "url". This application can be communicated with to control the main server.
# Additionally, you can provide an authentication token, so all requests to the control server will need to include that token as a query parameter.
# This allows for simple authentication.
# Check out https://github.com/puma/puma/blob/master/lib/puma/app/status.rb to see what the app has available.
# activate_control_app 'unix:///var/run/pumactl.sock'
# activate_control_app 'unix:///var/run/pumactl.sock', { auth_token: '12345' }
# activate_control_app 'unix:///var/run/pumactl.sock', { no_token: true }
# activate_control_app 'unix:/shared/tmp/puma/pumactl.sock'
