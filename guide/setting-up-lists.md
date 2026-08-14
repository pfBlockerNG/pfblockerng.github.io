---
layout: default
title: Setting up lists
description: Create feed groups, choose actions and schedules, apply changes, and avoid stale or over-broad policy.
section: Get started
nav: setting-up-lists
permalink: /guide/setting-up-lists/
---

A list group gives one or more sources a shared action, schedule, and operating policy. Keep
groups narrow enough that a report can identify why an address or domain was included.

## Start from the Feeds tab

**Firewall ▸ pfBlockerNG ▸ Feeds** contains maintained definitions for IPv4, IPv6, and DNSBL
sources. Adding a definition creates or opens the matching group with its source information
filled in.

The catalog is the current source of truth for available lists. It changes more often than
this documentation, so a fixed list of provider names here would become stale.

You can also create a group directly from the **IPv4**, **IPv6**, or **DNSBL Groups** page.

## Source rows

Each enabled source row needs:

- **Format/State** — normally use automatic format detection and enable the row.
- **Source** — an HTTPS URL or another supported source named by the UI.
- **Header/Label** — a unique, recognizable label used in files, logs, and reports.
- **Action** — for DNSBL rows, **Deny** blocks and **Permit** acts as a feed allow list.

Use sources you trust operationally as well as editorially. A feed can change, disappear,
become malformed, or publish a false positive.

## Group action

### IP groups

IP actions control whether pfBlockerNG creates rules or only an alias:

| Action family | Effect |
| --- | --- |
| **Deny** | Create blocking rules in the selected inbound, outbound, or both directions. |
| **Permit** | Create high-priority pass rules. Use narrowly: they can override deny and ordinary firewall rules. |
| **Match** | Match and log traffic without blocking it. |
| **Alias Deny / Permit / Match** | Build an alias using that processing class, but create no rule. |
| **Alias Native** | Keep list data in native form and create no rule. |
| **Disabled** | Keep the group configuration without publishing policy. |

See [IP blocking]({{ '/guide/ip-blocking/' | relative_url }}) for direction and alias details.

### DNSBL groups

Set the group action to **Unbound** to publish enabled rows to DNSBL. A row action of
**Permit** allows matching names from downloaded block feeds, subject to DNSBL precedence.

Choose the response mode at group level unless the global DNSBL response override is meant to
apply to every group.

## Schedule

The General-page schedule is the default. A group can opt into a complete override—weekday,
hour, and minute—when that source needs a different cadence. Its update frequency still
controls how often it is due.

Choose a cadence appropriate to the source. Faster is not automatically safer; it also means
new feed mistakes reach enforcement sooner.

## Custom entries

Use a group's custom list for small operator-owned entries related to that group. Prefer a
normal source for large or shared data sets so provenance and refresh behavior stay visible.

- IPv4/IPv6 entries accept the address, range, and CIDR forms documented by the page.
- DNSBL custom blocks are operator policy and take priority over downloaded feed rules.
- Comments may follow the syntax shown in the page's information block.

## Apply and verify

Saving records a pending change. Apply it from **Update**, then verify:

1. The update log reports a successful download and parse.
2. An IP group produces the expected `pfB_*` alias and, when requested, generated rules.
3. A DNSBL group blocks a known listed test name using the selected response mode.
4. **Reports** attributes the result to the expected feed and group.
