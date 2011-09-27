# MsgpackRails

Uses the fast and compact [msgpack](https://github.com/msgpack/msgpack 'MessagePack') binary format to let you serialize objects.

##  Installation

In your Gemfile include the following line:

    gem 'msgpack-rails', :git => 'git@github.com:nzifnab/msgpack-rails.git'

## Usage

To encode objects use [msgpack's](https://github.com/msgpack/msgpack 'MessagePack') `to_msgpack` method:

    @person = Person.new(:first_name => 'bob', :last_name => 'joe')
    @person.to_msgpack

In your controller's render action (to be consumed as an API like ActiveResource):

    respond_to do |format|
        format.mpac { render :text => @person.to_msgpack, :content_type => 'application/x-mpac' }
    end

Additionally you can set up ActiveResource to accept :mpac content types:

    class Animal < ActiveResource::Base
      self.format = :mpac
    end

    # Meanwhile, across the desert...

    Animal.find(1)   # =>  Expects the content to be in the msgpack format

## Gotchas

1. Serialization options hash

    It is currently more limiting than `to_json` or `to_xml` in that the 'options' hash does not (yet) work.  If you want the equivalent of this from json:

        @person.to_json(:include => [:group], :methods => [:monkey_see])

    Then you have to generate it as a hash manually:

        @person.serializable_hash(:include => [:group], :methods => [:monkey_see]).to_msgpack

    I plan on finding a way to get this working as the other two format methods do, but for now this work-around should be fine.

2. Date formats

    The msgpack gem (written in C) does not natively serialize date formats.  Instead, I convert the dates to a string and send them that way.
This is bad, because they are seen by the ActiveResource endpoint as a string and are not converted to a date.  You need to keep this in mind and may have to
use `to_datetime` on dates in those models.

## TODO

1) Fix the two gotchas mentioned above

2) Better render support in the controller (something like `render :mpac => @person.to_msgpack` without the `:content_type` requirement)

3) Better support and testing for rails 2.3 (maybe, but low priority)

## Contributing

If you use or are interested in the msgpack gem (even by itself) and want to or already do use it in Rails (with or without this msgpack-rails gem) I would
love to hear about your experiences!  What did you do to get it to work for you?

If you have suggestions, ideas, or have taken a look at this gem's code and want to help improve it (fixing bugs, adding additional features, etc) then that's great!
Fork the project, make a 'feature branch' with your suggested changes (preferably one major 'feature' per branch/pull request), and then do a pull request from that
branch.  Feel free to discuss with me ideas etc in the issues tracker here on github.

This project is licensed under the MIT-LICENSE.