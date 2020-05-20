config = HashWithIndifferentAccess.new(YAML.load_file(Rails.root.join("config", "redis.yml"))[Rails.env])
db = ENV.fetch('BRIMIR_REDIS_DB', (config[:db] || 7))
$redis = Redis.current = Redis.new(host: config[:host], port: config[:port], db: db)
ENV['REDIS_URL'] = "#{$redis.client.id}/cache"