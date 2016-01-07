if Rails.env.development?
  begin
    YAML.load(File.read('config/spotify.yml')).each do |key, value|
      ENV[key] = value
    end
  rescue
    raise "You need to add config/spotify.yml"
  end
end
