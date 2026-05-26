namespace :deploy do
  desc 'Run migrations on deploy'
  task :migrate do
    puts 'Resetting database...'
    # 一度データベースを完全に空にしてからマイグレーションをやり直す命令です
    system('bundle exec rails db:migrate:reset')
  end
end

Rake::Task['assets:precompile'].enhance do
  Rake::Task['deploy:migrate'].invoke
end
