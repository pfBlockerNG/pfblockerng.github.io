---
layout: default
title: DNSBL
description: How DNSBL evaluates domain feeds in Unbound, chooses a response, resolves exceptions, and reports blocked queries.
section: Components
nav: dnsbl
permalink: /guide/dnsbl/
---

DNSBL evaluates names inside the pfSense Unbound DNS Resolver. It does not install a browser
extension or filter content after a connection is established; it decides the DNS response
for a matching query.

## Processing path

1. Download enabled DNSBL sources and read operator entries.
2. Parse plain domains, hosts-style rows, and supported Adblock Plus/EasyList rules per line.
3. Normalize names and reconcile block and allow rules by priority.
4. Build a new DNSBL data set and swap it into the running resolver without restarting
   Unbound.
5. Log matches according to the selected response mode.

## Response modes

| Mode | Resolver response | Logging |
| --- | --- | --- |
| **DNSBL WebServer/VIP** | DNSBL sinkhole virtual address | Yes; supports the block page path |
| **Null Blocking** | `0.0.0.0` | Selectable with or without logging |
| **NXDOMAIN** | Name does not exist | Selectable with or without logging |

A global logging/blocking mode on the DNSBL page overrides per-group response choices.

## Feed and operator precedence

DNSBL uses six priority bands. Higher bands win when rules for the same name conflict:

| Priority | Rule |
| --- | --- |
| 1 | Downloaded feed block |
| 2 | Downloaded feed allow (`@@` or a Permit source) |
| 3 | Downloaded feed block with `$important` |
| 4 | Downloaded feed allow with `$important` |
| 5 | Operator block, custom-list block, or operator regex |
| 6 | Operator whitelist, TOP1M allow, or temporary operator unlock |

`$badfilter` cancels the matching ABP rule in the same rule stream. This ordering keeps feed
exceptions useful while preserving operator control.

## ABP and EasyList

Supported feeds can mix plain entries and ABP/EasyList syntax. Rule parsing is per line, so a
feed does not need to be classified wholly as one format. Supported semantics include domain
anchors, `@@` exceptions, regular-expression rules, `$important`, and `$badfilter`.

Complex feed and user regex is guarded at load and runtime. Avoid adding broad custom regex
when a plain domain or wildcard entry expresses the same policy.

## Sinkhole virtual address

The package can own the DNSBL sinkhole VIP automatically. Confirm its IPv4 and IPv6 addresses
do not overlap an interface, routed network, VPN, or another VIP. The VIP is only relevant to
the WebServer/VIP response mode.

## Client path

DNSBL sees queries that reach pfSense Unbound. A client using an external resolver, DNS over
HTTPS, DNS over TLS, a VPN-provided resolver, or a local hosts file may not use that path.
pfBlockerNG includes controls that can assist with known encrypted-DNS endpoints, but network
policy must deliberately force or permit client DNS behavior.

## False positives

1. Find the event in **Reports** and confirm the feed/group.
2. Decide whether the exception is temporary or permanent.
3. Add a precise whitelist or use the report action.
4. Reload DNSBL and confirm the name resolves.
5. Report the false positive to the feed maintainer when appropriate.

An operator whitelist has the highest priority, including over `$important` feed blocks.
