---
layout: default
title: General setup
description: Install pfBlockerNG, establish safe defaults, apply the first configuration, and verify enforcement.
section: Get started
nav: general-setup
permalink: /guide/general-setup/
---

This setup intentionally starts small. One known feed is easier to verify and troubleshoot
than a large policy imported all at once.

## Before changing policy

1. Back up the pfSense configuration at **Diagnostics ▸ Backup & Restore**.
2. Confirm clients use the pfSense DNS Resolver if you plan to enable DNSBL.
3. Know which interfaces are external and which carry client traffic.

## Install the package

For the current project-built packages, channels, and copy-ready commands, use the
[pfBlockerNG package repository](https://pfblockerng.github.io/pkg). Stable and development
builds are also available from **System ▸ Package Manager ▸ Available Packages** in the
pfSense catalog.

After installation, open **Firewall ▸ pfBlockerNG**.

## Run the wizard

On a new installation, select the **Wizard** tab from the General page. The wizard provides
a minimal baseline and asks for the interfaces used by IP rules and DNSBL.

Review the result rather than treating it as a permanent profile. Interface roles and local
DNS behavior differ between firewalls.

## General page

At **Firewall ▸ pfBlockerNG ▸ General**:

1. Enable **pfBlockerNG**.
2. Enable **Keep Settings** if configuration and run state must survive package removal and
   reinstall during a major pfSense upgrade.
3. Leave the internal feed-host filter enabled unless a feed intentionally comes from a
   trusted private mirror; add only that mirror to the exemptions list.
4. Enable scheduled feed updates and choose the default local-time schedule you want.
5. Leave advanced log limits at their defaults until measured usage requires a change.
6. Save.

> Disabling **Keep Settings** is destructive during package uninstall or a major pfSense
> upgrade. Keep a current pfSense configuration backup.

## IP interfaces

At **Firewall ▸ pfBlockerNG ▸ IP**, review **IP Interface/Rules Configuration**:

- Inbound commonly means traffic arriving from an external interface.
- Outbound commonly means client traffic leaving a local interface.
- Select only interfaces where generated rules are intended to operate.

Direction describes traffic at the chosen interface, not a general trust label. Verify the
generated rules after the first apply.

## DNSBL baseline

At **Firewall ▸ pfBlockerNG ▸ DNSBL**:

1. Enable DNSBL.
2. Use the default Unbound integration and response mode for the first run.
3. Confirm the DNSBL virtual addresses do not conflict with addresses already used on the
   firewall.
4. Save.

Clients that use an external resolver, encrypted DNS, or a local hosts entry can bypass the
normal Unbound lookup path. DNSBL can evaluate only queries that reach pfSense Unbound.

## Add and apply one list

Continue with [Setting up lists]({{ '/guide/setting-up-lists/' | relative_url }}), then:

1. Open **Firewall ▸ pfBlockerNG ▸ Update**.
2. run a manual update/reload for the component you configured.
3. Read the on-page output and **Logs** for download or parse errors.
4. Check **Firewall ▸ Aliases** and **Firewall ▸ Rules** for IP policy, or query a known
   listed domain through pfSense for DNSBL.
5. Confirm the event in **Reports**.

Only after this path is verified should you add more sources.
