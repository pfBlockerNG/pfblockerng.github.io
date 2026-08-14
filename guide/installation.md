---
layout: default
title: Installation
description: Install pfBlockerNG from the official project package repository before configuring policy.
section: Get started
nav: installation
permalink: /guide/installation/
---

Installation is the first setup step. Project releases are distributed through the
[pfBlockerNG package repository](https://pfblockerng.github.io/pkg), which provides current
channels, supported pfSense releases, and copy-ready commands.

## Install from the project repository

1. Open the [package repository](https://pfblockerng.github.io/pkg).
2. Choose **Stable** for production use, or another channel only when its description fits
   your purpose.
3. Run that channel's copy-ready commands as `root` on the pfSense firewall.
4. Confirm pfBlockerNG appears under **System ▸ Package Manager ▸ Installed Packages**.

Use the commands shown on the repository page rather than copying commands from older guides;
the page tracks current channels and supported pfSense versions.

## Continue with setup

Open **Firewall ▸ pfBlockerNG**, then follow [General setup]({{ '/guide/general-setup/' | relative_url }}).
