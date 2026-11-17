class ContactHandler {
  ContactHandler._();

  static const String email = "writetoranjanaryan@gmail.com";
  static const String mailto = "mailto:$email";

  static const String github = "https://github.com/justary27";
  static const String linkedin = "https://www.linkedin.com/in/justary27";
  static const String x = "https://x.com/JustAry27";
  static const String instagram = "https://www.instagram.com/justary27/";
  static const String youtube = "https://www.youtube.com/@justary27";
  // YouTube Music's home until the profile URL is in.
  static const String youtubeMusic = "https://music.youtube.com/";

  // Absolute URL: a bare path would be treated as an in-app route.
  static String get resumeUrl =>
      Uri.base.resolve("/assets/assets/resume.pdf").toString();
}
