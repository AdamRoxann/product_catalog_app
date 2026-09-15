# Product Catalog App

A Flutter product catalog application built as a technical assessment.

The application uses the DummyJSON API to display products, support pagination, search, and product details.

## Features

### Required

- Product listing
- Product title, thumbnail, and price
- Pagination / load more on scroll
- Product detail screen
- Product description, price, rating, and images
- Loading states
- Error states with retry
- Empty states
- Debounced product search

### Bonus

- Pull-to-refresh
- Image loading placeholder
- Image error handling
- Unit test
- Small UX improvements

## Tech Stack

- Flutter
- Dart
- Riverpod
- Dio
- GoRouter
- DummyJSON API

## API

The application uses the following DummyJSON endpoints:

### Product List

`GET /products?limit=20&skip=0`

Used to retrieve products with pagination.

### Product Search

`GET /products/search?q={query}&limit=20&skip=0`

Used for product searching.

### Product Detail

`GET /products/{id}`

Used to retrieve product details.

## Architecture

The application uses a layered architecture to separate UI, state management, data access, and networking.

Presentation
    ↓
Provider
    ↓
Repository
    ↓
Remote Datasource
    ↓
Dio
    ↓
DummyJSON API

## AI ASSISTANCE

AI tools were used as a supporting resource during development for:

- Reviewing implementation approaches
- Debugging guidance
- Flutter/Riverpod references
- Suggestions for code organization
- Reviewing potential improvements
- Unit test setup
- Readme reference

The core application architecture, implementation decisions, and final code were reviewed and understood by the developer.