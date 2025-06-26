# Aurora-it87
![Aurora](https://github.com/grandpares/ublue-image/actions/workflows/build.yml/badge.svg)
## Description
Stable Aurora image customized with Frank Crawford's rewrite of the in-tree it87 driver. Expands support for fan management for multiple Gigabyte motherboards.
## Installation
1. Import the public MOK key found in ```certs``` folder of this repo
2. Rebase to ```ostree-image-signed:docker://ghcr.io/grandpares/aurora-it87:latest```
## Credits
- [uBlue maintainers](https://github.com/ublue-os) for Universal Blue, Aurora, and the image customization toolchain
- [Frank Crawford](https://github.com/frankcrawford) for their continued work on the it87 driver
