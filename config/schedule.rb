# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
require File.expand_path(File.dirname(__FILE__) + "/environment")# Rails.rootを使用するために必要
require "#{Rails.root}/app/models/novel_list"
rails_env = ENV['RAILS_ENV'] || 'development'# cronを実行する環境変数
set :environment, rails_env# cronを実行する環境変数をセット
set :output, "#{Rails.root}/log/cron.log"# cronのログの吐き出し場所

every 1.minutes do
  runner 'NovelList.timeSelected'
end