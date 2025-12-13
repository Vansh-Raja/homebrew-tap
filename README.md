# Vansh-Raja Homebrew Tap

This tap provides Homebrew formulae maintained by Vansh Raja.

## Install SSHThing

```bash
brew tap Vansh-Raja/tap
brew install sshthing
```

## Notes

- `sshthing` is built from source and links against SQLCipher.
- Finder mounts are optional and require FUSE-T + SSHFS:

```bash
brew install --cask fuse-t
brew tap macos-fuse-t/homebrew-cask
brew install --cask fuse-t-sshfs
```
