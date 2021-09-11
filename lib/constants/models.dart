import 'package:helthy/models/MentalExercise.dart';

List<MentalExercise> kMentalExercisesList = [
  MentalExercise(
      audioUrl:
          "https://www.helpguide.org/wp-content/uploads/deep-breathing-meditation-with-music.mp3",
      assetUrl: "deep-breathing-meditation-with-music.mp3",
      title: "Deep Breathing",
      duration: Duration(minutes: 3, seconds: 41),
      description:
          "When we’re stressed or anxious, our breathing becomes more rapid and shallow. This in turn, makes us feel even worse—triggering symptoms such as dizziness, light-headedness, and shortness of breath. This deep breathing exercise helps you slow your breathing down and relax both physically and mentally. It’s simple to learn and, best of all, it’s something you can easily practice any time and anywhere."),
  MentalExercise(
      audioUrl:
          "https://www.helpguide.org/wp-content/uploads/sleep-meditation-using-guided-imagery.mp3",
      assetUrl: "sleep-meditation-using-guided-imagery.mp3",
      duration: Duration(minutes: 10, seconds: 21),
      title: "Imagery Meditation",
      description:
          "In this guided sleep meditation, you’ll start with deep breathing to relax your body, followed by a visualization exercise that will transport you into a peaceful nighttime scene."),
  MentalExercise(
      audioUrl:
          "https://www.helpguide.org/wp-content/uploads/body-scan-meditation-with-music.mp3",
      assetUrl: "body-scan-meditation-with-music.mp3",
      title: "Body Scan",
      duration: Duration(minutes: 13, seconds: 31),
      description:
          "The body scan is one of the most effective ways to begin a mindfulness meditation practice. The purpose is to tune in to your body—to reconnect to your physical self—and notice any sensations you’re feeling without judgement. While many people find the body scan relaxing, relaxation is not the primary goal. The goal is to train the mind to be more open and aware of sensory experiences—and ultimately, more accepting. With time and practice, the body scan will build your ability to focus and be fully present in your life."),
  MentalExercise(
      audioUrl:
          "https://www.helpguide.org/wp-content/uploads/mindful-breathing-meditation-with-music.mp3",
      assetUrl: "mindful-breathing-meditation-with-music.mp3",
      duration: Duration(minutes: 9, seconds: 14),
      title: "Mindful Breathing",
      description:
          "Mindful breathing is a very basic yet powerful mindfulness meditation practice. The idea is simply to focus your attention on your breathing—to its natural rhythm and flow and the way it feels on each inhale and exhale. Focusing on the breath is particularly helpful because it serves as an anchor–something you can turn your attention to at any time if you start to feel stressed or carried away by negative emotions."),
  MentalExercise(
      duration: Duration(minutes: 15, seconds: 15),
      audioUrl:
          "https://www.helpguide.org/wp-content/uploads/progressive-muscle-relaxation-meditation-with-music.mp3",
      assetUrl: "progressive-muscle-relaxation-meditation-with-music.mp3",
      title: "Muscle Relaxation",
      description:
          "When you’re experiencing anxiety, stress, or worry, one of the ways your body responds is by tightening up. Progressive muscle relaxation is a relaxation technique that helps you release the tension you’re holding in your body and feel more relaxed and calm. The technique is simple: working through the body, tense one muscle group at a time and then release the tension and notice the contrasting feeling of relaxation. Not only does progressive muscle relaxation help relieve anxiety in the moment, but with regular practice, it can also lower your overall tension and stress levels."),
  MentalExercise(
      audioUrl:
          "https://enlightenedaudio.com/sites/default/files/A-Pure-Embrace-Sample.mp3",
      assetUrl: "MeditationMusic.mp3",
      duration: Duration(minutes: 5),
      title: "Freeform Meditation",
      description: "Hello")
];

Map<String, String> codeName = {
  "Deep Breathing": "DB",
  "Imagery Meditation": "IM",
  "Body Scan": "BS",
  "Mindful Breathing": "MB",
  "Muscle Relaxation": "MR",
  "Freeform Meditation": "FM",
};

List<String> quotes = [
  "You don’t have to control your thoughts. You just have to stop letting them control you",
  "Take your time healing, as long as you want. Nobody else knows what you’ve been through. How could they know how long it will take to heal you?",
  "One small crack does not mean that you are broken, it means that you were put to the test and you didn’t fall apart.” — Linda Poindexter",
  "Sometimes you climb out of bed in the morning and you think, I’m not going to make it, but you laugh inside — remembering all the times you’ve felt that way.” — Charles Bukowski",
  "There is hope, even when your brain tells you there isn’t.” — John Green",
  "Out of suffering have emerged the strongest souls; the most massive characters are seared with scars.” — Kahlil Gibran",
  "Recovery is not one and done. It is a lifelong journey that takes place one day, one step at a time.” — Unknown",
  "Self-care is how you take your power back.” — Lalah Delia",
  "Let your story go. Allow yourself to be present with who you are right now.” – Russ Kyle",
  "My dark days made me strong. Or maybe I already was strong, and they made me prove it.” — Emery Lord",
  "You can’t control everything. Sometimes you just need to relax and have faith that things will work out. Let go a little and just let life happen.” — Kody Keplinger",
  "Your illness is not your identity. Your chemistry is not your character.” — Rick Warren",
  "Happiness can be found even in the darkest of times, if one only remembers to turn on the light.” — Albus Dumbledore",
  "Emotional pain is not something that should be hidden away and never spoken about. There is truth in your pain, there is growth in your pain, but only if it’s first brought out into the open.” — Steven Aitchison",
  "You, yourself, as much as anybody in the entire universe, deserve your love and affection.” — Buddha",
];
