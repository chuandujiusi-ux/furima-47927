namespace :deploy do
  desc 'Run migrations on deploy'
  task :migrate do
    puts 'Running database migrations...'
    system('bundle exec rails db:migrate')
  end
end

Rake::Task['assets:precompile'].enhance do
  Rake::Task['deploy:migrate'].invoke
end
