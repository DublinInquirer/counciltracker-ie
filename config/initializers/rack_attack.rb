class Rack::Attack
  # Use Redis cache store if available, otherwise fall back to memory
  Rack::Attack.cache.store = ActiveSupport::Cache::RedisCacheStore.new(url: ENV["REDIS_URL"]) if ENV["REDIS_URL"]

  # Block known aggressive scrapers and AI training bots by user agent
  BLOCKED_USER_AGENTS = /GPTBot|ChatGPT-User|Google-Extended|CCBot|anthropic-ai|Claude-Web|cohere-ai|PerplexityBot|Bytespider|SemrushBot|AhrefsBot|MJ12bot|DotBot|BLEXBot|DataForSeoBot|PetalBot/i

  blocklist("block aggressive bots by user agent") do |req|
    req.user_agent&.match?(BLOCKED_USER_AGENTS)
  end

  # Block deep pagination requests — legitimate users never browse past page 50.
  # Bots crawl hundreds or thousands of pages (e.g. OFFSET 305200 seen in logs).
  MAX_PAGE = 50
  blocklist("block deep pagination scraping") do |req|
    page = req.params["p"].to_i
    page > MAX_PAGE && req.path =~ %r{^/(councillors|meetings|motions|parties|areas|topics)}
  end

  # Throttle all requests by IP: 60 requests per minute
  throttle("req/ip", limit: 60, period: 1.minute) do |req|
    req.ip unless req.path.start_with?("/assets")
  end

  # Stricter throttle for councillor/meeting listing pages (common scraping targets)
  throttle("scrape/ip", limit: 20, period: 1.minute) do |req|
    if req.path =~ %r{^/(councillors|meetings|motions|parties|areas|topics)}
      req.ip
    end
  end

  # Return 429 with a message for throttled requests
  self.throttled_responder = lambda do |env|
    [
      429,
      { "Content-Type" => "text/plain", "Retry-After" => "60" },
      ["Too many requests. Please slow down.\n"]
    ]
  end
end
