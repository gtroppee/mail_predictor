desc "Launch all DB commands"
task  custom_setup: :environment do
  %x(padrino rake ar:create &&
  padrino rake ar:migrate &&
  padrino rake seed)
end