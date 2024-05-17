Goal is to clean up local branches you might not want.

Configure your remotes to ignore braches you don't care to track.

For instance, say you only want to track Bob's `master` branch and don't care to pull anything else.

```bash
branch_to_keep="master"
remote="bob"
git config remote.$remote.fetch "+refs/heads/$branch_to_keep:refs/remotes/$remote/$branch_to_keep"
```

This doesn't remove all the crap you already have local. That's the point of this script.

## TODO
1. Update Powershell version.It's woefully out-of-date.
