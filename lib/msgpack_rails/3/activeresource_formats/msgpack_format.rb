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
        MessagePack.unpack(mpac)
      end
    end
  end
end