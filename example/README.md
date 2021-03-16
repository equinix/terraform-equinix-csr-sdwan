# Equinix Network Edge example: Cisco CSR SD-WAN Edge device

This example shows how to create redundant Cisco CSR SD-WAN edge devices
on Platform Equinix using Equinix CSR SD-WAN Terraform module and
Equinix Terraform provider.

In addition to pair of CSR-SDWAN devices, following resources are being created
in this example:

* two ACL templates, one for each of the device

The devices are created in self managed, bring your own license modes.
Remaining parameters include:

* 1 Gbps of license throughput
* large hardware platform (6CPU cores, 4GB of memory)
* PREMIER software package
* path to license files for both devices
* site_id and system_ip_address for both devices
* 24 network interfaces on each device
* 100 Mbps of additional internet bandwidth on each device
