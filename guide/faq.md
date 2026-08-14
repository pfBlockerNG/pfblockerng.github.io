---
layout: default
title: FAQ
description: Direct checks for missing rules, DNSBL bypass, false positives, update failures, and safe alias naming.
section: Operate
nav: faq
permalink: /guide/faq/
---

## Why are no IP rules visible?

Check, in order:

1. pfBlockerNG is enabled on **General**.
2. The group and at least one source row are enabled.
3. The group action is Deny, Permit, or Match—not an Alias action or Disabled.
4. The intended inbound/outbound interfaces are selected on **IP**.
5. A pending change was applied from **Update**.
6. The update and parser logs show usable addresses.

Alias actions intentionally create no rules. Inspect **Firewall ▸ Aliases** instead.

## Why does a listed domain still resolve?

Confirm the client actually queries pfSense Unbound. External DNS, encrypted DNS, a VPN
resolver, browser-specific secure DNS, and local caching can bypass or hide the expected path.

Then check Reports for a higher-priority allow: a feed exception, Permit source, operator
whitelist, TOP1M entry, or temporary unlock. Finally, apply pending DNSBL changes and retry
with a fresh query.

## How do I fix a false positive?

Find the event in Reports, identify the source, and add the narrowest exception:

- IP event — suppress the exact address or smallest justified CIDR.
- DNSBL event — whitelist the required hostname or domain.

Reload the affected component and verify. If the downloaded source is wrong, also report the
entry to its maintainer.

## What happens when a feed download fails?

pfBlockerNG can reload the previously downloaded list, preserving last-known-good policy. The
General page's download-failure threshold controls repeated scheduled attempts. Inspect Logs
before replacing or disabling the source.

## Can I create my own `pfB_` alias?

No. `pfB_` is reserved for package-managed aliases, and unmanaged aliases with that prefix can
be removed. Give your alias a different name; it may reference a `pfB_*` alias as a member.

## Should I use generated rules or Alias Native?

Use generated rules for the standard Deny, Permit, or Match behavior. Use an Alias action when
you need custom ports, ordering, destinations, or another consumer to own enforcement.
**Alias Native** is the least transformed list form.

## Does DNSBL block every encrypted DNS service?

No. DNSBL evaluates queries that reach pfSense Unbound. pfBlockerNG can help manage known
encrypted-DNS endpoints, but clients and services change. Enforce DNS policy with deliberate
firewall and device configuration rather than assuming a domain list captures every bypass.

## Where should I ask for help?

- Ask usage and configuration questions in the [pfBlockerNG subreddit](https://www.reddit.com/r/pfBlockerNG/).
- Search and report package defects in the [pfBlockerNG repository](https://github.com/pfBlockerNG/pfBlockerNG/issues).
- Browse project repositories in the [pfBlockerNG organization](https://github.com/pfBlockerNG).
- Use the [Netgate Forum](https://forum.netgate.com/category/62/pfblockerng) for community configuration discussion.
- Include pfSense version, package version/channel, the affected component, and relevant
  redacted log lines.
