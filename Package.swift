// swift-tools-version: 5.10
import PackageDescription

// Wren is built from the shared codebase pinned as the `core` submodule (the Parrot repo).
// This manifest compiles those sources directly so the Wren repo is a real Swift package
// (`swift build` works here, and GitHub recognizes it as Swift). The signed .app bundle is
// produced by `./build.sh` → `core/build-app.sh`, which selects the Wren identity
// (com.thousandflowers.wren → AppMode.wren). One codebase, two products.
let package = Package(
    name: "Wren",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "Parrot", targets: ["Parrot"]),
        .executable(name: "ParrotCompletionHelper", targets: ["ParrotCompletionHelper"])
    ],
    dependencies: [
        .package(url: "https://github.com/sparkle-project/Sparkle", from: "2.6.0"),
    ],
    targets: [
        .target(
            name: "ParrotObjC",
            path: "core/ObjCBridge",
            publicHeadersPath: "."
        ),
        .systemLibrary(name: "CLlama", path: "core/CLlama"),
        .executableTarget(
            name: "ParrotCompletionHelper",
            dependencies: ["CLlama"],
            path: "core/CompletionHelper",
            linkerSettings: [
                .unsafeFlags([
                    "-L/opt/homebrew/lib",
                    "-Xlinker", "-rpath", "-Xlinker", "@executable_path/../Frameworks",
                    "-Xlinker", "-rpath", "-Xlinker", "/opt/homebrew/lib"
                ])
            ]
        ),
        .executableTarget(
            name: "Parrot",
            dependencies: [
                .product(name: "Sparkle", package: "Sparkle"),
                "ParrotObjC",
            ],
            path: "core",
            exclude: [
                "ObjCBridge",
                "Resources/Info.plist",
                "Resources/Parrot.entitlements",
                "Resources/en.lproj",
                "Resources/it.lproj",
                "Resources/zh-Hans.lproj",
                "Resources/hr.lproj",
                "Resources/da.lproj",
                "Resources/nb.lproj",
                "Resources/el.lproj",
                "PopClip",
                "Package.swift",
                "README.md",
                "CHANGELOG.md",
                ".gitignore",
                "Tests",
                ".build",
                "setup-dev.sh",
                "build-app.sh",
                "Parrot.app",
                "Wren.app",
                "docs",
                "scripts",
                "Casks",
                "CONTRIBUTING.md",
                "PRODUCT.md",
                "Parrot.dmg",
                "appcast.xml",
                "Resources/Localizable.xcstrings",
                "Resources/Parrot-MAS.entitlements",
                "CLlama",
                "CompletionHelper",
                "Resources/MenuIcon@2x.png",
                "Resources/MenuIcon.png",
                "Resources/AppIcon.icns",
                "build-wren.sh",
                "Package.resolved",
            ],
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "@executable_path/../Frameworks"])
            ]
        )
    ]
)
