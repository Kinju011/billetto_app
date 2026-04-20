class BillettoApiService
  include HTTParty
  base_uri "https://billetto.dk"

   def initialize
    @headers = {
      "Api-Keypair" => "#{ENV['BILLETTO_API_KEY']}:#{ENV['BILLETTO_API_SECRET']}",
      "Content-Type" => "application/json"
    }
  end

  def fetch_events
    begin
      response = self.class.get("/api/v3/public/events?limit=100", headers: @headers)

      if response.success?
        response.parsed_response
      else
        Rails.logger.error "Billetto API Error: #{response.code} - #{response.body}"
        [] # Return empty to prevent crash
      end
    rescue HTTParty::Error, SocketError => e
      Rails.logger.error "Billetto API Connection Failed: #{e.message}"
      []
    rescue StandardError => e
      Rails.logger.error "Unexpected API Error: #{e.message}"
      []
    end
  end

  private

  def handle_response(response)
    unless response.success?
      raise "Billetto API Error: #{response.code}"
    end

    response.parsed_response
  end
end
