# frankly-agenda

An interactive tool to help people build discussion guides for use on or off Frankly.

## Getting Started

# Steps to deploy

1. Run `flutter build web`
2. Run `firebase deploy --only hosting:frankly-agenda`

# Steps to Run Locally with Local Builder Package

1. In your local "frankly-agenda-builder" directory, run `npm link` 
2. In this root directory, run `npm link frankly-agenda-builder`
3. Run `firebase deploy --only functions`
4. Run `firebase emulators:start` to start the emulators
5. Navigate to main.dart and press the little play button
