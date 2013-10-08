# petl [![Build Status](https://travis-ci.org/ZestFinance/petl.png?branch=master)](https://travis-ci.org/ZestFinance/petl) [![Code Climate](https://codeclimate.com/github/ZestFinance/petl.png)](https://codeclimate.com/github/ZestFinance/petl)

Pretty good ETL framework

## Features
1. Batching support
2. Automatic validity check
3. Logging of running times

## Installation

Add this line to your application's Gemfile:

    gem 'petl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install petl

## Usage

```ruby
require 'petl'

module ETL::Example
  extend Petl::ETL
  extend self

  def extract
    # Grab all data from source(s) here.
    # Perferrably return an array of hashes.
  end

  def transform rows
    # Manipulate the data extracted by the previous extract method.
  end

  def load rows
    # Load the transformed data here into the destination(s).
  end

  def source_count
    # Count the number of records from your source(s).
  end

  def destination_count
    # Same as #source_count but with your destination(s).
  end
end

# Run it!
ETL::Example.perform
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
