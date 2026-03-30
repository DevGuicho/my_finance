# MyFinance 💸

MyFinance is a personal finance web application that allows users to manage their income and expenses, track accounts, categorize transactions, and visualize their financial activity through a monthly dashboard.

This project is also built as a learning platform to practice full-stack web development, software architecture, DevOps, and system design using Ruby on Rails.

---

## Features (MVP)

- User authentication (Devise)
- Multi-user system (each user has their own workspace)
- Financial accounts (cash, debit, credit, savings)
- Income and expense categories
- Income and expense transactions
- Transaction filters
- Monthly dashboard:
    - Total income
    - Total expenses
    - Monthly balance
    - Expenses by category
    - Account balances
    - Recent transactions

---

## Tech Stack

### Backend
- Ruby on Rails
- PostgreSQL
- Devise (authentication)
- Pundit (authorization)
- Money-Rails (money handling)
- Kaminari (pagination)

### Frontend
- Hotwire (Turbo + Stimulus)
- Tailwind CSS
- Flowbite (UI components)

### Infrastructure
- Docker
- OrbStack (local DNS & containers)
- PostgreSQL in Docker container

### Testing & Code Quality
- RSpec
- FactoryBot
- RuboCop