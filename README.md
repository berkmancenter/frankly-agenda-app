# frankly-agenda

An interactive tool to help people build discussion guides for use on or off Frankly.

See software architecture diagram to understand how the components go together. 

## Getting Started

# Steps to deploy
1. Build: `flutter build web --release --no-tree-shake-icons` <-- the no tree shake ensures the pdf builds properly 
2. Test locally: `python -m http.server 8000 -d build/web`
2. Deploy: `firebase deploy --only hosting`

# Steps to Deploy Cloud Function
1. `cd functions`
2. `npm install` (if you need to update packages)
3. `firebase deploy --only functions:agendaBuildEventPlan`
Note: In debug mode, app will use local emulators. If built with flutter web build, then local emulators not used. 

# Steps to Run Locally with Local Builder Package

1. In your local "frankly-agenda-builder" directory, run `npm link` 
2. In this root directory, run `npm link frankly-agenda-builder`
3. Run `cd functions && npm run build`
4. Run `firebase emulators:start` to start the emulators
5. Navigate to main.dart and press the little play button

# Helpful Commands

- `firebase login:list` - displays which firebase account you are logged in as. Helpful if you have a separate firebase account for running locally.
- `firebase login:add` - adds a new firebase account
- `firebase login:use <account_email>` - sets default firebase account for project

## Models
- Models use Freeze library. If you update the fields on a model, run `dart run build_runner build --delete-conflicting-outputs` to update the Freeze object. 