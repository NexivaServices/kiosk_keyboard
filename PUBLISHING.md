# Publishing Guide for kiosk_keyboard

This guide will help you publish your package to pub.dev.

## Pre-Publishing Checklist

✅ Package structure is complete
✅ All required files are present (pubspec.yaml, README.md, LICENSE, CHANGELOG.md)
✅ Example app is included
✅ Package validates with 0 warnings

## Before Publishing

### 1. Update Package Metadata

Edit `pubspec.yaml` and update these fields:

```yaml
name: kiosk_keyboard # Change if needed
description: A customizable on-screen keyboard widget for Flutter kiosk applications with support for numeric, text, and alphanumeric input modes.
version: 1.0.0 # Your version
homepage: https://github.com/yourusername/kiosk_keyboard # Your GitHub URL
repository: https://github.com/yourusername/kiosk_keyboard # Your repo URL
issue_tracker: https://github.com/yourusername/kiosk_keyboard/issues # Your issues URL
```

### 2. Create a GitHub Repository (Recommended)

1. Go to https://github.com/new
2. Create a new repository named `kiosk_keyboard`
3. Initialize the repository:

```bash
cd d:\Projects\kiosk_keyboard
git init
git add .
git commit -m "Initial commit - kiosk_keyboard package v1.0.0"
git branch -M main
git remote add origin https://github.com/yourusername/kiosk_keyboard.git
git push -u origin main
```

### 3. Clean Up (Optional)

The root directory contains the original files that are now in lib/. You can delete them:

```bash
Remove-Item keyboard.dart
Remove-Item keyboard_example.dart
```

## Publishing Steps

### Step 1: Verify Package

Run the dry-run command to validate:

```bash
flutter pub publish --dry-run
```

You should see: "Package has 0 warnings."

### Step 2: Authenticate with pub.dev

If this is your first time publishing:

```bash
flutter pub login
```

This will open a browser for authentication with your Google account.

### Step 3: Publish!

```bash
flutter pub publish
```

You'll be asked to confirm. Type 'y' to proceed.

## After Publishing

### Update Version Number for Future Releases

When you make changes, update the version in `pubspec.yaml` following semantic versioning:

- **Major** (1.0.0 → 2.0.0): Breaking changes
- **Minor** (1.0.0 → 1.1.0): New features, backward compatible
- **Patch** (1.0.0 → 1.0.1): Bug fixes

Also update `CHANGELOG.md` with the changes.

### Publishing Updates

1. Make your changes
2. Update version in `pubspec.yaml`
3. Update `CHANGELOG.md`
4. Run `flutter pub publish --dry-run`
5. Run `flutter pub publish`

## Package Structure

```
kiosk_keyboard/
├── lib/
│   ├── kiosk_keyboard.dart         # Main export file
│   └── src/
│       └── kiosk_keyboard.dart     # Implementation
├── example/
│   ├── lib/
│   │   └── main.dart               # Example app
│   ├── pubspec.yaml
│   └── README.md
├── pubspec.yaml                    # Package metadata
├── README.md                       # Documentation
├── CHANGELOG.md                    # Version history
├── LICENSE                         # MIT License
├── analysis_options.yaml           # Linter rules
└── .gitignore                      # Git ignore rules
```

## Useful Commands

```bash
# Get dependencies
flutter pub get

# Run analyzer
flutter analyze

# Format code
dart format .

# Run example
cd example
flutter run

# Check for outdated dependencies
flutter pub outdated

# Upgrade dependencies
flutter pub upgrade
```

## Important Notes

1. **Package Name**: Must be unique on pub.dev. Search first at https://pub.dev
2. **Version**: Start with 1.0.0 for your first stable release
3. **License**: Current license is MIT (most common for open source)
4. **Description**: Must be between 60-180 characters
5. **Breaking Changes**: Major version bump required (e.g., 1.x.x → 2.0.0)

## Resources

- [Publishing packages](https://dart.dev/tools/pub/publishing)
- [Package layout conventions](https://dart.dev/tools/pub/package-layout)
- [Verified publishers](https://dart.dev/tools/pub/verified-publishers)
- [Semantic versioning](https://semver.org/)

## Support

After publishing, users can find your package at:
`https://pub.dev/packages/kiosk_keyboard`

Good luck with your package! 🚀
