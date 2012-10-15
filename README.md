# MasterCache

[![Build Status](https://secure.travis-ci.org/DianthuDia/master_cache.png)](http://travis-ci.org/DianthuDia/master_cache) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/DianthuDia/master_cache)

A master record cache plugin

## Installation

Add this line to your application's Gemfile:

    gem 'master_cache'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install master_cache

## Usage

### Basics

```ruby
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:employee_types) {|t| t.string :name; t.integer :position}
  end
end

class EmployeeType
  master_cache # :const_name => :name, :order_name => :position, :all_name => 'INSTANCES'
end

EmployeeType.create :name => 'STAFF', :position => 1 
EmployeeType.create :name => 'EMPLOYEE', :position => 2 
```

```ruby
EmployeeType::STAFF.id # => 1
EmployeeType::EMPLOYEE.id # => 2

EmployeeType.find(1).staff? # => true
EmployeeType.find(2).staff? # => false

EmployeeType::INSTANCES # => [EmployeeType::STAFF, EmployeeType::EMPLOYEE]
```

### General configuration options

You can configure the following default values by overriding these values using `MasterCache.configure` method.

```ruby
all_name		# 'INSTANCES' by default
const_name	# :name by default
order_name    # :position by default
```

There's a handy generator that generates the default configuration file into config/initializers directory.
Run the following generator command, then edit the generated file.

`$ rails g master_cache:config`

## Supported versions

* Ruby 1.8.7, 1.9.3
* ActiveRecord 3.x

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License. Copyright 2012 DianthuDia.