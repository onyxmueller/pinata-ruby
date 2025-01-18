# Pinata Ruby

![header](assets/images/pinata_for_ruby.png)<br>

<p align="center">
  <a href="https://badge.fury.io/rb/pinata"><img alt="Gem Version" src="https://badge.fury.io/rb/pinata.svg"/></a>
  <a href="https://github.com/onyxmueller/pinata-ruby/blob/main/LICENSE.txt"><img alt="GitHub license" src="https://img.shields.io/badge/license-MIT-blue.svg"/></a>
  <a href="https://github.com/onyxmueller/pinata-ruby/actions/workflows/build.yml"><img alt="Build Status" src="https://github.com/onyxmueller/pinata-ruby/actions/workflows/build.yml/badge.svg"/></a> <br>
  <a href="https://onyxmueller.net/2024/11/19/introducing-the-pinata-ruby-library/"><img alt="Onyx Mueller Blog Post" src="https://img.shields.io/badge/Onyx_Mueller-Blog_Post-blue?color=%23F8D548&link=https%3A%2F%2Fonyxmueller.net%2F2024%2F12%2F16%2Fintroducing-the-pinata-ruby-library%2F"/></a>
</p>

The Pinata Ruby library provides convenient access to the Pinata API from applications written in the Ruby language. It includes a pre-defined set of classes for API resources that initialize themselves dynamically from API responses.

## Contents

- [Pinata](#pinata)
- [Contents](#contents)
- [Documentation](#documentation)
- [Installation](#installation)
  - [Bundler](#bundler)
  - [Gem Install](#gem-install)
  - [Requirements](#requirements)
- [Resources](#resources)
  - [Pagination](#pagination)
  - [Authentication](#authentication)
  - [Files](#files)
  - [Groups](#groups)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)

## Documentation

See the [Pinata API docs](https://docs.pinata.cloud/api-reference).

## Installation

### Bundler

Add this line to your application's Gemfile:

```sh
    gem 'pinata'
```

And then execute:

```sh
    bundle install
```

### Gem Install

Or install with:

```sh
    gem install pinata
```

### Requirements

- Ruby 2.6+.

## Usage

To access the API, you'll need to create a `Pinata::Client` and pass in your API key. You can find your API key at [https://app.pinata.cloud/developers/api-keys](https://app.pinata.cloud/developers/api-keys).

```ruby
    client = Pinata::Client.new(jwt_key: ENV["PINATA_JWT"])
```

## Resources

The gem maps as closely as we can to the Pinata API so you can easily convert API examples to gem code.

Responses are created as objects like `Pinata::File`. They're built using [OpenStruct](https://github.com/ruby/ostruct) so you can easily access data in a Ruby-ish way.

### Pagination

 `List` endpoints return pages of results. The result object will have a `data` key to access the results, as well as metadata like `next_page_token` for retrieving the next page.

```ruby
results = client.files.list
#=> Pinata::Collection

results.data.size
#=> 48

results.data
#=> [#<Pinata::File>, #<Pinata::File>]

results.next_page_token
#=> "MDE5MzJjNzctMDg2Ny03ZTdhLWE2ZDEtMDRhZWRlZDNjMWI5"

# Retrieve the next page
client.files.list(pageToken: "MDE5MzJjNzctMDg2Ny03ZTdhLWE2ZDEtMDRhZWRlZDNjMWI5")
#=> Pinata::Collection
```

### Authentication

```ruby
client.authentication.test
```

### Files

```ruby
client.files.upload(file: "/path/to/file")
client.files.list
client.files.list("metadata[key]": "value")
client.files.get(file_id: "1234567890")
client.files.sign("gateway": "yourgatewaydomain", "file_cid": "thefilecid", "expires": 500000)
client.files.update(file_id: "thefilesid", "name": "thenameoffile")
client.files.delete(file_id: "1234567890")
```

### Groups

```ruby
client.groups.create({})
client.groups.get(group_id: "id")
client.groups.list
client.groups.add_file(group_id: "id", file_id: "id")
client.groups.remove_file(group_id: "id", file_id: "id")
client.groups.update(group_id: "id", {})
client.groups.delete(group_id: "id")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( [https://github.com/onyxmueller/pinata-ruby/fork](https://github.com/onyxmueller/pinata-ruby/fork) )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pinata project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/onyxmueller/pinata-ruby/blob/main/CODE_OF_CONDUCT.md).
