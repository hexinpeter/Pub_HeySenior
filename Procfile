web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}

worker: bundle exec sidekiq -c ${SIDEKIQ_CONCURRENCY:-10}
mailers: bundle exec sidekiq -c ${SIDEKIQ_CONCURRENCY:-10} -q mailers
