#!/bin/bash

set -eou pipefail

script_path="$(cd -P "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
readonly script_path

readonly project_path="$script_path/MyLib.xcodeproj"
readonly target_name=MyLib

echo "Building target $target_name"

readonly build_path="$script_path/.build"
readonly derived_data_path="$build_path/derived_data"
readonly output_path="$build_path/output/"
readonly product_path="$derived_data_path/Build/Products"

readonly configuration="Release"
readonly device_sdk="iphoneos"
readonly simulator_sdk="iphonesimulator"

# Build the framework for device.
xcodebuild clean archive \
	-project "$project_path" \
	-scheme "$target_name" \
	-configuration "$configuration" \
	-sdk $device_sdk \
	-destination "generic/platform=iOS" \
	-derivedDataPath "$derived_data_path" \
	-archivePath "$output_path/$device_sdk" \
	SKIP_INSTALL=NO \
	BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# Build the framework for simulator.
xcodebuild clean archive \
	-project "$project_path" \
	-scheme "$target_name" \
	-configuration "$configuration" \
	-sdk $simulator_sdk \
	-destination "generic/platform=iOS Simulator" \
	-derivedDataPath "$derived_data_path" \
	-archivePath "$output_path/$simulator_sdk" \
	SKIP_INSTALL=NO \
	BUILD_LIBRARY_FOR_DISTRIBUTION=YES

readonly xcframework_path="${output_path}/${target_name}.xcframework"

rm -rf "$xcframework_path"

xcrun xcodebuild -create-xcframework \
	-framework "$output_path/$device_sdk.xcarchive/Products/Library/Frameworks/${target_name}.framework" \
	-framework "$output_path/$simulator_sdk.xcarchive/Products/Library/Frameworks/${target_name}.framework" \
	-output "$xcframework_path"
