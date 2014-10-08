desc "initialize/reset the projet"
namespace :mp do
  task  setup: :environment do
    %w(
      ar:drop:all
      ar:create:all
      ar:migrate
      seed
      ).each do |task| Rake.application[task].invoke end
  end
end
