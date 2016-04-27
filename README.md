## Install

install gem
```
gem 'multilang', githab: 'kelevro/multilang'
```

add to routes file
```
mount Multilang::Engine => '/multilang'
```

authorization
```
authenticate :admin do
  mount Multilang::Engine => '/multilang'
end
```

install gem
```
rails g multilang:install
```

migrations
```
rake multilang:install:migrations
rake db:migrate
```

## Configure

`config/initializers/multilang.rb`
`config.root_path` - url for return main app
`config.force_export` - if set `true` will export after each save translation


## Usage

# Export translaitons keys

After adding translations to your locales files
you can run `rake multilang:pull path=config/locales`, after thet all your
tralslations will be available in multilang console. If in console key already
exists this key will be skip. If you want override translation in console you
can run `rake multilang:pull force`.

`rake multilang:pull` - pull to console all translation from your project

