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
    response = self.class.get("/api/v3/public/events?limit=100", headers: @headers)

    raise "API Error: #{response.code}" unless response.success?

    response.parsed_response
  end

  private

  def handle_response(response)
    unless response.success?
      raise "Billetto API Error: #{response.code}"
    end

    response.parsed_response
  end
end