namespace :multilang do
  task :set_locales do
    on roles(:all) do
      execute "mkdir -p #{deploy_to}/shared/config/locales"
      upload!('config/locales/en.yml', "#{deploy_to}/shared/config/locales/en.yml")
      upload!('config/locales/de.yml', "#{deploy_to}/shared/config/locales/de.yml")
    end
  end

  task :get_locales do
    on roles(:all) do
      system("scp #{fetch(:deploy_user)}@#{host}:#{shared_path}/config/locales/de.yml config/locales/de.yml")
      system("scp #{fetch(:deploy_user)}@#{host}:#{shared_path}/config/locales/en.yml config/locales/en.yml")
    end
  end
end
