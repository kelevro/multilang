namespace :multilang do
  task push: :environment do
    Multilang::Export.new.run
  end

  task pull: :environment do
    force = ENV.has_key?('force') ? true : false
    Multilang::Import.new(ENV['path'], force).run
  end
end
