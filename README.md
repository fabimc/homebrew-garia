# Homebrew tap for Garia

Personal tap for [Garia](https://github.com/fabimc/garia), a download manager for macOS.

```sh
brew tap fabimc/garia
brew install --cask garia
```

The cask installs the signed universal `.dmg` from [Garia releases](https://github.com/fabimc/garia/releases). Garia updates itself after that; `brew upgrade` leaves it alone unless you pass `--greedy`.

## After a Garia release

The Release workflow on `fabimc/garia` drafts the GitHub Release. Once you **publish** that draft:

1. Run [Update cask](../../actions/workflows/update-cask.yml) (or wait for the daily cron).
2. Or pin it locally and push:

```sh
./scripts/update-cask.sh v0.1.0
```

That replaces `sha256 :no_check` with the checksum of `Garia_<version>_universal.dmg`.
