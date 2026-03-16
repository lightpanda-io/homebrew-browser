# Lightpanda Homebrew Tap

Homebrew tap for the [Lightpanda browser](https://github.com/lightpanda-io/browser).

## Structure

- `Formula/lightpanda.rb` — Homebrew formula (nightly build)
- `update.sh` — local script to update formula to its latest version
- `.github/workflows/update.yml` — GitHub Actions workflow to update the formula (automatic daily + manual trigger)

## Formulas

Formula install pre-built binaries from the Lightpanda GitHub releases (nightly build):
- `lightpanda-aarch64-macos` for Apple Silicon
- `lightpanda-x86_64-macos` for Intel

The binary is installed as `lightpanda` in the Homebrew bin directory. 

## Updating the formula

**Locally**

Run `./update.sh` to update formula. It will:
1. Fetch the latest nightly release date from the GitHub API
2. Skip formula if already up to date
4. Download both binaries, compute SHA256 checksums, and patch the formula

**Github Actions**

Or trigger the GitHub Actions workflow manually from the GitHub Actions UI. The workflow also runs automatically every day at 2:10 AM UTC.

The workflow will open a pull request and merge it automatically if all checks pass. This requires **"Allow auto-merge"** to be enabled in the repo settings (Settings → General → Allow auto-merge).

## Auditing

To verify a formula passes Homebrew's strict linting rules before submitting to homebrew-core:

```sh
brew tap local/lightpanda
cp Formula/lightpanda.rb $(brew --repository)/Library/Taps/local/homebrew-browser/Formula/lightpanda.rb
brew audit --strict --formula local/lightpanda/lightpanda
brew untap local/lightpanda
```
