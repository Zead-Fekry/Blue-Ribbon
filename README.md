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
 ![Screenshot_20250321-005938](https://github.com/user-attachments/assets/1253e02d-0cb0-450a-b466-92c532a6d48e)
![Screenshot_20250321-005947](https://github.com/user-attachments/assets/7cb1344f-bc7a-4de9-9b32-97d6a6be8991)
![Screenshot_20250321-005953](https://github.com/user-attachments/assets/15f6c8ee-6b60-462a-882c-9c49e482e205)
![Screenshot_20250321-010029](https://github.com/user-attachments/assets/ca4b023f-ccb4-486e-8cbc-5e5a23b18d47)
![Screenshot_20250321-010033](https://github.com/user-attachments/assets/6d24d8a5-7dea-4dfb-a81c-d6b69ff5ac36)
![Screenshot_20250321-010040](https://github.com/user-attachments/assets/ec14dd0c-1f54-40af-bb66-ba60b958c133)
![Screenshot_20250321-010058](https://github.com/user-attachments/assets/a794cbf6-9ad8-4ac4-a6c9-8e0b7f6100a3)
![Screenshot_20250321-010123](https://github.com/user-attachments/assets/d6ee6e96-271d-4207-9ca0-6f892444e5b9)
![Screenshot_20250321-010127](https://github.com/user-attachments/assets/0c99d5e9-b901-45a8-934f-a9bb68c5f8c1)
![Screenshot_20250321-010134](https://github.com/user-attachments/assets/64edc132-1a7f-4a39-bdba-f74b697190be)
![Screenshot 2025-03-21 005359](https://github.com/user-attachments/assets/7e3719e1-37b1-4e32-a656-614bcbc9c1b9)
![Screenshot 2025-03-21 005445](https://github.com/user-attachments/assets/a664acfb-eb65-4c17-bb59-0148a45ce5b2)
![Screenshot 2025-03-21 005507](https://github.com/user-attachments/assets/cd63966d-d3e6-42fc-961f-97b52f044364)
![Screenshot 2025-03-21 005613](https://github.com/user-attachments/assets/a0091dcb-52d2-46e5-8296-ca5cdf860370)
![Screenshot 2025-03-21 005642](https://github.com/user-attachments/assets/3fe696b5-2bc6-4465-a850-470129098da0)
![Screenshot 2025-03-21 005721](https://github.com/user-attachments/assets/b24abd04-0ce0-4242-8e0f-ddb509d3ce8f)
![Screenshot 2025-03-21 005752](https://github.com/user-attachments/assets/6df91ea0-4dce-4907-8a68-28377f42ffbf)

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
 
