# What is cloud-init?

cloud-init is a service that runs at boot to provision a server or VM. cloud-init provides the ability to add SSH keys, provision disks, install applications, setup users, and more – all before the first "real" user interaction. cloud-init uses datasources (for example: GCP, AWS, Azure, NoCloud) as a way to abstract the configurations per cloud provider.

By default, cloud-init runs once; only on the first boot. It tracks the first boot by comparing the instance ID in the cache (/var/lib/cloud/data) against the instance ID at runtime.

On first boot cloud-init attempts to automatically find the datasource; unless something like `ds=DATASOURCE[;key=val;key=val]` is specified on the kernel boot command line. By using a USB volume named CIDATA, cloud-init autodetects that we’re using the "NoCloud" datasource.

There’s one required configuration object named "meta-data", with no extension, and is typically used by cloud providers to parameterize their instance data (left intentionally blank in this demo). The "user-data" file or object is used for configuring the "on boot" OS instructions.

[source](https://jimangel.io/posts/automate-ubuntu-22-04-lts-bare-metal/#what-is-cloud-init)
