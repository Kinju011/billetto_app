# Billetto Rails Engineer Test - Implementation

This application fetches event data from the Billetto API and implements a voting system using Rails Event Store (RES) and Clerk authentication.

## 🚀 Setup Instructions

### 1. Prerequisites
- Ruby 3.x
- PostgreSQL
- Billetto API Key & Secret
- Clerk Publishable Key & Secret Key

### 2. Environment Variables
Create a `.env` file in the root directory and add the following:
```env
BILLETTO_API_KEY=your_api_key
BILLETTO_API_SECRET=your_api_secret
CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key
CLERK_SECRET_KEY=your_clerk_secret_key
```

### 3. Installation
```bash
bundle install
rails db:create db:migrate
```

### 4. Rails Event Store (RES) Configuration
Rails Event Store is configured in `config/initializers/clerk.rb` and `config/initializers/rails_event_store.rb`. 
- **Events**: We use `EventUpvoted` and `EventDownvoted` events.
- **Metadata**: Each event data payload includes the `user_id` of the voter and the `event_id`.
- **Viewing Events**: You can view the event stream at `/res` in the development environment.

### 5. Running the App
```bash
rails server
```

## 🧪 Testing
The test suite covers model validations, authentication restrictions, Event Store publishing, and browser-based system flows.
```bash
bundle exec rspec
```

## 🛠 Features Implemented
- **API Ingestion**: Automated fetching of events with error handling.
- **Clerk Auth**: Modal-based sign-in/sign-up and server-side session verification.
- **Voting Logic**: Asynchronous voting buttons with "one-vote" restriction.
- **Event Driven**: All votes are stored as immutable events in RES.
