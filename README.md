# ArcWeld

Toolkit for generating ArcSight resources. Useful for fine-grained control
over the asset model. Currently supports generating the following resource
types:

- Asset
- AssetCategory
- Customer
- Location
- Network
- Zone
- Groups of the above resources

Basic support classes included for building resource XML archives and reading
resources from CSV files. You can also model supported relationships between
the resources using the relationship extension modules. This lets you do things
like add a location to zones, add a network to a customer, categorize resources,
etc.



## **WARNING**

You will completely trash your ESM if you do not understand *exactly* what
you are getting into with the archive tool. There's many reasons why not much
documentation exists on the subject. `$MANAGER_HOME/bin/arcsight archive -h`
to get started on that journey. Also, there is no guarantee that HP will
even continue to expose the archive tool interface. It could be deprecated
at any time in any release with no notice.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arc_weld'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arc_weld

## Usage

So far, the spec files contain the most complete description of how to use the
resource classes and relationship modules. There is a basic cli tool for
creating a csv-based model project and using that to generate the model xml.
Bear in mind that you can always break up a modeling effort into multiple smaller
projects and merge them in the target ESM if that makes more sense.

`ArcWeld::Resource` and `ArcWeld::Relationship` define the core DSL for describing
resources and relationships. The code for the resources and relationships themselves
are defined under `lib/arc_weld/resources` and `lib/arc_weld/relationships`.

Be advised - this is also an experiment for me, so some things could be better
organized. This will happen before I cut a 1.0.0.

## Licensed under GPLv3

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ryanbreed/arc_weld.
