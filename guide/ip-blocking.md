---
layout: default
title: IP blocking
description: How IP feeds become pfSense aliases and rules, what action and direction mean, and where suppression and GeoIP fit.
section: Components
nav: ip-blocking
permalink: /guide/ip-blocking/
---

The IP component normalizes IPv4 and IPv6 sources into pfSense table aliases. It can then
generate rules for those aliases or leave rule ownership to you.

## Processing path

1. Download enabled group sources and read custom entries.
2. Normalize addresses, ranges, and CIDRs; reject invalid rows.
3. Apply enabled de-duplication, suppression, and CIDR aggregation.
4. Publish package-managed `pfB_*` aliases.
5. Generate rules for Deny, Permit, or Match actions.
6. Record matching traffic in Reports and firewall logs when logging is enabled.

On a failed download, pfBlockerNG can retain and reload the previously downloaded list rather
than replacing working policy with an empty result.

## Direction

Direction is evaluated on the interfaces selected under **IP Interface/Rules Configuration**.

- **Inbound** applies where traffic arrives on selected inbound interfaces.
- **Outbound** applies where traffic arrives on selected local/client interfaces before it is
  routed outward.
- **Both** creates the corresponding policy in both directions.

Stateful firewall behavior matters. A one-direction deny normally blocks new sessions started
in that direction without breaking reply traffic for a session permitted in the other
direction. Inspect the generated rules for the actual interface placement.

## Action behavior

### Deny

Deny rules block addresses in the group. **Deny Both** covers both selected directions;
one-direction variants cover only their selected side.

### Permit

Permit creates high-priority pass rules and can act as an exception to deny policy. It can
also override ordinary firewall rules on the same interface, so constrain protocol, port,
source, and destination where possible.

### Match

Match records matching traffic without passing or blocking it. Use it to observe a list before
turning that list into enforcement.

### Alias actions

Alias actions create no firewall rule. Use them when an existing pfSense rule, HAProxy, or
another consumer should own behavior. **Alias Native** avoids the package processing applied
to Deny, Permit, and Match classes.

## Suppression

Suppression removes operator-approved addresses or networks from Deny data. Reports provides
an add action for observed IPs; manual suppression changes require an IP reload.

Keep suppressions specific and documented. Suppressing a broad CIDR can silently neutralize a
large part of several feeds.

## GeoIP

GeoIP groups convert MaxMind country ranges into the same alias/rule path as ordinary IP
groups. Country is not a security verdict: use GeoIP where geography is an actual policy
requirement, and prefer protecting specific exposed services over broad country blocking.

## Aggregated aliases

The IP page can build reference-only aggregated aliases for selected action classes. An
aggregate is the CIDR-combined union of its member groups and creates no rule by itself. It is
useful when one custom rule or external service needs the complete class.

## Verify IP policy

- **Firewall ▸ Aliases** — expected `pfB_*` alias exists and contains data.
- **Firewall ▸ Rules** — generated rules use the intended interface, action, and direction.
- **Firewall ▸ pfBlockerNG ▸ Reports** — matching events name the expected alias/feed.
- **Status ▸ System Logs ▸ Firewall** — logged rule events agree with Reports.
