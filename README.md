# do-quran
Dongkap | Al Qur'an Mobile Application with Flutter (Android & iOS)

```

   __| |   ___    _ __     __ _  | | __   __ _   _ __  
  / _` |  / _ \  | '_ \   / _` | | |/ /  / _` | | '_ \ 
 | (_| | | (_) | | | | | | (_| | |   <  | (_| | | |_) |
  \__,_|  \___/  |_| |_|  \__, | |_|\_\  \__,_| | .__/ 
                          |___/                 |_|    

```

## Features
* __Al-Qur'an & Translations__

* __Prayer Schedules__

* __Qiblah__

## Environment setup
Make sure following software is installed on your PC.
* [Flutter 1.22.3](https://github.com/flutter/flutter.git) or later
* [Android Studio](https://developer.android.com/studio)
* [Visual Studio Code](https://code.visualstudio.com/download)


## Compile & Test
* __Development__

  * Download Packages :
	```
	do_quran$ flutter pub get
	```
	Click __Get Packages__ located in right side of the action ribbon at the top of pubspec.yaml.

  * Generate Json Models :
	```
	do_quran$ flutter pub run build_runner build --delete-conflicting-outputs
	```
	```
	do_quran/packages/do_core$ flutter pub run build_runner build --delete-conflicting-outputs
	```

  * Pub Activate Encrypt (_skip_) :
	```
	do_quran$ flutter pub global activate encrypt
	```

  * Restart the Dart Analysis Server (VS Code) :

  	`CTRL + Shift + P` , then search look for a command called `Dart: Restart Analysis Server`
	```
	do_quran$ flutter analyze
	```

  * Run Application :
	```
	do_quran$ flutter run
	```
	or press __F5__ in Visual Studio Code

* __API__
  
  Please testing with [Dongkap Java API](https://github.com/ridlafadilah/do-api)

  > :warning: _If you are using the Dongkap Develpoment API, sometimes the connection to the server may timeout._

## How can I support?
  * Star Dongkap GitHub repo :star:
  * Create pull requests, submit bugs, suggest new features
  * If this project help you reduce time to develop, you can give me a cup of coffee :smiley:
    
    [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](http://paypal.me/ridlafadilah)
	
	[![Buy Me A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/ridlafadilah)
