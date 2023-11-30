#!/bin/
echo "build adhoc IPA + APK + Upload "
set -e
file=$(cat pubspec.yaml)
fullVersion=$(echo | grep -i -e "version: " pubspec.yaml)
buildName=$(echo $fullVersion | cut -d " " -f 2 | cut -d "+" -f 1)
buildNumber=$(echo $fullVersion | cut -d "+" -f 2 )
echo "$fullVersion BUILD_NAME ${buildName} BUILD_NUMBER ${buildNumber}"


flutterSDK=flutter

exportPlist="./zz_other_files/Adhoc_IPA_ExportOptions.plist"
ipaFile="./build/ios/ipa/darzi_seller.ipa"
apkFile="./build/app/outputs/flutter-apk/app-release.apk"
androidBuild="$flutterSDK --no-color build apk  --build-number=$buildNumber --build-name=$buildName --release --dart-define=APP_ENV=qa   "
iosBuild="$flutterSDK  --no-color build ipa --build-number=$buildNumber --build-name=$buildName  --release  --dart-define=APP_ENV=qa     --export-options-plist=$exportPlist"
uploadJS_Android="node /Users/shakir/hostAPkIpaAdmin/upload.js happy_gifts  $apkFile"
uploadJS_IOS="node /Users/shakir/hostAPkIpaAdmin/upload.js happy_gifts $ipaFile"
#dart run build_runner build --delete-conflicting-outputs
#$flutterSDK clean
#$iosBuild
#$androidBuild
$uploadJS_IOS
$uploadJS_Android


say completed

