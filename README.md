# uBlue-it87
![Aurora](https://github.com/grandpares/ublue-image/actions/workflows/build-aurora.yml/badge.svg) ![Bluefin](https://github.com/grandpares/ublue-image/actions/workflows/build-bluefin.yml/badge.svg) ![Bazzite](https://github.com/grandpares/ublue-image/actions/workflows/build-bazzite.yml/badge.svg)

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/aurora-it87)](https://artifacthub.io/packages/search?repo=aurora-it87) [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/bluefin-it87)](https://artifacthub.io/packages/search?repo=bluefin-it87) [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/bazzite-it87)](https://artifacthub.io/packages/search?repo=bazzite-it87)
## Description
uBlue:stable images customized with Frank Crawford's rewrite of the in-tree it87 driver. Expands support for fan management for multiple Gigabyte motherboards.
## Installation
1. Import the public MOK key found in ```certs``` folder of this repo
2. Rebase to ```ostree-image-signed:docker://ghcr.io/grandpares/[flavor (aurora/bluefin/bazzite)]-it87:latest```
## Credits
- [uBlue maintainers](https://github.com/ublue-os) for Universal Blue, Aurora, Bluefin, Bazzite, and the image customization toolchain
- [Frank Crawford](https://github.com/frankcrawford) for their continued work on the it87 driver
