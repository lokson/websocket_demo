def pluck_to_hash(model_class, *cols)
  User.pluck(*cols).map { |a| Hash[cols.zip a].stringify_keys }
end

def json_fixtures(data:[], columns:[], generate_id:false)
  data.each_with_index.map do |e,i|
    res = e.slice *columns
    res[:id] = i+1 if generate_id
    res
  end.to_json.html_safe
end

def json_parse(data)
  JSON.parse(data).symbolize_keys
end
