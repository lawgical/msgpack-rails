module ActiveResource
  module Formats
    module MsgpackFormat
      extend self

      def extension
        "mpac"
      end

      def mime_type
        Mime::MPAC.to_s
      end

      # Options hash currently serves no function.
      # TODO:  Fix it, duh.  Just like the Serializer's issue
      def encode(hash, options = nil)
        hash.to_msgpack
      end

      def decode(mpac)
        vals = MessagePack.unpack(mpac)

        if vals.is_a?(Array)
          vals.map{|v| decode_hash(v)}
        else
          decode_hash(vals)
        end
      end

      def decode_hash(vals)
        Hash[vals.map do |key, value|
          # DateTime type strings are formatted:  DateTime[SomeDateTimeParseableString]
          # If the value is a string, and the last char is a ']', check if it has a class name at the beg. w/ some regex
          # If it matches the format exactly, parse it as datetime, date, or time.
          [key, decode_value(value)]
        end]
      end

      def decode_value(value)
        if value.is_a?(String) && value[-1] == "]" && (m = value.match(/^([^\[\]]+)\[([^\[\]]+)\]$/))
          type = m[1]
          content = m[2]
          content.send("to_#{type.downcase}")
        else
          value
        end
      end
    end
  end
end