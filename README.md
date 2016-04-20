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

dependencies
```
gem 'ladda-bootstrap-rails'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem 'autosize-rails'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
```

TODO:
  1. Extract dependencies

