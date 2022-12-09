# What is Ubuntu's autoinstall?

Autoinstall "lets you answer all those configuration questions ahead of time with an autoinstall config and lets the installation process run without any interaction."

Autoinstall is only available in Ubuntu 20.04 or later.

Autoinstall uses a cloud-init-like configuration but does not have all the modules of cloud-init. When in doubt, check autoinstall's reference docs for the exact supported keys / values. If it's not in the docs, it most likely won't work.

The live-server uses autoinstall directives to seed answers to configuration prompts during system installation to allow for a "touchless" or non-interactive Ubuntu system install.

[source](https://jimangel.io/posts/automate-ubuntu-22-04-lts-bare-metal/#what-is-ubuntus-autoinstall)
