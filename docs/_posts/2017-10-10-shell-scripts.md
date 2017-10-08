---
layout: post
title: Shell Scripting
subtitle: Week 2 - basic Linux concepts and bash
bigimg: /img/turtle.jpg
---

From Wikipedia: 
> A shell is a user interface for access to an operating system's services.

The most basic shell is `sh`. 

`bash` is the most common shell for Linux. It has many more features and is easier to use than `sh`, and is nearly universal. There are other less common shells too, such as `fish` (Friendly Interactive SHell) and `zsh`.

# bash features

`*` represents a wild card. 

`$VAR` represents a variable. bash variables are typeless. 

Also know that `.` represents the current working directory, while `..` represents the parent directory. 

# Basic system administration

<https://github.com/jennydaman/twlinux/wiki/Installing-software-on-Linux>

# Filesystem Hierarchy Standard TL;DR

- `/` is the root of the filesystem, which holds all your system files.
- `/home` is where your user's directory is located. You have write access to your home folder only. Your home folder is denoted as `~` (tilde) by most shells, and it contains your documents, pictures, configurations, and other ordinary files.
- `/bin` is a symlink to `/usr/bin`, which contains executable binaries.
- `/boot` contains static files for the bootloader.
- `/dev` holds "block devices". Physical and logical devices can be interacted with through their block devices in `/dev`.
    - `/dev/sda` represents the first physical drive.
    - `/dev/sda1` is the first partition on that drive.
    - `/dev/null` is a pseudo-device that behaves much like `null` in any context of computer science. It discards any data written to it. 
- `/etc/` contains configuration files.
- `/lib` holds shared libraries.
- `/usr` is a seconday heirarchy containing mostly read-only data. 

See `man hier` or <https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard> for details.


### Weekly interesting thing

<https://github.com/thiderman/doge>