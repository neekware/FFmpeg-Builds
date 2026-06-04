# neekware fork notes

This fork tracks `BtbN/FFmpeg-Builds` as source/reference for ehAye FFmpeg artifacts.

Do **not** allow upstream GitHub Actions workflows to run in this fork. They would
build FFmpeg on our GitHub account and burn build credits.

Use:

```sh
./neekware/sync-upstream.sh
```

The sync script fetches upstream, merges it, then removes `.github/workflows`
before committing so upstream Actions do not come back.
