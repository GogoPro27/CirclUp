# Circl Up 🎉

**Circl Up** is a school project app designed to connect people through real-life events in Skopje.

### Concept
Users explore a city map with events pinned at popular venues (e.g., concerts, parties). Each event shows its title, location, and time, and users can register to attend.

### How It Works
During an event, participants are randomly paired. Each pair takes photos together and uploads them. If both photos confirm the match, the users earn points, which can later unlock rewards. Pairings can happen multiple times to ensure everyone connects.

### Features
- **Event Map** – discover and register for events.
- **Event Details** – see where and when events happen.
- **Pairing Challenges** – meet new people and earn points.
- **Profiles** – showcase photos from past events and connections.

### Vision
Circl Up encourages extroverts to step out, meet strangers, and build memories through playful challenges—turning events into opportunities for lasting friendships.  



# 📖 Documentation

## `RouteGenerator`
**Location:** `lib/screens/route_generator.dart`

- Centralized routing manager for the app.
- Exposes `generateRoute` which maps route names (`/`, `/rewards`, `/profile`, etc.) to specific screens.
- Handles unknown routes gracefully by showing a fallback `Scaffold` with an error message.

**Usage:**
```dart
Navigator.pushNamed(context, '/profile');
```

**Key Benefit:** Keeps all navigation definitions in one place, ensuring consistency.

---

## `AddFriendsScreen`
**Location:** `lib/screens/add_friends_screen.dart`

- Screen to view a user’s profile and optionally send a friend request.
- Displays:
  - Cover photo
  - Profile picture + online indicator
  - Name, bio, organization (MZT)
  - Friends count
  - Posts grid
- `isFriendRequested` toggles when pressing **Add Friend**.

**Usage:**
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => AddFriendsScreen(user: user)),
);
```

---

## `AuthGate`
**Location:** `lib/screens/auth_gate.dart`

- Wraps the app and checks Firebase authentication state.
- Uses `FirebaseAuth.instance.authStateChanges()` stream.
- Shows:
  - Loader while checking state
  - `SignInScreen` if no user
  - The real app (`signedInChild`) if authenticated.

**Usage:**
```dart
return AuthGate(signedInChild: MyApp());
```

---

## `CameraPage`
**Location:** `lib/screens/camera_page.dart`

- Simple mock camera interface.
- Displays placeholder image (`assets/camera_photo.jpg`).
- Has back button, flash toggle, flip camera icon (not functional).
- Large orange capture button triggers `onPhotoCaptured` callback.

---

## `EditScreen`
**Location:** `lib/screens/edit_screen.dart`

- Profile editing & settings hub.
- Displays:
  - Profile picture (with edit icon).
  - Options: Your Profile, Settings, Help Center, Privacy Policy, Logout.
- Integrates bottom navigation bar for app-wide navigation.
- Custom logout confirmation bottom sheet.

---

## `FavoritesScreen`
**Location:** `lib/screens/favorites_screen.dart`

- Displays user’s favorite places from **Firestore**.
- Workflow:
  1. Fetches `favoritePlaces` array from `Users/user1`.
  2. Queries `Places` collection for details of each favorite.
  3. Shows results in a `ListView`.

- Shows **loading spinner**, **error message**, or **empty state** as appropriate.

---

## `FriendsScreen`
**Location:** `lib/screens/friends_screen.dart`

- Shows a list of user’s friends.
- Each friend: profile picture, name, bio.
- Floating button → navigates to `AddFriendsScreen`.

---

## `GroupChatPage`
**Location:** `lib/screens/group_chat_page.dart`

- Mock group chat UI.
- Features:
  - Hardcoded messages with chat bubbles.
  - Distinguishes between "me" and others.
  - Disabled input field (MVP only).
- Good for demonstrating chat design.

---

## `HelpCenterScreen`
**Location:** `lib/screens/help_center_screen.dart`

- Help & support hub.
- Features:
  - Search bar.
  - Tab bar: FAQ & Contact Us.
  - FAQ section with expandable questions.
  - Contact info: Website, Customer Service, Facebook, Instagram.
- Integrated with bottom navigation bar.

---

## `HomeScreen`
**Location:** `lib/screens/home_screen.dart`

- Main event map screen (custom static map).
- Features:
  - Displays static map image of Skopje.
  - Places markers for events (`MarkerButton`).
  - Filter button with checkbox dialog.
  - **Fast Forward button** simulates time jump to event start.
  - Shows animated blinking red dot when event participation is active.
  - Cupp icon → navigates to `MatchPage`.

---

## `MapScreen`
**Location:** `lib/screens/map_screen.dart`

- Google Maps version of the event map.
- Features:
  - Loads events from mock data as `Marker`s.
  - On tap, shows sliding bottom sheet (`EventDetailsBottomSheet`).
  - Cupp icon for navigating to `MatchPage`.

---

## `MatchPage`
**Location:** `lib/screens/match_page.dart`

- Handles CirclUp matching.
- Features:
  - Randomly fetches 1–2 users from Firestore (excluding `user1`).
  - Displays matched users.
  - Take photo flow with camera & permission handling.
  - On success → navigates to `WaitingPage`.
  - Award: 100 Circles.

---

## `NotificationsScreen`
**Location:** `lib/screens/notifications_screen.dart`

- Shows list of notifications from `mockNotifications`.
- Supports:
  - Read/unread styling.
  - Actionable notifications (Accept/Decline buttons).
  - Sponsored tag display.

---

## `PrivacyPolicyScreen`
**Location:** `lib/screens/privaty_policy_screen.dart`

- Static privacy policy page.
- Contains last update date, sections on data collection, usage, and contact info.

---

## `ProfileScreen`
**Location:** `lib/screens/profile_screen.dart`

- Fetches user data from Firestore (`Users/user1`).
- Displays:
  - Cover photo, profile picture, name, bio.
  - Coins balance.
  - Buttons for Friends & Favorites (with counts).
  - Posts grid.
- AppBar → edit profile screen.

---

## `RewardsScreen`
**Location:** `lib/screens/rewards_screen.dart`

- Handles reward coupons.
- Tabs: **Redeem** vs **History**.
- Uses mock data (`mockCoupons`).
- Redeeming:
  - Deducts coins from active user.
  - Marks coupon as redeemed.
  - Shows SnackBar for success/failure.

---

## `SettingsScreen`
**Location:** `lib/screens/setting_screen.dart`

- Simple app settings page.
- Options:
  - Account Settings
  - Password Manager
  - Delete Account
- Integrated with bottom navigation.

---

## `SignInScreen`
**Location:** `lib/screens/sign_in_screen.dart`

- Handles Google sign-in with Firebase Auth.
- Shows loading state and errors.
- Styled with orange button.

---

## `SuccessPage`
**Location:** `lib/screens/success_page.dart`

- Shown after successful CirclUp match.
- Displays:
  - CirclUp logo.
  - “100 circles” reward.
  - List of matched users.

---

## `WaitingPage`
**Location:** `lib/screens/waiting_page.dart`

- Shown after taking photo with matched users.
- Simulates waiting for participants:
  - Counter increases until all have uploaded.
  - Adds 100 coins to all users in Firestore.
  - Then redirects to `SuccessPage`.
- Includes quick navigation to `GroupChatPage`.

## 🔐 Authentication Service (`auth_service.dart`)
Handles Firebase Authentication (Google Sign-In and Sign-Out).  

- **`authStateChanges`** → Stream of `User?` for listening to sign-in/sign-out state.  
- **`signInWithGoogle()`** → Prompts the user to sign in with their Google account, retrieves Firebase credential, and signs them in.  
  - Returns: `UserCredential`.  
- **`signOut()`** → Signs the user out from Google (if signed in) and Firebase.  

⚠️ Platform-aware (uses `GoogleSignIn` for Android/iOS).  

---

## 🧾 Filter Service (`filter_service.dart`)
Utility class for filtering events by category.  

- **`applyFilters(events, filters)`**  
  - Input: List of `Event` objects and a `Map<String, bool>` for active filters.  
  - Returns: Only events matching the selected filters.  
  - Special case: If `"All" == true`, returns all events without filtering.  

---

## 🎟️ Coupon Widgets
### **`coupon_details_bottom_sheet.dart`**
Displays coupon details and lets user redeem them.  
- Shows **image, description, cost, reward value**.  
- **`onRedeem` callback** triggers the redemption logic.  
- UI includes a “Use X circles” button.  

### **`coupon_view_bottom_sheet.dart`**
Displays coupon QR code for scanning/validation.  
- Shows **coupon image, description, QR code**.  
- Used after redemption to display the scannable QR code.  

---

## 🎉 Event Widgets
### **`event_details_bottom_sheet.dart`**
Displays event details in a bottom sheet.  
- Loads user favorites from Firestore (`Users → user1 → favoritePlaces`).  
- Allows toggling favorite (heart icon).  
- Shows event image, name, description, time, participants count.  
- **Participate/Cancel button** updates participation state and attendees count.  
- Callback: `onParticipationChanged` notifies parent widget when participation changes.  

### **`event_popup_card.dart`**
Displays an event card (used on map popups).  
- Similar to `EventDetailsBottomSheet`, but in a card format.  
- Allows **favoriting** and **participation toggle**.  
- Updates `attendees` count dynamically.  

---

## 🛠️ Widgets
### **`filter_button.dart`**
Reusable button for triggering filters.  
- Rounded black button with text **“Filter”** and dropdown arrow.  
- Takes a **callback** (`onPressed`).  

### **`instagram_style_navigation.dart`**
Main navigation scaffold (Instagram-like).  
- Uses **`PageView`** with 4 screens:  
  1. **MapScreen**  
  2. **RewardsScreen**  
  3. **NotificationsScreen**  
  4. **ProfileScreen**  
- **BottomNavigationBar** keeps state synced with PageView.  
- Swipe disabled → navigation controlled only by tab taps.  

### **`marker_button.dart`**
Custom map marker widget.  
- Draws a **pin-shaped marker** (orange if inactive, green if participating).  
- Displays the **place logo inside the pin**.  
- On tap: Opens `EventDetailsBottomSheet`.  

---

## 🚀 Entry Point (`main.dart`)
- Initializes **Firebase**.  
- Loads mock data (`loadMockData()`).  
- Temporary flag → forces sign out on app launch for testing.  
- Wraps app in **MaterialApp** with custom theme.  
- Uses **`AuthGate`** to decide between:
  - **Signed-in state** → `InstagramStyleNavigation`  
  - **Signed-out state** → Auth flow.  
- Defines global route generation (`RouteGenerator`).  

---

## 🧩 How it all connects
1. **User authentication** handled in `AuthService`.  
2. **Main app navigation** through `InstagramStyleNavigation`.  
3. **Events**:
   - Displayed on the map with `MarkerButton`.  
   - Open details with `EventDetailsBottomSheet` or `EventPopupCard`.  
   - Participation/favorite synced with Firestore.  
4. **Rewards**:
   - Coupons managed via `CouponDetailsBottomSheet` and `CouponViewBottomSheet`.  
5. **Filters** applied with `FilterService` and `FilterButton`.  
