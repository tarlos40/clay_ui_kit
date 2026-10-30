# Changelog

All notable changes to **Clay UI Kit** will be documented in this file.

This project follows [Semantic Versioning](https://semver.org/).

## [1.0.3] - 2026-10-30

### Added

- Completed the online documentation for all foundations and components, including examples, previews, and property references
- Expanded the README with installation, quick start, theming, screen composition, forms, and a component catalog
- Added dedicated documentation pages and catalog entries for the available component and foundation families

### Improved

- Documented tab selection, disabled tabs, swipe navigation, and integration with scaffold-managed page bodies
- Clarified theme palette configuration and semantic color token usage

### Fixed

- Tapping the scaffold background now clears the active focus scope, preventing a dismissed text input keyboard from reopening after returning from another route

### Notes

- The package documentation is now complete for the currently published foundations and components

## [1.0.2] - 2026-10-29

### Added

- Reusable component documentation flow using a single generic screen
- Per-component documentation entries can be defined in dedicated Dart files
- Showcase supports custom file names, code language labels and copy toast messages
- Code panel now includes syntax highlighting with a VS Code / Dracula-inspired editor style
- Toast feedback for copy actions through the library toast system

### Improved

- Fixed showcase runtime errors for null `codeLanguage` and missing file names
- Prevented layout overflow when long file names are used in the code header
- Improved code panel header layout and copy button visual consistency
- Hardened showcase rendering for long labels and missing optional values
- Cleaned up toast visuals by removing underline-like visual artifacts from text content
- Toasts now have a cleaner, more minimal visual treatment without noisy decorative lines

### Fixed

- Fixed null access errors in `ClayShowcase` copy action and code header generation
- Fixed copy feedback so it uses `ClayToast.success` instead of ad-hoc snackbars
- Fixed Dark theme code block consistency for the showcase editor panel
- Fixed documentation example routes and component registry usage issues

### Notes

- Documentation system is now easier to extend by adding new component doc files without rewriting the screen shell
- This release focuses on polish, maintainability and the showcase/editor experience for component docs

## [1.0.1] - 2026-10-20

### Added

- Showcase can now display just the code, with no mandatory preview required
- First documented version hosted for the user

### Improved

- Scaffold now accept any widget, while preserving animations
- Now all components accept any icon library
- Fixed a bug with the search input icon

### Notes

- The framework documentation is currently under development and will be fully available in upcoming updates-stay tuned for more...

## [1.0.0] - 2026-10-16

### Added

- Initial stable release of Clay UI Kit.
- Claymorphism-inspired design system for Flutter.
- Customizable themes with light and dark mode support.
- Color palettes and theme color customization.
- Reusable UI components with consistent visual styling.
- Animated interactions and smooth transitions.
- Custom backgrounds with gradient support.
- Layout and navigation components.
- Input fields and interactive form controls.
- Data display and feedback components.
- Loading indicators and animated skeletons.
- Image viewing and carousel components.
- Date selection and file upload components.

### Improved

- Consistent visual language across components.
- Flexible component customization.
- Improved developer experience through a unified package API.

### Notes

- First stable release.
- Public API and features are subject to future improvements.
- Bug reports, suggestions, and contributions are welcome.
