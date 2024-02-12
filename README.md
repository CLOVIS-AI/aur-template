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

### Package signing

By default, this repository doesn't sign packages. [Package signing is a Pacman feature](https://man.archlinux.org/man/pacman.conf.5#PACKAGE_AND_DATABASE_SIGNATURE_CHECKING) that allows to ensure the package hasn't been tampered with since it was built.

If you do not trust your network (e.g. you are behind a proxy that forces you to install additional SSL certificates), then package signing ensures the proxy cannot infect a package.

Since we build everything in CI, the secret signing key must be stored in the GitLab CI variables and shared with the runners you use to execute your CI jobs. This is standard practice for other deployment-based secrets (API keys…), but keep in mind that this means package signing will not protect you from a security flaw in GitLab itself—which you would be protected against if you built signed packages on your local machines then pushed them to GitLab, because an attacker editing the files wouldn't be able to replicate the signatures.

However, using this repository does mean all packages are built in CI instead of your local machine. In that way, you reduce your attack surface to nefarious packages, so we believe this tradeoff is worth it.

1. Create a GPG key: `gpg --full-generate-key` (choose the key type you want, as long as it supports signing).
2. Export the key: `gpg --export-secret-key --armor username@email`.
3. [Create a CI variable](https://docs.gitlab.com/ee/ci/variables/#define-a-cicd-variable-in-the-ui) named `package_signing_key` of type "file" which contains the complete and exact output of the previous command. Disable "expand variable reference". If you leave "protect variable", the snapshot repository will not be signed.

The packages will now be signed next time they are regenerated.

## License

This project is licensed under the [Apache 2.0 license](LICENSE).

The contents of the `packages` directory are other open source repositories. Each of them are licensed separately from this project, see each directory for more information.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
- To learn more about our coding conventions and workflow, see the [OpenSavvy Wiki](https://gitlab.com/opensavvy/wiki/-/blob/main/README.md#wiki).
- This project is based on the [OpenSavvy Playground](docs/playground/README.md), a collection of preconfigured project templates.
