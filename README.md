# Fengrove Homebrew Tap

## To calculate the sha-256

```sh
curl -L https://github.com/swamp/mangrove/releases/download/v0.0.7/mangrove-darwin-x86_64.tar.gz | shasum -a 256
```

## To test locally

```sh
brew install --build-from-source ./mangrove.rb
```
