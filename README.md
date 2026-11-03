# Bash Lab

A small, growing collection of Bash scripts and notes from my journey learning shell scripting. I’m committing my practice as I go so I can track what I’ve learned, experiment with new ideas, and look back on my progress.

## What I’m learning

So far, this repository includes practice with:

- Variables, command substitution, and positional arguments
- `if` / `elif` / `else` conditionals and exit codes
- Checking whether paths are files or directories
- Reading system information and working with common Linux commands
- Basic package checks and file-copying ideas

This is a learning project, so the scripts may change as I learn better ways to write them.

## Scripts

| Script | What it practices |
| --- | --- |
| `hello.sh` | A first, simple Bash script |
| `greet.sh` | Variables, command substitution, and a greeting |
| `args.sh` | Positional arguments and argument count |
| `is_positive.sh` | Numeric conditionals |
| `is_file_or_dir.sh` | Argument checks and file/directory tests |
| `sysinfo.sh` | Collecting and displaying basic system information; accepts an optional disk-usage threshold (default: `80`) |
| `pkgcheck.sh` | Checking for a Debian package and optionally installing it with `apt` |
| `timestamp.sh` | Practicing timestamps, paths, and file copying |
| `pratice.sh` | An additional practice script |

## Running a script

Run scripts with Bash from the repository root:

```bash
bash scripts/is_positive.sh 5
bash scripts/is_file_or_dir.sh README.md
bash scripts/sysinfo.sh 80
```

Some scripts expect command-line arguments. For example, `is_positive.sh` expects a number, while `is_file_or_dir.sh` expects a path.

## Requirements

- Bash
- Linux for scripts that use Linux-specific utilities
- `dpkg`, `apt`, and `sudo` to use the optional install flow in `pkgcheck.sh`

**Note:** `pkgcheck.sh` can install software and run `sudo apt update`. Review the script before choosing to install a package.

## Repository layout

```text
bash-lab/
├── scripts/       # Bash practice scripts
└── notes/
    └── LEARNED.md # Learning notes
```

More scripts and notes will be added as I continue learning.
