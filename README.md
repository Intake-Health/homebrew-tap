# Intake-Health Homebrew Tap

Private Homebrew tap for Intake-Health developer tools.

## Usage

```bash
brew tap intake-health/tap
brew install <formula>
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| `inflow-cli` | CLI tool for InFlow ESP32 hydration sensor devices over BLE |

## Releasing a New Version

When you tag a new release on a formula's source repo, update the tap so `brew upgrade` picks it up.

### 1. Tag and push the release

```bash
cd ~/inflow-ops-app  # or whichever project
git tag v0.2.0
git push origin v0.2.0
```

### 2. Create a GitHub release

```bash
gh release create v0.2.0 --generate-notes --repo Intake-Health/inflow-ops-app
```

### 3. Get the sha256 of the release tarball

```bash
curl -sL https://github.com/Intake-Health/inflow-ops-app/archive/refs/tags/v0.2.0.tar.gz | shasum -a 256
```

### 4. Update the formula

```bash
cd ~/homebrew-tap

# Update the version
sed -i '' 's|archive/refs/tags/v.*\.tar\.gz|archive/refs/tags/v0.2.0.tar.gz|' Formula/inflow-cli.rb

# Update the sha256 (replace NEWSHA with output from step 3)
sed -i '' '0,/sha256 ".*"/s|sha256 ".*"|sha256 "NEWSHA"|' Formula/inflow-cli.rb

git add Formula/inflow-cli.rb
git commit -m "Update inflow-cli to v0.2.0"
git push
```

Users get the update with:

```bash
brew update && brew upgrade inflow-cli
```
