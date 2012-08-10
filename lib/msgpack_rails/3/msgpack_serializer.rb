module ActiveModel
  module Serializers
    module Msgpack
      extend ActiveSupport::Concern
      include ActiveModel::Serialization

      def to_msgpack(options = {})
        options = {:out => options} if options.is_a?(String)
        options[:out] ||= ''

        options[:out] << serializable_hash(options).to_msgpack
      end
      alias_method :to_mpac, :to_msgpack

      # TODO:  Test and uncomment this method
      #def from_msgpack(msg)
      #  MessagePack.unpack(msg)
      #end
    end
  end
end

module ActiveRecord
  class Base
    include ActiveModel::Serializers::Msgpack
  end
end

module ActiveResource
  class Base
    include ActiveModel::Serializers::Msgpack
  end
end