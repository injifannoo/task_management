#Task Management App

This is a simple Task Management App built with Flutter that allows users to manage tasks, set due dates, and keep track of completed tasks. The app also integrates motivational quotes fetched from an external API and supports local notifications for task reminders. It uses the MVC pattern and is implemented with clean, maintainable code.

**Features**
 - Add/Edit Tasks: Users can create new tasks or edit existing ones with the following fields:

    - Title
    * Description
    + Due Date (with a date picker)
    - Task Status (Completed/Incomplete)
    * Task List: Displays a list of tasks with their title, description, due date and time, and status (completed or incomplete).

* Navigation Drawer: Access to the following screens:

- Home (Task List)
+ Completed Tasks
- Settings (for toggling between light and dark mode)
* Local Storage: Tasks are persisted locally using shared_preferences, so they remain available even when the app is closed and reopened.

**API Integration:**
 The app fetches a random motivational quote from an external API (TypeFit Quotes API) and displays it on the home screen.

**Local Notifications:** The app reminds users of tasks due soon using local notifications, implemented with flutter_local_notifications.

**Dark Mode:** Users can toggle between light and dark themes.

**Screenshots**
You can get screenshoots of home screen, completed tasks, navigation drawer from ```task_management/assets/screenshoots.```

**Folder Structure**
```
lib/
├── controllers/
│   ├── task_controller.dart          # Handles task management logic
│   └── theme_controller.dart         # Manages theme switching (light/dark mode)
├── models/
│   └── task_model.dart               # Task data model
├── services/
│   ├── api_service.dart              # Fetches quotes from external API
│   ├── local_storage_service.dart    # Handles local storage (shared_preferences)
│   └── notification_service.dart     # Manages task notifications
├── views/
│   ├── home_screen.dart              # Displays task list and quote
│   ├── edit_task_screen.dart     # Edit task form
│   ├── add_screen.dart     # Add task form
│   ├── completed_tasks_screen.dart   # Displays completed tasks
│   ├── settings_screen.dart          # Settings for theme toggling
│   └── widgets/
│       ├── task_item.dart            # Single task list item
│       └── navigation_drawer.dart    # Navigation drawer component
├── main.dart                          # Entry point of the app
```

##Installation and Setup
###Prerequisites
**Flutter:** Ensure you have Flutter installed. You can follow the installation guide here.

IDE: Use an IDE like Android Studio, or VS Code

##Steps to run the project
**Clone the repository:**

```
git clone https://github.com/injifannoo/task-management-app.git
cd task-management-app
```

**Install dependencies:**

In the project root, run the following command to install dependencies:

```
flutter pub get
```

**Run the app:**

Use the following command to run the app on an emulator or a connected device:

```
flutter run
```

**Build the app (Optional):**

If you want to build the app for release, run the following command:

```
flutter build apk
```

**Dependencies**
***Flutter Local Notifications:*** Used for scheduling and showing local notifications.

flutter_local_notifications
***Shared Preferences:*** Used for storing tasks locally on the device.

shared_preferences
***Provider:*** Used for state management.

provider
***HTTP:*** Used for fetching quotes from the API.

http

**API**
The app uses the TypeFit Quotes API to fetch motivational quotes. A random quote is displayed on the home screen every time the user opens the app.

**Notifications**
The app uses flutter_local_notifications to schedule notifications for tasks that are due soon (within 1 hour). Notifications are scheduled using the NotificationService class in notification_service.dart.

**State Management**
The app uses the Provider package for state management, which ensures the app's state is properly handled and updated when tasks are added, edited, or deleted.

**Future Improvements**
Task Prioritization: Add the ability to prioritize tasks (e.g., low, medium, high).
Sync with Cloud: Implement cloud-based storage to sync tasks across devices.
User Authentication: Add user authentication to enable personalized task management.
Contribution
Feel free to contribute to this project by creating a pull request. Please ensure that your code is well-documented and follows best practices.

**License**