# Configure a Pop!\_OS machine for web development

> [https://pop.system76.com/](https://pop.system76.com/)

To install, open a terminal and run as a regular user **(not root)**:

```bash
$ ./setup.sh
```

> - Running `setup.sh` will execute all scripts under the `setup` folder;
> - Every script under the `setup` folder can be run individually;
> - Tested in Pop!\_OS 20.04 LTS.

# Folder description

## `ca-certificates`

Certificates to be installed system-wide.

## `dotfiles`

Dotfiles that will be copied to `$HOME`.

## `functions`

Includes all helper functions used along the setup scripts.

## `misc`

Includes multiple assets and config files other than `dotfiles`.

## `setup`

Contains all configuration scripts files separated by category/technology.
