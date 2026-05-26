namespace :deploy do
  desc 'Run migrations on deploy'
  task :migrate do
    puts 'Running safe database migrations...'
    # データベースは削除せず、テーブルの作成・更新だけを確実に実行させます
    system('bundle exec rails db:migrate')
  end
end

Rake::Task['assets:precompile'].enhance do
  Rake::Task['deploy:migrate'].invoke
end
