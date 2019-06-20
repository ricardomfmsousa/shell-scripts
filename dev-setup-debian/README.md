# Configure a debian based machine for web development

To install, run as a regular user **(not root)**:

```bash
$ ./setup.sh
```

> - Running `setup.sh` will execute all scripts under the `setup` folder;
> - Every script under the `setup` folder can be run individually;
> - Tested in Ubuntu 18.04 and Elementary 5.

# Folder description

## `ca-certificates`

Copy all your certificates to this folder in order to install them system-wide.

## `dotfiles`

Includes all dotfiles that will be copied to `$HOME`.

## `functions`

Includes all helper functions used along the setup scripts.

## `setup`

Contains all configuration scripts files separated by category/technology.
