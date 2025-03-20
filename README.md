# Blue-Ribbon
Newsletter Application
A Flutter-based Newsletter Application that allows users to sign up, choose their interests, and receive personalized newsletter content dynamically. This app integrates Firebase for authentication, database storage, and deep linking.

✨ Features
🔐 User Registration: Sign up with Firebase Authentication (Email & Password).
✅ Input Validation: Ensures correct email format and secure password.
🎯 Interest Selection: Users select newsletter categories (Sports, Tech, Health, etc.).
📧 Email Confirmation: Sends a confirmation email with a deep link.
🔗 Deep Linking: Redirects users to their personalized newsletter.
📰 Dynamic Newsletter: Fetches and displays news content based on user preferences.
🏗 State Management: Uses Riverpod/Provider/Bloc for state handling.
⚡ Optimized Performance: Handles API failures and network errors gracefully.
🚀 Tech Stack
Feature	Tools Used
Authentication	 Firebase Authentication
Deep Linking	   Firebase Dynamic Links  
Storage	         Firebase Firestore
State Management Bloc
Content Fetching	NewsAPI 
Bonuses :
1. Implement Google Sign-in for user authentication.
2. Add loading indicators during API calls or while fetching dynamic content.
3. Use animations for smooth transitions between screens and loading states.
📸 Screenshots
Add screenshots here by placing images in your repo and linking them like:
![Screenshot_20250321-005938](https://github.com/user-attachments/assets/1662863b-e0b3-4127-8caf-805c8ed3a4e6)
![Screenshot 2025-03-21 005359](https://github.com/user-attachments/assets/ba4e0cd8-a806-420c-af4a-06781bb6dad5)
📦 Setup Instructions
Clone the repo:

git clone https://github.com/Zead-Fekry/newsletter-app.git
cd newsletter-app
Install dependencies:

flutter pub get
Setup Firebase:

Create a Firebase project.
Enable Authentication (Email/Password).
Enable google sign in
Enable Firestore for storing user interests.
Enable Dynamic Links for deep linking.
Download the google-services.json (Android) and GoogleService-Info.plist (iOS) and place them in the respective folders.
Run the app:
flutter run
🎥 Demo Video
