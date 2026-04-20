namespace :billetto do
  desc "Fetch and ingest events from Billetto API"
  task ingest_events: :environment do
    puts "Starting event ingestion..."
    api_service = BillettoApiService.new
    ingestion_service = EventIngestionService.new(api_service: api_service)
    
    ingestion_service.call
    puts "Ingestion complete! Total events: #{Event.count}"
  end
end
