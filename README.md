# quick-note-ios-application
An iOS application to create, delete and prioritize the notes

## Summary
* [Introduction & General Information](#introduction--general-information)
* [Application Design](#application--design)
* [Run Locally](#run--locally)

## Introduction & General Information
- Main purpose of this iOS application is to provide a simple and clutter free user experience for creating, updating, deleting and prioritizing (i.e. favorite / star) the notes.
- This application is not yet published in the iOS app store, however it will be published soon.

## Application Design
- Quick Note iOS application is based on multi controller design, presented modally.
- This application is powered by [Google Firestore](https://cloud.google.com/firestore) in the backend.
- Some of the screenshots are shown below, which outline the design.

### Home Screen
![Home Screen](https://github.com/setu-parekh/quick-note-ios-application/blob/main/Images/home-screen.png)

### Detail Screen (Create / Update / Delete / Star or Favorite)
![Detail Screen](https://github.com/setu-parekh/quick-note-ios-application/blob/main/Images/detail-screen.png)

### View All Notes
![All Notes](https://github.com/setu-parekh/quick-note-ios-application/blob/main/Images/view-all-notes.png)

### View All Notes
![All Notes](https://github.com/setu-parekh/quick-note-ios-application/blob/main/Images/view-all-notes.png)

### View Starred Notes
![Starred Notes](https://github.com/setu-parekh/quick-note-ios-application/blob/main/Images/view-only-starred-notes.png)

### Delete Notes
![Delete Notes](https://github.com/setu-parekh/quick-note-ios-application/blob/main/Images/delete-note.png)

## Run Locally
* Make sure XCode is installed. XCode can be installed from [Mac App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12)
* Go to Terminal and clone the project: `git clone https://github.com/setu-parekh/quick-note-ios-application.git`
* Route to the cloned project: `cd quick-note-ios-application`
* Open the project files in finder window: `open .`
* Double click on: `Quick Note.xcworkspace` - which will open the whole project in XCode
* Build and run the project by pressing `CMD + R` on the keyboard
