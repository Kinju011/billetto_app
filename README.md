# Billetto Rails Assignment

## 📌 Overview

This application integrates with the Billetto API to fetch public events, stores them locally, and provides a voting system using an event-driven architecture.

The goal of this project is to demonstrate:

* External API integration
* Clean Rails architecture
* Event-driven design using Rails Event Store
* Basic authentication handling

---

## 🚀 Features

* Fetch and ingest events from Billetto API
* Store and display events with relevant details
* Event-driven voting system (upvote/downvote)
* Authentication using Clerk (hosted login)
* Turbo-powered UI updates (no full page reload)

---

## 🏗️ Architecture Overview

The application follows a modular and maintainable design:

* **Service Objects**

  * `BillettoApiService` → Handles external API communication
  * `EventIngestionService` → Responsible for transforming and storing data

* **Event-Driven Design**

  * Voting is implemented using Rails Event Store
  * Votes are stored as immutable events instead of direct DB updates

* **Separation of Concerns**

  * Controllers remain thin
  * Business logic is handled in services
  * Views are responsible only for presentation

---

## 🌐 API Integration

Events are fetched from the Billetto Public Events API.

* Data is ingested and stored locally
* Duplicate entries are avoided using `external_id`
* Only relevant fields are mapped and persisted

---

## 🗳️ Voting System (Event-Driven)

Instead of storing votes directly in the database, the application uses Rails Event Store.

Each vote is recorded as an event:

* `EventUpvoted`
* `EventDownvoted`

### Why Event Store?

* Maintains an immutable history of actions
* Decouples write and read logic
* Allows easy extension for analytics or projections

Votes are grouped using streams:

```
event_<event_id>
```

Vote counts are dynamically calculated by reading events from the stream.

---

## 🔐 Authentication (Clerk)

Authentication is implemented using Clerk.

### Approach

* Clerk hosted authentication pages are used
* User identity is handled on the frontend
* User ID is passed to backend during voting

### Note

In a production system, Clerk session tokens would be verified server-side.
For this assignment, a lightweight approach is used to keep the integration simple and focused.

---

## ⚡ Turbo Integration

Turbo Frames are used to:

* Update vote counts dynamically
* Avoid full page reloads
* Improve user experience

---

## 🧪 Testing

RSpec is used for testing.

Basic coverage includes:

* Model validations
* Event creation for voting

---

## ⚙️ Setup Instructions

### Prerequisites

* Ruby 3.4.x
* Rails 8.x
* PostgreSQL

---

### Installation

```bash
git clone https://github.com/Kinju011/billetto_app.git
cd billetto_app
bundle install
```

---

### Database Setup

```bash
bin/rails db:create
bin/rails db:migrate
```

---

### Environment Variables

Create a `.env` file:

```env
BILLETTO_API_KEY=your_key
BILLETTO_API_SECRET=your_secret
CLERK_PUBLISHABLE_KEY=your_key
```

---

### Run the Application

```bash
bin/rails server
```

Open:

```
http://localhost:3000
```

---

## 📊 Assumptions

* Billetto API returns data based on region and may not always be in English
* Only essential event fields are stored
* Voting system does not prevent duplicate votes per user (can be extended)

---

## ⚖️ Trade-offs

* Used hosted Clerk authentication instead of full backend integration for simplicity
* Vote counts are calculated dynamically instead of using read models (sufficient for current scale)
* UI is kept minimal to focus on functionality

---

## 📈 Possible Improvements

* Prevent duplicate voting per user
* Add pagination for events
* Implement read models for faster vote aggregation
* Full Clerk backend integration with session validation
* Better UI/UX styling

---

## 💬 Summary

This project demonstrates:

* Clean integration with external APIs
* Event-driven architecture in Rails
* Practical authentication handling
* Thoughtful separation of concerns

---

## 👤 Author

Kinjal
