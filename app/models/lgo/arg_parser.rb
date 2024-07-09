class String
  def lua_type = "string"
end

class NilClass
  def lua_type = "nil"
end

class Lgo::ArgParser
  def self.dump(data)
    data = [data] if !data.is_a? Array

    data.map do |obj|
      {value: obj, type: obj.lua_type}
    end.to_json
  end

  def self.load(data)
    data
  end
end
