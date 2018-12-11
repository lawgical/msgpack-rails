module ActiveResource
  module Formats
    module MsgpackFormat
      extend self

      def extension
        "mpac"
      end

      def mime_type
        Mime[:mpac].to_s
      end

      # Options hash currently serves no function.
      # TODO:  Fix it, duh.  Just like the Serializer's issue
      def encode(hash, options = nil)
        hash.to_msgpack
      end

      def decode(mpac)
        vals = MessagePack.unpack(mpac)

        decode_value(vals)
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
        if value.is_a?(String) && value[-1] == "]" && (m = value.match(/^([^\[\]]+)\[([^\[\]]+)\]$/)) && ['time', 'datetime', 'date'].include?(m[1].downcase)
          type = m[1]
          content = m[2]
          content.send("to_#{type.downcase}")
        elsif value.is_a?(Hash)
          decode_hash(value)
        elsif value.is_a?(Array)
          value.map{|v| decode_value(v)}
        else
          value
        end
      end
    end
  end
end
