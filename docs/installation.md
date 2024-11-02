---
layout: page
title: "Installation"
permalink: /docs/installation/
nav_order: 1
---
# Installation

To use this DSL and render the `.dot` files it generates, you need to install **Graphviz**. Graphviz provides the CLI for converting `.dot` files into images.

## Installing Graphviz

### Linux

Most Linux distributions have Graphviz in their package manager:

```bash
# On Ubuntu or Debian-based systems
sudo apt update && sudo apt install graphviz

# On Fedora
sudo dnf install graphviz

# On Arch Linux
sudo pacman -S graphviz
```

### macOS

If you have [Homebrew](https://brew.sh/) installed, you can install Graphviz with:

```bash
brew install graphviz
```

### Windows

You can download the installer from the official [Graphviz](https://graphviz.org/download/#:~:text=Copy-,Windows,-Stable%20Windows%20install) website. Follow the instructions in the installer to complete the setup.

### Verifying the Installation

After installation, verify by running:

```bash
dot -V
```

You should see version information if Graphviz is installed correctly.

For more details, see the [Graphviz installation](https://graphviz.org/download/) documentation.
