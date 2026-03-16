# homebrew-browser

Homebrew tap for [Lightpanda](https://github.com/lightpanda-io/browser), a headless browser for AI agents and automation.

## Install

**Stable:**
```sh
brew install lightpanda-io/browser/lightpanda
```

**Nightly:**
```sh
brew install lightpanda-io/browser/lightpanda-nightly
```

> The stable and nightly formulas conflict — only one can be installed at a time.

You can alternatively first add the tap:

``` sh
brew tap lightpanda-io/browser
```

And the install the binary

``` sh
# stable
brew install lightpanda

# or nightly
brew install lightpanda-nightly
```

## Updating formulas

**Stable** — trigger manually from the GitHub Actions UI:
[Update Stable Formula](../../actions/workflows/update-stable.yml)

**Nightly** — runs automatically every day at 2:10 AM UTC, or can be triggered manually:
[Update Nightly Formula](../../actions/workflows/update-nightly.yml)

Both workflows open a pull request.
For nightly only it will also merge it automatically if all checks pass.
