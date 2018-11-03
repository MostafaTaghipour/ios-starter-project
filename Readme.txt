
1. rename starter.xcworkspace , project folder and other starter folder inside it to NewName 
2. open workspace in Xcode
3. go to project navigator -> select project target -> Change The name in Identity and type replace starter with NewName
4. go to project navigator -> select project target folder -> Change The name in Identity and type replace starter with NewName
go to Development.xcconfig, Staging.xcconfig, Production.xcconfig and replace APP_NAME and APP_BUNDLE_ID
5. Close Xcode
6. Open pod file and replace 'starter' with NewName and save it
7. Open terminal in project folder and run 'pod install'
8. Open workspace in Xcode 
9. Build project




1. Clone starter repository
	git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
2. Rename starter project
	sh rename.sh
	go to project navigator -> select project target -> Change The name in Identity and type replace starter with NewName
	go to project navigator -> select project target folder -> Change The name in Identity and type replace starter with NewName
3. Install libraries
	Open terminal in project folder and run 'pod install'
4. Open workspace in Xcode and build project
* by default project contains firebase crashlytics and analytics, if you want use it you must go to firebase console , create your project , download and add GoogleService-Info.plist to project 