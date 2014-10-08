desc "initialize/reset the projet"
namespace :mp do
  task  setup: :environment do
    %w(
      ar:reset
      db:seed
      ).each do |task| Rake.application[task].invoke end
  end
end
