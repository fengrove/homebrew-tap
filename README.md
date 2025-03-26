# Fengrove Homebrew Tap

## To calculate the sha-256

```sh
curl -L https://github.com/fengrove/fengrove/releases/download/v0.0.23/mangrove-darwin-x86_64.tar.gz | shasum -a 256
curl -L https://github.com/fengrove/fengrove/releases/download/v0.0.23/packages.tar.gz | shasum -a 256
```

## To test locally

```sh
brew install --build-from-source ./mangrove.rb
```
