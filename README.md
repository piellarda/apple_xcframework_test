## Requirements
- [bazelisk](https://github.com/bazelbuild/bazelisk) to run Bazel or Bazel 5.1.1
- Xcode
- Bundler

## Mylib
This is a Bazel package that declares an `apple_xcframework` depending on a `swift_library`.

## MyTestApp
This is a Xcode project for an iOS application that embeds the MyLib XCFramework.

## How to use
- Open the Xcode project inside MyTestApp and add your AdHoc provisioning profile for release build.
- Run `bundle install` to install fastlane.
- Run `bundle exec fastlane build` to invoke Bazel and archive the iOS application.