# frozen_string_literal: true

Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')).each do |file|
  desc "Load the seed data from db/seeds/#{File.basename(file)}."
  task "db:seed:#{File.basename(file).gsub(/\..+$/, '')}" => :environment do
    load(file)
  end
end

Dir.glob(File.join(Rails.root, 'db', 'seeds', 'dev', '*.rb')).each do |file|
  desc "Load the seed data from db/seeds/dev/#{File.basename(file)}."
  task "db:seed:dev:#{File.basename(file).gsub(/\..+$/, '')}" => :environment do
    load(file)
  end
end
