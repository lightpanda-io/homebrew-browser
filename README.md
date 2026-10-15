# homebrew-browser

Homebrew tap for [Lightpanda](https://github.com/lightpanda-io/browser), a headless browser for AI agents and automation.

## Install

```sh
brew install lightpanda-io/browser/lightpanda
```

You can alternatively first add the tap:

``` sh
brew tap lightpanda-io/browser
```

And the install the binary

``` sh
brew install lightpanda
```

### Nightly build

The `lightpanda` formula installs the latest tagged release.
To install the nightly build instead:

```sh
brew install lightpanda-io/browser/lightpanda-nightly
```

Both formulas install the `lightpanda` binary, so you can install only one at a time.

**Note:** the `lightpanda` formula used to install the nightly build.
If you installed it before, `brew upgrade` moves you to the latest tagged release.
To stay on the nightly build, switch to `lightpanda-nightly`:

```sh
brew uninstall lightpanda
brew install lightpanda-io/browser/lightpanda-nightly
```

## Updating formula

A github action is triggered by the [browser](https://github.com/lightpanda-io/browser)
repository once a release is built, and can also be triggered manually:
[Update Formula](../../actions/workflows/update.yml)

- the `nightly` tag updates `lightpanda-nightly`;
- any other tag updates `lightpanda`, if it is the latest release.

It will open a pull request and merge it right away.
