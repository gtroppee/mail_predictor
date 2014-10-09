namespace :mp do

  desc "prepare the testing environment"
  task  test_prepare: :environment do
    PADRINO_ENV = 'test'
    %w(drop create migrate).each do |action|
      Rake.application["ar:#{action}"].invoke
    end
  end

  desc "initialize/reset the projet"
  task  setup: :environment do
    Rake.application['ar:setup'].invoke
    puts '### Project initialized ###'
    Rake.application['mp:test_prepare'].invoke
    puts '### Test environment prepared ###'
  end
  
end
