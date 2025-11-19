// course_data.dart

import 'course.dart'; // Import the new model

class CourseData {
  static const List<Course> allCourses = [
    Course(
      id:1,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3sHqg6J4v2k3Y-wVw4i3r-xY_8-iM_5nJgA&s",
      title: "Mobile UI Design",
      description: "Master the art of creating beautiful and functional user interfaces for mobile apps.",
      youtubeUrl: "https://www.youtube.com/watch?v=ABCDEFG",  // <-- VIDEO

    ),
    Course(
      id: 2,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6sEwXl8Y_kP5n_3Pz9O8y5lC0j0J5kZ0fFw&s",
      title: "Dart Fundamentals",
      description: "A comprehensive introduction to the Dart programming language, essential for Flutter development.",
      youtubeUrl: "https://www.youtube.com/watch?v=ABCDEFG",  // <-- VIDEO

    ),
    Course(
      id: 3,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6-pY_gqC0s-VfJ7F4N5w0i3r-xY_8-iM_5nJgA&s",
      title: "Advanced Flutter",
      description: "Learn professional state management and testing in Dart/Flutter with provider and bloc.",
      youtubeUrl: "https://www.youtube.com/watch?v=ABCDEFG",  // <-- VIDEO
    ),
    Course(
      id: 4,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d2Yg-gTqj8mX9h_9fQ9R0O_5pZ0vW_0hJ0&s",
      title: "Testing & CI/CD",
      description: "Implement unit, widget, and integration tests, and set up automated deployment pipelines.",
      youtubeUrl: "https://www.youtube.com/watch?v=ABCDEFG",  // <-- VIDEO
    ),
    Course(
      id: 5,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYx6SXFDF2-gDyB8wDJpR6I8A5EJDVhh5Dcw&s",
      title: "Firebase Integration",
      description: "Integrate Flutter applications with Firebase for authentication, database, and cloud functions.",
      youtubeUrl: "https://www.youtube.com/watch?v=ABCDEFG",  // <-- VIDEO
    ),
    Course(
      id: 6,
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7wJ9m3lX4c6_9-lM_5pZ0vW_0hJ0&s",
      title: "APIs & Networking",
      description: "Handle network requests, serialize JSON data, and manage API communication in Flutter.",
      youtubeUrl: "https://www.youtube.com/watch?v=ABCDEFG",  // <-- VIDEO
    ),
  ];
}