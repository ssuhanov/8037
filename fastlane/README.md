fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### unit_tests_build_for_testing

```sh
[bundle exec] fastlane unit_tests_build_for_testing
```

Build Unit-tests

### unit_tests_run_without_building

```sh
[bundle exec] fastlane unit_tests_run_without_building
```

Run Unit-tests without building

### parse_unit_tests_coverage

```sh
[bundle exec] fastlane parse_unit_tests_coverage
```

Parse Unit-Tests coverage to a simple readable JSON using Slather (with Cobertura XML)

Update README.md file with the coverage percentage

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
