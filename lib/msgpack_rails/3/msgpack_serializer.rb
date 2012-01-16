module ActiveModel
  module Serializers
    module Msgpack
      def to_msgpack(options = {})
        options = {:out => options} if options.is_a?(String)
        options[:out] ||= ''

        options[:out] << serializable_hash(options).to_msgpack
      end

      # TODO:  Test and uncomment this method
      #def from_msgpack(msg)
      #  MessagePack.unpack(msg)
      #end
    end
  end
end

module ActiveRecord
  module Serialization
    include ActiveModel::Serializers::Msgpack
  end
end

module ActiveResource
  class Base
    include ActiveModel::Serializers::Msgpack
  end
end