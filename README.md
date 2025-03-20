 
Blue-Ribbon
Newsletter Application A Flutter-based Newsletter Application that allows users to sign up, choose their interests, and receive personalized newsletter content dynamically. This app integrates Firebase for authentication, database storage, and deep linking.

✨ Features 🔐 User Registration: Sign up with Firebase Authentication (Email & Password). ✅ Input Validation: Ensures correct email format and secure password. 🎯 Interest Selection: Users select newsletter categories (Sports, Tech, Health, etc.). 📧 Email Confirmation: Sends a confirmation email with a deep link. 🔗 Deep Linking: Redirects users to their personalized newsletter. 📰 Dynamic Newsletter: Fetches and displays news content based on user preferences. 🏗 State Management: Uses Riverpod/Provider/Bloc for state handling. ⚡ Optimized Performance: Handles API failures and network errors gracefully. 🚀 Tech Stack Feature Tools Used Authentication Firebase Authentication Deep Linking Firebase Dynamic Links
Storage Firebase Firestore State Management Bloc Content Fetching NewsAPI Bonuses :

Implement Google Sign-in for user authentication.
Add loading indicators during API calls or while fetching dynamic content.
Use animations for smooth transitions between screens and loading states. 📸 Screenshots Add screenshots here by placing images in your repo and linking them like: Screenshot_20250321-005938 Screenshot_20250321-005947 Screenshot_20250321-005953 Screenshot_20250321-010029 Screenshot_20250321-010033 Screenshot_20250321-010040 Screenshot_20250321-010058 Screenshot_20250321-010123 Screenshot_20250321-010127 Screenshot_20250321-010134 Screenshot 2025-03-21 005359 Screenshot 2025-03-21 005445 Screenshot 2025-03-21 005507 Screenshot 2025-03-21 005613 Screenshot 2025-03-21 005642 Screenshot 2025-03-21 005721 Screenshot 2025-03-21 005752
📦 Setup Instructions Clone the repo:

git clone https://github.com/Zead-Fekry/newsletter-app.git cd newsletter-app Install dependencies:

flutter pub get Setup Firebase: Create a Firebase project. Enable Authentication (Email/Password). Enable google sign in Enable Firestore for storing user interests. Enable Dynamic Links for deep linking. Download the google-services.json (Android) and GoogleService-Info.plist (iOS) and place them in the respective folders. Run the app: flutter run
