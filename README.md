Harvester
=========

## Architecture

It follows a very simple architecture where you have adapters or strategies for different types of harvests that abstract most of the complexity and let the harvest operator use a common language for defining how to extract the important data from every source.

## Adapters

The following adapters have been implemented:

* Open Archives Initiative
* Really Simple Syndication
* XML
* JSON

Each adapter is very easy to implement, for the current adapters they only have between 60 and 100 lines of code each.

## Parser definition

The parser files for the different sources are defined using a Domain Specific Language which exposes methods or constructs to fetch and extract the needed pieces of information from each source. This way the important details of each parser file are expressed in a more conscise and elegenant manner thereby enhancing the quality, maintainability, ease of use as well as reducing the proneness to errors.

### Parser file methods

#### base_url
It takes a url as a argument which will be used to fetch the resources.

#### attribute / attributes
It takes the name of the attribute and then some options to specify how that particular field is going to be populated. It can additionally take a block in which any custom logic can be defined.

#### Method definitons
Any method defined in the parser file will also be used as a attribute for the resource, the difference being that you have access to the raw document or XML and the full power of ruby to extract the relevant data any way you want. 

#### Finders / Modifiers
To aid in the method definitions a set of methods are provided to acomplish common tasks, some examples are:

* find_with
* find_all_with
* find_without
* find_all_without
* mapping
* add
* select

Overtime we can very easily expand this set of tools solve common problems across the different sources. 

## Testing
Since each adapater and each parser file are just ruby classes with very little dependencies it is very easy to test them with a predefined set of data.

## Vision
The vision of this proyect is to have something that change very easily since harvesting in itself is a very unpredictable task with very different types of sources and also the data requierements for the API evolve.

## Installation

Add this line to your application's Gemfile:

    gem 'harvester_core'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install harvester_core

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
