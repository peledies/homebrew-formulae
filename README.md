# peledies/formulae

```
brew tap peledies/formulae
brew install ktx
brew install ou-login
```

| Formula | Source |
|---------|--------|
| `ktx` | https://github.com/peledies/ktx |
| `ou-login` | https://github.com/peledies/ou-login |

## Updating the version

- update the version variable in the script (`KTX_VERSION` in `ktx`, `OU_LOGIN_VERSION` in `ou-login`)
- push new code to github
- cut a new release tagged `vX.Y.Z`
- run `./update-version.sh <formula>` (e.g. `./update-version.sh ou-login`; defaults to `ktx`)
- commit and push homebrew-formula code
