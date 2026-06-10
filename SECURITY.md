# Security Policy

## Scope

Amnesia by Veridion is a documentation-and-scripts framework. It runs no
servers and stores no credentials. The main security risks are:

1. **Accidental publication of private data** in memory files.
2. **Agents exceeding their contract scope** and touching systems they
   should not.

## Public-safety rules

- Never store secrets, tokens, API keys, private keys, or `.env` values in any
  tracked file — including examples and logs.
- Real infrastructure details (hostnames, IPs, usernames, paths, database
  names, backup locations) must never appear in tracked files. Use
  placeholders: `example.com`, `your-server`, `your-project`.
- Sensitive working notes belong in `memory/private/`, which is gitignored.
- Run `scripts/audit/pre-public-audit.sh` before every publish or release.
  It is read-only and redacts values: it reports file, line, and keyword
  category only.

## Agent safety rules

- Agents must operate only within the paths allowed by the active task
  contract.
- Agents must never connect to production systems, run destructive commands,
  or send external messages without an explicit human approval recorded in the
  execution log.
- Security-flavored examples in this repository are limited to authorized
  labs, defensive review, documentation, and toy demos. This project must not
  be used to target real systems without authorization.

## Reporting a vulnerability

If you find a security issue in this framework (for example, an audit script
that misses a class of secret, or a launcher that is not actually read-only),
please open an issue at `https://github.com/veridionCA/amnesia-by-veridion/issues`
or email `your-security-contact@example.com`. Do not include real secrets in reports.
