web: node socket/index.js
worker: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}