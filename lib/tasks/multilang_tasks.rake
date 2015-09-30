namespace :multilang do
  task pull: :environment do
    Multilang::Export.new.run
  end

  task push: :environment do
    if ENV['path'].blank?
      puts 'multilang:push requires an file or directory to push'
      next
    end
    import = Multilang::Import.new ENV['path']
    import.run
  end
end
