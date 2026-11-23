---
layout: single
parent: Open Source
title: ""
permalink: /opensource/automation/backup-and-restore-tool/
author_profile: false
classes: "wide smaller-text"
sidebar:
  nav: "opensource_sidebar"
---

## 🐧 Backup & Restore Tool

![GitHub top language](https://img.shields.io/github/languages/top/zappee/backup-and-restore-tool)
![GitHub Issues](https://img.shields.io/github/issues/zappee/backup-and-restore-tool)
![GitHub Release](https://img.shields.io/github/v/release/zappee/backup-and-restore-tool)

#### ⭐⭐ Like this project? Support my work by giving it a star on [GitHub](https://github.com/zappee/backup-and-restore-tool) ⭐⭐

![GitHub Repo stars](https://img.shields.io/github/stars/zappee/backup-and-restore-tool?style=flat)

### 1) Overview
A simple, secure, and interactive file copy and backup tool to back up and restore files especially for laptops.
If you use external USB hard drives or flash drives to back up your personal files, documents, and photos, this tool makes the process effortless.
It is specifically built for people who need to manage backups of multiple different laptops or computers and keep the files synced between the laptops.

It handles adding, deleting, and renaming files and directories seamlessly.
It also works perfectly when tracking changes to file properties, such as modification timestamps, ownership, permissions, and system flags.

Unlike other automated tools that run silently in the background, this tool uses a two-step confirmation process.
It shows you a "preview" of exactly what files will be copied, changed, or deleted before it actually modifies anything on your disks, giving you complete control and peace of mind.

### 2) Why Use This Tool?
* **Safe execution:** Automatically runs a dry-run first to visualize differences (additions, modifications, deletions) before executing the actual sync.
* **Smart disk space management:** The tool offers three ways to handle your backups: `append`, `mirror`, and `pre-purge`.
* **Output explainer:** Embedded documentation within the script breaks down complex rsync shortcodes.
* **Built for multiple computers:** You can easily create custom backup and/or restore configuration scripts for your work laptop, personal laptop, or family computers, keeping all your backup routines organized in one place.
* **Visual progress:** Displays clear progress bars and file sizes while copying so you never have to guess if the backup is frozen.
* **Flexible sync job configuration:** Setting up or updating your backup jobs is effortless—just point to your `SOURCE` and `TARGET` folders and list the subfolders you want to include.

  ![backup job configuration](assets/images/menu/opensource/backup-and-restore-tool/backup-job-configuration.png)

### 3) What's inside the box?
* `sync-lib.sh`: The core execution engine containing script arguments validation, double-prompt safeguards, and the main rsync orchestration logic. You don't need to change this file.
* `sync-to-portable-2.sh`: A job configuration illustrating how to back up local folders to your external hard drive.
* `sync-from-portable-2.sh`: A corresponding job profile showing how to quickly reverse the flow to copy your files back (restore) from your external drive to your laptop. Perfect for setting up a new computer or recovering from a crash.

### 4) Prerequisites
* Ensure you are using a Unix-like environment with `rsync` installed.
* Check if rsync is available: `rsync --version`

### 5) Backup your files and Directories
Before running your first backup, it is best to organize your files cleanly on your computer so the process works smoothly and effortlessly.
The easiest approach is to keep all your personal files in one main parent folder.
Scattering files across different locations on your system makes backing up, restoring, and verifying your data much harder to manage.
Here is a recommended folder structure:

```console
└── Workspace
    ├── documents
    ├── finance
    ├── holiday
    ├── learning
    ├── music
    ├── photo-album
    ├── temp
    ├── videos
    ├── ...
    └── work
```

When configuring your backup, you can pick and choose which subfolders to include, or completely skip unimportant ones, like the `temp` folder above.

**Create a Backup Job Script**

Once your folders are organized, create a job script to define what gets backed up.
A good naming convention for your automated backup sctipt is `sync-to-<media-label>.sh`.
Where `<media-label>` is the label of your external or portable disk.

Use [sync-to-portable-2.sh](bin/sync-to-portable-2.sh) as a template to create your own automated backup script.
Below is an example backup setup that matches the folder structure above, you only need to update the `SOURCE_BASE`, `TARGET_BASE`, and `JOB` variables:

```console
readonly SCRIPT_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_HOME}/lib/sync-lib.sh"

readonly SOURCE_BASE="$HOME/Workspace"         # <-- important
readonly TARGET_BASE="$HOME/Mount/portable-2"  # <-- important

readonly JOB=(
  "documents        | mirror"
  "finance          | mirror"
  "holiday          | mirror"
  "music            | append"
  "photo-album      | mirror"
  "videos/series    | append"
  "videos/my-videos | mirror"
  "work             | mirror"
)

run_job "$SOURCE_BASE" "$TARGET_BASE" "${JOB[@]}"
```

**Configuration Options:**
* **SOURCE_BASE**: The main folder containing the files and subfolders you want to back up.
* **TARGET_BASE**: The destination drive or folder where your backups will be stored.
* **JOB**: A list of subfolders paired with their sync mode.

In the example above, `documents` uses `mirror` mode, while `music` and `videos/series` use `append` mode.
If you want to keep things simple and just maintain an exact copy of your computer on your external drive, stick with `mirror` for everything.

**Available Sync Modes:**
* **append:** Copies new and modified files from source to target, leaving deleted or older files untouched on the backup drive.
* **mirror:** Keeps the target identical to the source by deleting obsolete files on the fly during the transfer. Best when the backup disk has plenty of free space.
* **pre-purge:** A space-saving exact mirror. Scans and deletes all obsolete files from the target first before copying new data. Use this when your backup drive is low on free space so removed files make room before new ones arrive.

### 6) Restore Files from a Backup
A restore job copies your files back from your external backup drive to your laptop or desktop computer.
You can also use this workflow to keep your files synchronized across multiple computers:

```
LAPTOP 1  ---backup--->  EXTERNAL DRIVE  ---restore--->  LAPTOP 2
```

**Create a Restore Job Script**

Configuring a restore job works the exact same way as setting up a backup in [(5) Backup your files and Directories](https://github.com/zappee/backup-and-restore-tool/tree/big-refactor#5-backup-your-files-and-directories).
You simply swap the `SOURCE_BASE` and `TARGET_BASE` paths and adjust the sync modes in the `JOB` list as needed.

A good naming convention for your automated restore script is `sync-from-<media-label>.sh` (matching with `sync-to-portable-2.sh`).

Below is an example restore configuration that reverses the backup setup from earlier:

```console
readonly SCRIPT_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_HOME}/lib/sync-lib.sh"

readonly SOURCE_BASE="$HOME/Mount/portable-2"  # <-- important
readonly TARGET_BASE="$HOME/Workspace"         # <-- important

readonly JOB=(
  "documents        | mirror"
  "finance          | mirror"
  "holiday          | mirror"
  "music            | mirror"
  "photo-album      | mirror"
  "videos/series    | mirror"
  "videos/my-videos | mirror"
  "work             | mirror"
)

run_job "$SOURCE_BASE" "$TARGET_BASE" "${JOB[@]}"
```

### 7) How it works
When you start a backup or restore job, the tool stops and asks for your confirmation twice to protect your data from accidental loss:

1. **First prompt: Dry-run preview** The script simulates the sync without modifying any data, showing you the exact differences between your source and target folders. It displays a list of the upcoming changes and pauses for your approval.
2. **Second prompt: Final confirmation** Once you review and approve the preview, the tool displays a final warning before writing any changes to the destination drive.

   ![backup](assets/images/menu/opensource/backup-and-restore-tool/backup-workflow.png)

### 8) Understanding `rsync` outputs
When the comparison table scrolls past during Step 1, you can read the structural shortcodes (`YXcstpoguax`) using this reference pattern:

* **First character (`Y`):** The action type, e.g., `>` file received, `<` file sent, `c` local creation, `.` metadata-only change.
* **Second character (`X`):** The item type, `f` for file, `d` for directory, `L` for symlink.
* **Attributes (`cstpoguax`):** Identifies property updates where `s` indicates a modified file size, `t` flags a timestamp update, and `p` warns of permission variations.

### 9) Source code

[https://github.com/zappee/backup-and-restore-tool](https://github.com/zappee/backup-and-restore-tool)

### 10) 🤝 Contributing

Contributions, feature requests, optimization, and bug reports are always welcome!
