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
* **One vote per user enforcement** (Server-side tracking)
* Authentication using Clerk (**Full Backend Integration**)
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

* Clerk hosted authentication pages are used for a seamless UI.
* **Backend Integration**: Implemented server-side session verification via `Clerk::Authenticatable`.
* **Security**: All voting actions require a valid backend session to ensure user identity.

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

* **Model Validations**: Ensuring data integrity for ingested events.
* **Request Specs**: Verifying authentication restrictions and Event Store publishing.
* **System Specs**: Real browser-based testing for the full voting and auth flow.

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

* Billetto API returns data based on region and may not always be in English.
* Only essential event fields are stored to maintain a lightweight footprint.

---

## ⚖️ Trade-offs

* **Dynamic Calculation**: Vote counts are calculated dynamically from the event stream. For massive scale, this would be moved to a read model (projection), but for this assignment, it ensures data consistency.
* **UI Focus**: The interface is designed for speed and clarity using Turbo, rather than heavy client-side frameworks.

---

## 📈 Possible Improvements

* Add pagination for the event listing page.
* Implement read models for faster vote aggregation if traffic scales significantly.
* Add comprehensive error page styling.

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
