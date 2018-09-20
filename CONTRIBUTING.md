# Contributing to _AURASlideshow_

The following is a set of guidelines for contributing to _AURASlideshow_ on GitHub.

> Above all, thank you for your interest in the project and for taking the time to contribute! 👍

## I want to report a problem or ask a question

Before submitting a new GitHub issue, please make sure to

- Search for [existing GitHub issues](https://github.com/alexaubry/uti/issues).

If the above doesn't help, please [submit an issue](https://github.com/alexaubry/uti/issues) on GitHub.

## I want to contribute to _AURASlideshow_

### Prerequisites

To develop _AURASlideshow_, you will need to use an Xcode version compatible with the Swift version specified in the [README](https://github.com/alexaubry/AURASlideshow/#contributing).

### Checking out the repository

- Click the “Fork” button in the upper right corner of repo
- Clone your fork:
    - `git clone https://github.com/<YOUR_GITHUB_USERNAME>/AURASlideshow.git`
- Create a new branch to work on:
    - `git checkout -b <YOUR_BRANCH_NAME>`
    - A good name for a branch describes the thing you’ll be working on, e.g. `fix-crash`, etc.

That’s it! Now you’re ready to work on _AURASlideshow_. Open the `AURASlideshow.xcodeproj` workspace to start coding.

### Things to keep in mind

- Always document new public methods and properties

### Testing your local changes

Before opening a pull request, please make sure your changes don't break things.

- Make sure you test your changes with VoiceOver
- The framework and test host should build without warnings
- Add tests for any feature you add or bug you fix

### Submitting the PR

When the coding is done and you’ve finished testing your changes, you are ready to submit the PR to the [main repo](https://github.com/alexaubry/AURASlideshow). Some best practices are:

- Use a descriptive title
- Link the issues that are related to your PR in the body

## Code of Conduct

Help us keep _AURASlideshow_ open and inclusive. Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.

_These contribution guidelines were adapted from [_fastlane_](https://github.com/fastlane/fastlane) guides._
