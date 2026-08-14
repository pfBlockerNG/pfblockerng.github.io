---
layout: default
title: Introduction
description: What pfBlockerNG is designed to do, where it integrates with pfSense, and which component to configure first.
section: Get started
nav: introduction
permalink: /guide/introduction/
---

pfBlockerNG downloads IP and domain intelligence and turns it into policy enforced by
pfSense. It does not replace the firewall or DNS Resolver. It manages data for them,
adds package-specific rules and reporting, and keeps those data sets current.

## The two components

### IP blocking

The IP component converts IPv4 and IPv6 lists into pfSense aliases. An alias group can
also generate firewall rules for a selected direction and action. GeoIP groups use the
same path, but their source is MaxMind country data rather than a normal URL feed.

Use IP blocking when the policy can be expressed as network addresses: known hostile
networks, permitted service networks, country ranges, or an alias consumed by a custom
firewall rule.

### DNSBL

The DNSBL component evaluates requested domain names inside the pfSense Unbound DNS
Resolver. A match can return the DNSBL sinkhole address, `0.0.0.0`, or `NXDOMAIN`, with
or without logging depending on the selected mode.

Use DNSBL when the policy is about names rather than fixed addresses: advertising,
tracking, malicious domains, phishing infrastructure, or a local domain exception.

## How they work together

The components are independent. A domain may resolve to an address that is not on an IP
list, and an IP address may be contacted without a DNS lookup. Enabling both covers both
paths:

| Component | Input | pfSense integration | Main evidence |
| --- | --- | --- | --- |
| IP | IPv4/IPv6 feeds, GeoIP, custom entries | pf aliases and firewall rules | Reports and firewall logs |
| DNSBL | Domain, hosts, ABP/EasyList, and custom entries | Unbound DNS Resolver | DNSBL Reports and DNS logs |

## Where to start

1. [Install pfBlockerNG]({{ '/guide/installation/' | relative_url }}) from the project
   package repository.
2. Follow [General setup]({{ '/guide/general-setup/' | relative_url }}) and run the wizard.
3. Add one small, reputable source using [Setting up lists]({{ '/guide/setting-up-lists/' | relative_url }}).
4. Apply the change from **Firewall ▸ pfBlockerNG ▸ Update**.
5. Verify the result before adding more feeds.

> **Important:** Saving a group marks a pending change; it does not immediately rebuild
> policy. Scheduled processing or a manual Update run applies it.

## Package navigation

The top-level package tabs map to the operating flow:

- **General** — package enablement, scheduling, log retention, and shared settings.
- **IP** — address processing, suppression, interfaces, and rule behavior.
- **DNSBL** — resolver integration, response behavior, and DNS exceptions.
- **Update** — download and apply now; manage update hooks.
- **Reports** — inspect IP and DNSBL activity and add exceptions.
- **Feeds** — browse maintained feed definitions and create groups from them.
- **Logs** — inspect update, parsing, error, and component logs.
- **Sync** — push package configuration to configured peer firewalls.

## Naming safety

The `pfB_` alias prefix is reserved for package-managed aliases. Do not create your own
alias with that prefix: pfBlockerNG removes `pfB_` aliases it no longer manages. A custom
alias may reference a package-managed `pfB_*` alias as a member.
