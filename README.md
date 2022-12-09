# autoinstall-ubuntu

Collection of scripts to create a custom Ubuntu server image to automatically install bare metal machines.

## How-to

To create the custom image, execute the `create-ubuntu-iso.sh` script:

```bash
bash create-ubuntu-iso.sh
```

This will result in an Ubuntu ISO called: `ubuntu-22.10-autoinstall.iso`

## Configuration

To configure the details for autoinstall/cloud-init modify the `user-data` file.
