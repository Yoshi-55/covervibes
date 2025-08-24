module MarketHelper
  # Spotify対応マーケット
  def spotify_markets
    [
      ["JP", "Japan"],
      ["US", "United States"],
      ["GB", "United Kingdom"],
      ["KR", "South Korea"],
      ["DE", "Germany"],
      ["FR", "France"],
      ["BR", "Brazil"]
    ]
  end

  def market_label(code)
    spotify_markets.to_h[code] || code
  end
end
