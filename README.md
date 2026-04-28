# frankly-agenda
The Agenda Builder is an interactive tool to help people build discussion guides for use on or off Frankly. It interviews event organizers about their goals and generates customized agendas for real-time small group discourse.

The goal is to reduce the expertise barrier to building out effective discussions. Put simply, it helps organizers get from from 'I want to create a discussion' to 'I have a clear, effective agenda.'

See software architecture diagram to understand how the components go together. 

# Getting Started

## Steps to deploy
1. Build: `flutter build web --release --no-tree-shake-icons` <-- the no tree shake ensures the pdf builds properly 
2. Test locally: `python -m http.server 8000 -d build/web`
2. Deploy: `firebase deploy --only hosting`

## Steps to Deploy Cloud Function
1. `cd functions`
2. `npm install` (if you need to update packages)
3. `firebase deploy --only functions:agendaBuildEventPlan`
Note: In debug mode, app will use local emulators. If built with flutter web build, then local emulators not used. 

## Steps to Run Locally with Local Builder Package

1. In your local "frankly-agenda-builder" directory, run `npm link` 
2. In this root directory, run `npm link frankly-agenda-builder`
3. Run `cd functions && npm run build`
4. Run `firebase emulators:start` to start the emulators
5. Navigate to main.dart and press the little play button

## Helpful Commands

- `firebase login:list` - displays which firebase account you are logged in as. Helpful if you have a separate firebase account for running locally.
- `firebase login:add` - adds a new firebase account
- `firebase login:use <account_email>` - sets default firebase account for project

# Thanks
This effort was kicked off due a grant awarded during the [Plurality Institute](https://www.plurality.institute/)'s LLMs and Public Discourse event in February 2025. Thank you to everyone who voted for us!
