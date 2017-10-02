!. Introduction

I'm Jennings Zhang - Finished all 3 programming classes.

Mr. Marshall is the teacher sponsor - non-programming tech classes like microcomputer technology and network engineering. 

I built a website https://jennydaman.github.io/twlinux. I will post meeting briefs and summaries, as well as a few other resources. 

Mr. Marshall is offering an online Linux class provided by Cisco. If you are interested in this, talk to him. 

I have a bunch of notes here, we will just try to get as much as we can do within the contraints of time and this stupid network. 

*** 

Linux by itself is not an operating system, it is a **kernel**. The kernel is the layer by which software interacts with hardware. 

GNU, which stands for GNU's not UNIX, is a software distribution. When coupled with the Linux kernel, we get a complete operating system referred to as **GNU/Linux**.

Unlike Windows and MacOS, Linux is **open source**, meaning anyone is free to view and modify the source code. Many companies and communities alike come together to develop fully fledged GNU/Linux based operating systems. 

These operating systems often have specific use cases. Ubuntu is beginner friendly, Red Hat Enterprise Linux is great for servers. Solus is great for casual use. Arch is great for enthusiasts like myself. 

These distributions are light enough that a working environment can be fit into a USB. When a machine boots off a Linux USB, it enters a live session, where you can use the OS temporarily, or install it to the machine's internal disk permanently. 

# Install LINUX!!!

Installation will take around half an hour, so this would be a great time to learn a little bit about Linux and open source software. 

Ubuntu is an easy distro to start with, though I don't like it because it's bloated and clumsy. **Elementary OS** is a distro based on Ubuntu. Its desktop environment, Pantheon, is inspired by MacOS. Once you boot in you might see the similarities. As I've mentioned, every Linux distro is unique with their strengths and weaknesses. Elementary is based on Ubuntu, which has the largest market share, meaning it is supported well. It has a decent user interface with relatively few customization options.

Use **Gparted** to partition the hard drive. 

The MBR partition scheme only recognizes four primary paritions. We can work around this limitation by creating **logical partitions**.

1. Delete the unused NTFS partition at the end of the device. 
2. Resize the Windows C:\\ partition so that there is **60 GB** following space.
3. Create an **extended partition** in the free space.
4. Create a **logical partition** of the **ext4** format with **6 GB** of following space.
5. Format the last 6 GB as the **linux-swap** partition. 

## Boot process

The Dell computers are set to legacy BIOS boot mode. 

1. The BIOS performs the Power On Self Test (**POST**)
2. BIOS initializes the necessary hardware to boot.
3. BIOS reads the Master Boot Record (**MBR**, which is the first 512 bytes of data on a storage unit) for instructions how to boot.
4. The MBR usually points to a bootloader. In this case, **GRUB2**. 
5. GRUB2 loads the **Linux kernel**, then the initial ramdisk. 
6. The **initial ramdisk** is a temporary virtual disk which contains the minimum binaries needed to mount the real root partition. init is ran as PID 1. The default init system for Ubuntu is `systemd`.
7. Root is mounted.
8. `systemd` automatically starts the **X.org server**, which manages the graphical user interface. 
9. **LightDM** is the display manager, which is the login screen. 
10. After authentication, the **desktop environment** is loaded. 

## Basic UNIX concepts

POSIX file heirarchy standard:

`/` is the root directory. It contains all your system files. 

`/home/USER/` is your home directory, where your files are stored. Documents, pictures, videos...

While Linux can be used normally through one of many desktop environments which provide competent graphical user interfaces, for more advanced, granular control of our system, we work through a **line user interface**. 

A program called **bash** is what we call the **shell**. Shells are types of programs which allows the user to interact with an operating system through text based input and output (appreviated to I/O).

- `ls DIR` displays the contents of the directory `DIR`.

- `cd DIR` changes the current working directory to `DIR`.

- `touch FILE` creates a blank file called `FILE`.

- `cat` concatenates the input stream and prints to the output stream. (?)

    - `cat FILE` prints the content of `FILE`

    - `cat > FILE` will write the standard input stream out to `FILE`. End this command by pressing CTRL-D.

- `man COMMAND` shows the manual page for `COMMAND`.

There is a normal user, you, and there's a **superuser.** The superuser is the administrator account. 

Normally you cannot modify anything in / without elevated privileges. This is to protect the system from malicious commands. You can execute commands with `sudo` to run them as the superuser. This is dangerous with untruisted or unknown scripts. 

`apt` is a package manager for Debian based distros. Elementary is based on Ubuntu which is based on Debian. 

Unlike Windows, software is most commonly installed from a trusted centralized repository. Software must go through rigorous testing and meet standards for stability. Just like the Apple App Store, you can be sure that all software installed from Ubuntu's repositories are stable and virus-free. 

Sometimes, you might need to compile programs from scratch yourself if they were not found in the official repositories. 

Nevertheless, Linux is still more secure than Windows, not only because of the security advantages of being open source, but also because its users are fewer in numbers and generally more technologically literate. Hackers are much more likely to attack Windows operating systems if their intent is to exploit the easiest and most vulnerable population. Viruses on Linux do exist, most commonly in the form of rootkits, though these are almost always designed to attack a specific company's servers, rather than a general community of users. 

Try these commands: 

1. `sudo apt install sl`
2. `sl`
3. `man sl`
4. `sl -alFc`

