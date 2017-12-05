---
layout: post
title: Packet Sniffing 
subtitle: Week 7-9 - attacking internet connections
---

# Alphabet Soup

**TCP/IP** *(Transmission Control Protocol/Internet Protocol)*: a suite of communication protocols used to interconnect network devices on the internet.

**HTTP** *(Hypetext Transfer Protocol)*: application-layer protocol for transmitting documents.

**HTML** *(Hypertext Markup Language)*: describes the content of a webpage.

# Tracing HTTP Connections to the Internet

To compromise network traffic going outside the LAN, we must intercept traffic between the client and the router.

<center>
<img src="/twlinux/img/internet-topology.png" alt="internet topology">
</center>

Packets have a destination IP address of the router's **default gateway** when headed out to the public Internet.

[Wireshark](https://www.wireshark.org/) is a popular cross-platform network analysis tool. Using Wireshark, one can easily steal: 

- Website content.
- Usernames and passwords.
- Form data.
- Cookies (use the session ID to impersonate the victim)

<https://github.com/jennydaman/twlinux/wiki/Spying-on-HTTP-using-Wireshark>

# Week 9: password theft from SSL/TLS connections

HTTP is being phased out, however about 40% of internet traffic remains unencrypted.

<https://letsencrypt.org/stats/#percent-pageloads>

Decryption is infeasible, to attack SSL/TLS we should force unencrypted connections.

<https://github.com/jennydaman/twlinux/wiki/sslstrip>

Big sites use HSTS (HTTP Strict Transport Security) which can get pesky. We can try to get around it.

<https://github.com/jennydaman/twlinux/wiki/MitM-Framework>
