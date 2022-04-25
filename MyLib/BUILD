load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:apple.bzl", "apple_xcframework")

swift_library(
    name = "MyLibSwift",
    srcs = glob(["Sources/*.swift"]),
    module_name = "MyLib",
)

apple_xcframework(
    name = "MyLib",
    bundle_id = "com.baracoda.mylib",
    infoplists = ["Info.plist"],
    ios = {
        "simulator": [
            "arm64",
            "x86_64",
        ],
        "device": [
            "arm64",
        ],
    },
    minimum_os_versions = {"ios": "13.0"},
    deps = [
        ":MyLibSwift",
    ],
)
