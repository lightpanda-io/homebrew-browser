# Lightpanda Homebrew Tap

Homebrew tap for the [Lightpanda browser](https://github.com/lightpanda-io/browser).

## Structure

- `Formula/lightpanda.rb` — Homebrew formula (latest tagged release)
- `Formula/lightpanda-nightly.rb` — Homebrew formula (nightly build)
- `update.sh` — script to update the formulas to their latest version (used locally and by the workflow)
- `.github/workflows/update.yml` — GitHub Actions workflow to update the formula (triggered by the browser repo's release + manual trigger)

## Formulas

Formulas install pre-built binaries from the Lightpanda GitHub releases:
- `lightpanda` uses the latest tagged release (e.g. `1.0.0`).
- `lightpanda-nightly` uses the `nightly` release. Its version is the release date.

Assets: `lightpanda-{aarch64,x86_64}-{macos,linux}`.

Both install the binary as `lightpanda` in the Homebrew bin directory, so they declare `conflicts_with` each other.

`lightpanda` has `version_scheme 1`: it used nightly dates as version before, and the bump makes tagged versions newer than those dates.

## Updating the formula

**Locally**

Run `./update.sh` to update both formulas, or pass an argument:
- `./update.sh nightly` — update `lightpanda-nightly`
- `./update.sh latest` — update `lightpanda` to the latest tagged release
- `./update.sh <tag>` — update `lightpanda` to `<tag>`, only if it is the latest release

It reads the version and the SHA256 digests of the assets from the GitHub API, and patches the formula.

**Github Actions**

The GitHub Actions workflow is invoked by `lightpanda-io/browser`'s release workflow once a release is built, via `workflow_dispatch` with a `tag` input. It runs `./update.sh <tag>`. It can also be triggered manually from the GitHub Actions UI.

The workflow opens a pull request and merges it right away with `gh pr merge --merge`. It does not wait for checks: the repo has no CI checks and no branch protection on `main`.

## Auditing

To verify a formula passes Homebrew's strict linting rules before submitting to homebrew-core:

```sh
brew tap local/lightpanda
cp Formula/lightpanda.rb $(brew --repository)/Library/Taps/local/homebrew-browser/Formula/lightpanda.rb
brew audit --strict --formula local/lightpanda/lightpanda
brew untap local/lightpanda
```
