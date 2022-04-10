# README

## System dependencies

- Ruby 2.6.1
- Bundler 2.2.29
- Yarn

## Installation

```ruby
bundle install
yarn install
bundle exec rails assets:precompile
rails db:create && rails db:migrate
rails s
```

## Rspec

```ruby
rails db:migrate RAILS_ENV=test
rspec spec/

# Coverage report generated for RSpec to /url_shortener/coverage. 344 / 344 LOC (100.0%) covered.
```

## Web app

Goto http://localhost:3000

#### Generate token algorithm

- https://api.rubyonrails.org/classes/ActiveRecord/SecureToken/ClassMethods.html
- https://api.rubyonrails.org/classes/SecureRandom.html

#### User credentials & API Authenticate

- https://github.com/heartcombo/devise

## API

#### Get API Key

After an account successfully registered, open rails console `rails c`

```ruby
User.last.api_key # your api_key here
```

#### Get all links

```ruby
curl --location --request GET 'http://localhost:3000/api/v1/links' \
--header 'api_key: <ENTER_API_KEY_HERE>' \
--header 'Cookie: __profilin=p%3Dt'
```

#### Create a link

```ruby
curl --location --request POST 'http://localhost:3000/api/v1/links' \
--header 'api_key: <ENTER_API_KEY_HERE>' \
--header 'Content-Type: application/json' \
--header 'Cookie: __profilin=p%3Dt' \
--data-raw '{
    "link": {
        "long_url": "https://this_is_long_url.com"
    }
}'
```

## Author

https://github.com/dangquangthai
