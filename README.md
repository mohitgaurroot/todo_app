# todo_app
## Purpose
- This Flutter application is a simple Todo List Manager that allows users to create, read, update, and delete todo items. 
- Each item has a title and a completion status. 
- The app uses SQLite for data persistence and the BLoC pattern for state management. 
- The user interface is designed to be simple and intuitive.

## Setup
1. Clone the Repository
    git clone <repository-url>
2. Run the following command to fetch the necessary dependencies
    flutter pub get

## Run/Execute
First of all, Flutter, along with the programming language Dart, needs to be installed on the system. The Flutter SDK can be downloaded from https://flutter.dev/docs/get-started/install. Note, the Dart SDK is bundled with Flutter; it is not necessary to install Dart separately. The command `flutter doctor` can come in handy to check if everything is set up correctly.

Once everything is set up, use the cli command `flutter run` to run the app in debug mode on a connected device.

Note: the app can only be run on iOS devices using a mac equipped with Xcode.

## State Management Approach
**BLoC Pattern**
- The app uses the BLoC (Business Logic Component) pattern to manage state. 
- The BLoC pattern helps separate the business logic from the UI

**Structure**
- Events (todo_event.dart): Define events that represent actions, such as loading todos, adding a todo, updating a todo, and deleting a todo.
- States (todo_state.dart): Represent the different states of the application, such as loading, loaded, and error states.
- BLoC (todo_bloc.dart): The core of the pattern, responsible for receiving events and emitting states. The BLoC processes events and performs the necessary business logic, such as database operations.