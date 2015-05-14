def pluck_to_hash(model_class, *cols)
  User.pluck(*cols).map { |a| Hash[cols.zip a] }
end

def json_fixtures(data:[], columns:[], generate_id:false)
  data.each_with_index.map do |e,i|
    res = e.slice *columns
    res[:id] = i+1 if generate_id
    res
  end.to_json.html_safe
end

def json_parse(string)
  return if !string
  parsed = json_symbolize JSON.parse(string)
end

def json_symbolize(data)
  case data
    when Array then data.map { |e| json_symbolize e }
    when Hash then data.symbolize_keys
  end
end

require 'active_record'
ActiveRecord::Base.class_eval do
  def self.only
    raise "Expected to find one #{class_name} but none was found." if count == 0
    raise "Expected to find one #{class_name} but #{count} were found." if count > 1
    first
  end
end