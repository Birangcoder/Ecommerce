# 🛒 Flutter E-Commerce App

A modern E-Commerce application built with **Flutter** following **Clean Architecture** principles. The 
application allows users to browse products, search items, manage wishlist and cart, place orders, and securely authenticate using JWT tokens.

The project demonstrates scalable Flutter development using **Riverpod**, **GoRouter**, **Flutter Secure Storage**, 
**Sqflite**, and REST API integration with **DummyJSON**.

---

## ✨ Features

### 🔐 Authentication
- User Login
- JWT Access Token Authentication
- Refresh Token Support
- Secure Token Storage using Flutter Secure Storage
- Auto Login
- Logout

### 🛍️ Products
- Browse Products
- Product Categories
- Search Products
- Product Details
- Customer Reviews
- Add to Wishlist
- Add to Cart

### ❤️ Wishlist
- Add/Remove Wishlist Items
- Local Storage using Sqflite
- Persistent Data

### 🛒 Cart
- Add Products
- Remove Products
- Increase/Decrease Quantity
- Bill Calculation
- Delivery Charges
- Checkout

### 📦 Orders
- Place Orders
- View Order History
- Order Details
- Payment Method Selection
- Store Orders Locally

### 👤 User Profile
- User Information
- Profile Screen
- Secure Logout

---

# 🏗 Architecture

The project follows **Clean Architecture** to keep the code maintainable, testable, and scalable.

```
lib
│
├── app
├── core
│   ├── storage
│   ├── provider
│   ├── constants
│   └── utils
│
├── features
│   ├── auth
│   ├── cart
│   ├── category
│   ├── help&support
│   ├── home
│   ├── mainScreen
│   ├── orders
│   ├── product
│   ├── profile
│   ├── search
│   └── wishlist
│
├── Widgets
└── main.dart
```

Each feature contains:

```
data
presentation
```

---

# 🛠 Tech Stack

- Flutter
- Dart
- Riverpod
- GoRouter
- Sqflite
- Flutter Secure Storage
- REST API
- DummyJSON API
- Clean Architecture
- Repository Pattern

---

# 📦 Packages Used

```yaml
flutter_riverpod
riverpod
go_router
http
flutter_secure_storage
sqflite
path_provider
intl
```

---

# 🔐 Authentication Flow

```
Login
      │
      ▼
DummyJSON API
      │
      ▼
Access Token
Refresh Token
      │
      ▼
Flutter Secure Storage
      │
      ▼
Protected Screens
```

---

# 💾 Local Storage

The application stores local data using **Sqflite**.

Stored locally:

- Wishlist
- Cart
- Orders

Sensitive data is stored using:

- Access Token
- Refresh Token

via **Flutter Secure Storage**.

---

# 🌐 API

This project uses the **DummyJSON API**.

Features used:

- Authentication
- Products
- Categories
- Search
- User Information

---

# 📱 Screens

- Login
- Home
- Search
- Search Results
- Product Details
- Wishlist
- Cart
- Checkout
- Orders
- Profile

---

# 🚀 State Management

The application uses **Riverpod** for:

- Authentication State
- Product State
- Wishlist State
- Cart State
- Orders State
- Search State

---

# 🧭 Navigation

Navigation is handled using **GoRouter**.

Features include:

- Authentication Guard
- Nested Routes
- Deep Linking Ready
- Clean Route Management

---

# 🔒 Security

- JWT Authentication
- Secure Token Storage
- Route Protection
- Persistent Login
- Logout Support

---

# 📈 Future Improvements

- Online Payment Gateway
- Push Notifications
- Dark Mode
- Product Filtering
- Address Management
- Coupon System
- Order Tracking
- Product Reviews
- Admin Panel
- Backend Integration
- Offline Sync

---

# 🎯 Learning Objectives

This project demonstrates:

- Clean Architecture
- Repository Pattern
- Riverpod State Management
- REST API Integration
- JWT Authentication
- Secure Storage
- Local Database Management
- Flutter Best Practices
- Scalable Project Structure

---

# 👨‍💻 Author

**Birang Pawala**

Flutter Developer | MCA Student

If you like this project, don't forget to ⭐ the repository.
