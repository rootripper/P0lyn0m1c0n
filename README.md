# P0lyn0m1c0n

> Target-aware password wordlist generator for authorized security assessments.

![Bash](https://img.shields.io/badge/Bash-4.0%2B-green)
![License](https://img.shields.io/badge/License-MIT-blue)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-lightgrey)

P0lyn0m1c0n builds compact, high-relevance password wordlists by mutating a
**target** (a company name, a domain) into the patterns humans actually use —
year suffixes, month names, leet substitutions, corporate vocabulary and common
endings. Instead of brute-forcing every possible string, it focuses on the
candidates a real person would realistically set.

---

## Why?

Generic wordlists are great, but they
miss context. People build passwords around the company name, the current year,
their department, a `!` at the end. `Ec0rp2026!` will never be in a generic
list — but it's exactly the kind of password a real employee sets.

P0lyn0m1c0n's philosophy: **relevance beats volume**. A tight list of 10,000
context-aware candidates routinely outperforms a generic list a thousand times
its size.

---

## Features

- **Language-aware** — Spanish, English, or both. Adapts months, common
  passwords, first names and corporate role vocabulary.
- **Multi-level leet** — `off` / `basic` / `medium` / `full` / `all`
  (e.g. `ecorp` → `3c0rp`).
- **Year mutation** — covers previous, current and next year (catches stale
  passwords and pre-rotated ones), or full historic mode back to 2005.
- **Month patterns** — full and short month names, numeric months, month+year
  combinations.
- **Corporate vocabulary** — roles, departments and service accounts baked into
  the auto-generated base dictionary.
- **Charset constructor** — pick any combination of lower / upper / digits /
  symbols; candidates are reshaped to fit, not silently dropped.
- **Length filtering** — match the target's real password policy.
- **Effort tiers** — cap output at 1k / 10k / 50k / uncapped, prioritized so the
  most probable patterns come first.
- **Honest reporting** — if constraints are too tight to hit the cap, the tool
  tells you exactly why and what to change.
- **Interactive wizard + full CLI mode** — use it by hand or drop it into
  pipelines.

---

## Requirements

- Bash 4.0+
- Standard GNU coreutils (`awk`, `sed`, `tr`, `sort`) — no external dependencies

---

## Installation

```bash
git clone https://github.com/rootripper/P0lyn0m1c0n.git
cd P0lyn0m1c0n
chmod +x P0lyn0m1c0n_v2.sh
```

---

## Usage

### Interactive mode

```bash
./P0lyn0m1c0n_v2.sh
```

The wizard walks you through target, language, length, charset, leet level,
year mode and effort level — then pauses so you can enrich the base dictionary
with engagement-specific words before generation.

### Non-interactive (CLI) mode examples

```bash
# Quick run, Spanish focus, top 10k
./P0lyn0m1c0n_v2.sh -t acme

# Password list, English, capped at 10k
./P0lyn0m1c0n_v2.sh -t globex -l en --min 8 --max 16 \
                    --charset LUDS --leet medium --effort medium -y --no-prompt

# Maximum coverage for offline cracking
./P0lyn0m1c0n_v2.sh -t hooli -l both --charset LUDS \
                    --leet all --years historic --effort all -y --no-prompt
```

---

## CLI Options

| Flag | Argument | Description |
|------|----------|-------------|
| `-h`, `--help` | — | Show help screen |
| `-t`, `--target` | `TARGET` | Target name (company / domain) — **required in CLI mode** |
| `-l`, `--lang` | `es\|en\|both` | Language focus (default: `es`) |
| `--min` | `N` | Minimum password length (default: `8`) |
| `--max` | `N` | Maximum password length (default: `16`) |
| `--charset` | `STRING` | Any combo of `L` `U` `D` `S` (default: `LUDS`) |
| `--leet` | `off\|basic\|medium\|full\|all` | Leet substitution level (default: `medium`) |
| `--years` | `recent\|historic` | Year range (default: `recent`) |
| `-e`, `--effort` | `fast\|medium\|full\|all` | Output cap (default: `medium`) |
| `-b`, `--basedic` | `PATH` | Custom base dictionary path |
| `--no-prompt` | — | Skip the base-dictionary edit pause |
| `-o`, `--output` | `PATH` | Output filename |
| `-y`, `--yes` | — | Skip the "Proceed?" confirmation |

### Charset codes

| Code | Class |
|------|-------|
| `L` | lowercase `a-z` |
| `U` | uppercase `A-Z` |
| `D` | digits `0-9` |
| `S` | symbols `!@#$%&*` |

Example: `--charset LUD` → letters and digits, no symbols.

### Leet levels

| Level | Substitutions | Example |
|-------|---------------|---------|
| `off` | none | `acme` |
| `basic` | `a→4 e→3 i→1 o→0` | `4cm3` |
| `medium` | + `s→5 t→7` | `54l35` (sales) |
| `full` | + `l→1 g→9 b→8 z→2` | `m4n493r` (manager) |
| `all` | all of the above + partial-first variant | multiple per word |

---

## The Base Dictionary

P0lyn0m1c0n always generates a base dictionary automatically, seeded by language
with common passwords, typical first names, corporate roles (`admin`, `manager`,
`ceo`), departments (`it`, `sales`, `hr`) and technical service accounts
(`ftp`, `sql`, `vpn`, `ssh`).

In interactive mode the tool then **pauses** and shows you the file path. If you
have engagement-specific intel — founder names, product names, the HQ city, an
internal project codename — add it to that file and type `y` to continue. Those
custom words flow through the same mutation pipeline as everything else.

This matters because the highest-value passwords are almost always tied to
information specific to the target that no generic list could contain.

---

## How It Works

Candidates are generated in three priority tiers and then filtered:

1. **Tier 1** — the target itself, its leet variants, year suffixes and common
   endings (highest probability).
2. **Tier 2** — month names, month+year combinations, leet of secondary forms.
3. **Tier 3** — every base-dictionary word crossed with the target and mutated.

The combined output is passed through the charset constructor, the length
filter, global deduplication, and finally the effort cap. Because tiers are
ordered by likelihood, even `--effort fast` gives you the *best* 1,000
candidates rather than a random slice.

---

## Example Output

An uncapped run against `ecorp` (English, full leet) produces tens of thousands
of realistic candidates:

```
3c0rp2026
ecorp2025
ECORP2027
Ecorp2026!
ecorpadmin
adminecorp2026
ecorp.sept.2026
...
```

Every entry is a human-shaped password, not random noise.

---

## Responsible Use

> **P0lyn0m1c0n is built for authorized security work only.**

Acceptable use includes penetration tests with a signed scope, red-team
engagements, internal audits of infrastructure you own, and password-strength
research where you have explicit permission.

---

## License

Released under the MIT License. See [LICENSE](LICENSE) for details.

---
