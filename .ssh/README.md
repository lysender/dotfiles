# Using alias to map github/bitbucket/etc accounts to a private key

## Github example

Alias: `github-ctdr`

```
Host github-ctdr
    IdentityFile ~/.ssh/id_ed25519_ctdr
    User git
    HostName github.com
```

How to use?

```
git clone github-ctdr:githubuser/awesome-repo.git
```

This will resolve the hostname to `github.com` and use the specified private key for SSH connection.
