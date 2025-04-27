#!/bin/bash

# **** Update me when new Xcode versions are released! ****
IOS_PLATFORM="platform=iOS Simulator,OS=18.2,name=iPhone 16"
IOS_SDK="iphonesimulator"
MACOS_PLATFORM="platform=macOS"
MACOS_SDK="macosx"


# It is pitch black.
set -e
function trap_handler() {
    echo -e "\n\nOh no! You walked directly into the slavering fangs of a lurking grue!"
    echo "**** You have died ****"
    exit 255
}
trap trap_handler INT TERM EXIT


MODE="$1"

if [ "$MODE" = "build" ]; then
    echo "Building Localize-Swift for iOS."
    xcodebuild \
        -project Localize_Swift.xcodeproj \
        -scheme Localize_Swift \
        -sdk "$IOS_SDK" \
        -destination "$IOS_PLATFORM" \
        build

    echo "Building Localize-Swift for macOS."
    xcodebuild \
        -project Localize_Swift.xcodeproj \
        -scheme "Localize_Swift OSX" \
        -sdk "$MACOS_SDK" \
        -destination "$MACOS_PLATFORM" \
        build
    trap - EXIT
    exit 0
fi

if [ "$MODE" = "examples" ]; then
    echo "Building and testing all Localize-Swift examples."

    for example in examples/*/; do
        echo "Building $example."
        pod install --project-directory=$example
        xcodebuild \
            -workspace "${example}Sample.xcworkspace" \
            -scheme Sample \
            -sdk "$IOS_SDK" \
            -destination "$IOS_PLATFORM" \
            build test
    done
    trap - EXIT
    exit 0
fi

echo "Unrecognised mode '$MODE'."
