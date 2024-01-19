# Automated ArchLinux package repository

[ArchLinux](https://archlinux.org/) is a simple, lightweight Linux distribution with a focus on customization. The ArchLinux official package repositories contain most packages you would ever want.  However, sometimes, you need packages that are not available in the official repositories. For these times, you can easily [create your own packages](https://wiki.archlinux.org/title/creating_packages) using scripts, then share them with the world in the [Arch User Repository](https://wiki.archlinux.org/title/Arch_User_Repository) (AUR).

Installing packages from the AUR is not as simple as using official packages (with reason!): you need to download the scripts, review them to ensure they are not malicious, run them, then install your package. It can be tedious and error-prone, making users less likely to upgrade their system.

To face this issue, many [AUR helpers](https://wiki.archlinux.org/title/AUR_helpers) were created: programs that automate this process, with more or less features. However, the fact remains that you must build packages locally.

This repository is another take on an AUR helper: instead of building your packages locally, you build them in CI. Then, they are exposed as a regular binary package repository which `pacman` can install from.

## User guide

### Create your own repository from this template

TO BE WRITTEN.

### Add a package

1. Add the name of the package to the [package list](list.yml), using the same syntax as the existing entries. 
2. Run `./sync.sh NAME_OF_THE_PACKAGE` to populate the `packages/` folder.
3. Push.

### Update packages (manually)

1. Run `./sync.sh NAME_OF_THE_PACKAGE` to update that package in the `packages/` folder. 
2. Push.

### Update packages (automatically)

TO BE WRITTEN.

## License

This project is licensed under the [Apache 2.0 license](LICENSE).

The contents of the `packages` directory are other open source repositories. Each of them are licensed separately from this project, see each directory for more information.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
- To learn more about our coding conventions and workflow, see the [OpenSavvy Wiki](https://gitlab.com/opensavvy/wiki/-/blob/main/README.md#wiki).
- This project is based on the [OpenSavvy Playground](docs/playground/README.md), a collection of preconfigured project templates.
