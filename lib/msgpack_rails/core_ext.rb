# encoding: UTF-8

Time.class_eval do
  def to_msgpack(out='')
    ("Time[" + self.to_s + "]").to_msgpack(out)
  end
end

DateTime.class_eval do
  def to_msgpack(out='')
    ("DateTime[" + self.to_s + "]").to_msgpack(out)
  end
end

Date.class_eval do
  def to_msgpack(out='')
    ("Date[" + self.to_s + "]").to_msgpack(out)
  end
end