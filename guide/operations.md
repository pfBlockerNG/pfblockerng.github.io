---
layout: default
title: Operations
description: Apply updates, verify policy, investigate events, manage exceptions, and keep package channels current.
section: Operate
nav: operations
permalink: /guide/operations/
---

Treat an update as a policy publication: check what changed, verify the result, and keep a
rollback path for large changes.

## Save, update, and reload

- **Save** persists configuration and marks affected policy pending.
- **Update** downloads sources that are due, then rebuilds affected policy.
- **Reload** rebuilds policy from available data without requiring every source to download.
- Scheduled processing applies groups according to their configured cadence and the General
  page's automatic-apply window.

Use **Firewall ▸ pfBlockerNG ▸ Update** for a manual run. Choose IP or DNSBL when only one
component changed; use the broader option when shared settings changed.

## Verification checklist

After a meaningful change:

1. The update output completes without download, parse, or apply errors.
2. **Logs** shows expected source counts and no unexpected rejected rows.
3. IP aliases/rules or the DNSBL data set reflects the group you changed.
4. A controlled test produces the expected pass, block, match, or DNS response.
5. **Reports** attributes the test to the expected source.

## Reports and exceptions

Reports is the fastest route from an observed event to its policy source. Use filters before
adding an exception, and confirm whether the event came from IP blocking or DNSBL.

- Suppress an IP only after checking the address and containing CIDR.
- Whitelist the narrowest DNS name that restores the required service.
- Prefer a feed-level correction when the source itself is wrong.

Review exceptions periodically. An old exception can outlive the service or false positive
that justified it.

## Logs

The Logs tab exposes package, unified, error, extras, IP, DNS, and parser logs. The General
page controls retention by maximum lines and age. Increase limits only when normal incident
investigation proves the retained window is too short.

For an IP event, also inspect **Status ▸ System Logs ▸ Firewall**. For DNSBL, compare the DNS
block and reply logs with the client query path.

## Update hooks

Update hooks run local operator scripts before or after an update pass. They run as root, so
enable only reviewed scripts and restrict edit privileges. A failed hook is logged and does
not abort the policy update.

See the repository [Update Hooks reference](https://github.com/pfBlockerNG/pfBlockerNG#update-hooks)
for filenames and environment variables.

## DNSBL runtime control

When **DNSBL Control** is enabled, the root CLI can temporarily disable DNSBL or bypass a
client without rebuilding lists:

```sh
pfblockerng dnsbl-control disable [seconds]
pfblockerng dnsbl-control enable
pfblockerng dnsbl-control addbypass <ip> [seconds]
pfblockerng dnsbl-control removebypass <ip>
```

Temporary controls are logged in Reports. Prefer them over changing persistent policy for a
short diagnostic window.

## Package updates and channels

Use the [package repository page](https://pfblockerng.github.io/pkg) for current stable,
testing, edge, and nightly instructions. A firewall subscribes to one channel. Moving channels
requires both changing the repository subscription and migrating the installed package; the
package page provides the current commands.

Back up pfSense configuration before moving to an older build. Older code may not understand
state written by a newer version.
