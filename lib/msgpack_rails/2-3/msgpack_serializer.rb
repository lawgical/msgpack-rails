module ActiveRecord
  module Serialization
    def to_msgpack(options = {})
      options = {:out => options} if options.is_a?(String)
      options[:out] ||= ''

      options[:out] << MsgpackSerializer.new(self).to_s
    end

    class MsgpackSerializer < ActiveRecord::Serialization::Serializer
      def serialize
        MessagePack.pack(serializable_record)
      end
    end
  end
end