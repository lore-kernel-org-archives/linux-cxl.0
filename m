Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C382AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2fgnfaq"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2236BE
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136826; x=1728672826;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E+24JKXmFdhmKf5wyharDRQcTFK8f40ngbL7CyDxeqQ=;
  b=J2fgnfaqfGHdZmbQ4ab5PiCogakKLofkyd/Wls4R7vMG2BIaZLq1JNis
   pmH4HSg0j1bUbLnrko8FgkRrFfokzzhc6wcUcjVRnDuRrZLaQAIj8GMNI
   Ok9rbShHGRyRa1Gxs4rZ7vTUqYbKGuna9LJFofFMFDdTgee+4U6jXV2iC
   fLhnHIW5alj9I4Nui1OSOWd7FNawae2yaKd4Rj9cUwLVyhFTTFv3v+Rtu
   GMKDC6vZeu8ebd8ms3gM63PVSxwNmQ+1uU4lOxrSudMFAO8aE14+aIgm3
   IIRJokpTh1jmAdMsv62IBTOtu+XRPr1cChDka3PTd92KOyQWVTeY07Jpl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="387864856"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="387864856"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898245559"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="898245559"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:51:42 -0700
Subject: [PATCH v11 00/22] cxl: Add support for QTG ID retrieval for CXL
 subsystem
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:53:30 -0700
Message-ID: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

cxl: Add support for QTG ID retrieval for CXL subsystem
v11:
- Add debug print for multiple DSMAS entries for a partition. (Jonathan)
- Change qos_class0 to qos_class. (Dan)
- Add verification of endpoint device's host bridge to root decoder targets. (Dan)
- See individual patches for additional changes.
v10:
- Remove memory allocation in DSM handler. Add input parameters to request number of ids
  to return. (Dan)
- Only export a single qos_class sysfs attribute, qos_class0 for devices. (Dan)
- Add sanity check of device qos_class against root decoders (Dan)
- Recombine all relevant patches for cxl upstream merge
- Rebased against v6.6-rc4
v9:
- Correct DSM input package to use integers. (Dan)
- Remove all endien conversions. (Dan)
v8:
- Correct DSM return package parsing to use integers
v7:
- Minor changes. Please see specific patches for log entries addressing comments
  from v6.
v6:
- Please see specific patches for log entries addressing comments from v5.
- Use CDAT sub-table structs as is, adjust w/o common header. Changing causes
  significant ACPICA code changes.
- Deal with table header now that is a union. (Jonathan)
- Move DSMAS list destroy to core/cdat.c. (Jonathan)
- Retain and display entire QTG ID list from _DSM. (Jonathan)

v5:
- Please see specific patches for log entries addressing comments from v4.
- Split out ACPI and generic node code to send separately to respective maintainers
- Reworked to use ACPI tables code for CDAT parsing (Dan)
- Cache relevant perf data under dports (Dan)
- Add cxl root callback for QTG ID _DSM (Dan)
- Rename 'node_hmem_attr' to 'access_coordinate' (Dan)
- Change qtg_id sysfs attrib to qos_class (Dan)

v4:
- Reworked PCIe link path latency calculation
- 0-day fixes
- Removed unused qos_list from cxl_memdev and its stray usages

v3:
- Please see specific patches for log entries addressing comments from v2.
- Refactor cxl_port_probe() additions. (Alison)
- Convert to use 'struct node_hmem_attrs'
- Refactor to use common code for genport target allocation.
- Add third array entry for target hmem_attrs to store genport locality data.
- Go back to per partition QTG ID. (Dan)

v2:
- Please see specific patches for log entries addressing comments from v1.
- Removed ACPICA code usages.
- Removed PCI subsystem helpers for latency and bandwidth.
- Add CXL switch CDAT parsing support (SSLBIS)
- Add generic port SRAT+HMAT support (ACPI)
- Export a single QTG ID via sysfs per memory device (Dan)
- Provide rest of DSMAS range info in debugfs (Dan)

Hi Dan,
Please consider taking the entire series including the CXL bits for the next
convenient merge window. Thanks!

This series adds the retrieval of QoS Throttling Group (QTG) IDs for the CXL Fixed
Memory Window Structure (CFMWS) and the CXL memory device. It provides the QTG IDs
to user space to provide some guidance with putting the proper DPA range under the
appropriate CFMWS window for a hot-plugged CXL memory device.

The CFMWS structure contains a QTG ID that is associated with the memory window that the
structure exports. On Linux, the CFMWS is represented as a CXL root decoder. The QTG
ID will be attached to the CXL root decoder and exported as a sysfs attribute (qos_class).

The QTG IDs for a device is retrieved via sending a _DSM method to the ACPI0017 device.
The _DSM expects an input package of 4 DWORDS that contains the read latency, write
latency, read bandwidth, and write banwidth. These are the caluclated numbers for the
path between the CXL device and the CPU. The list of QTG IDs are also exported as a sysfs
attribute under the mem device memory partition type:
/sys/bus/cxl/devices/memX/ram/qos_class
/sys/bus/cxl/devices/memX/pmem/qos_class
A mapping of DPA ranges and it's correlated QTG IDs are found under
/sys/kernel/debug/cxl/memX/qtgmap. Each DSMAS from the device CDAT will provide a DPA
range.

The latency numbers are the aggregated latencies for the path between the CXL device and
the CPU. If a CXL device is directly attached to the CXL HB, the latency
would be the aggregated latencies from the device Coherent Device Attribute Table (CDAT),
the caluclated PCIe link latency between the device and the HB, and the generic port data
from ACPI SRAT+HMAT. The bandwidth in this configuration would be the minimum between the
CDAT bandwidth number, link bandwidth between the device and the HB, and the bandwidth data
from the generic port data via ACPI SRAT+HMAT.

If a configuration has a switch in between then the latency would be the aggregated
latencies from the device CDAT, the link latency between device and switch, the
latency from the switch CDAT, the link latency between switch and the HB, and the
generic port latency between the CPU and the CXL HB. The bandwidth calculation would be the
min of device CDAT bandwidth, link bandwith between device and switch, switch CDAT
bandwidth, the link bandwidth between switch and HB, and the generic port bandwidth

There can be 0 or more switches between the CXL device and the CXL HB. There are detailed
examples on calculating bandwidth and latency in the CXL Memory Device Software Guide [4].

The CDAT provides Device Scoped Memory Affinity Structures (DSMAS) that contains the
Device Physical Address (DPA) range and the related Device Scoped Latency and Bandwidth
Informat Stuctures (DSLBIS). Each DSLBIS provides a latency or bandwidth entry that is
tied to a DSMAS entry via a per DSMAS unique DSMAD handle.

Test setup is done with runqemu genport support branch [6]. The setup provides 2 CXL HBs
with one HB having a CXL switch underneath. It also provides generic port support detailed
below.

A hacked up qemu branch is used to support generic port SRAT and HMAT [7].

To create the appropriate HMAT entries for generic port, the following qemu paramters must
be added:

-object genport,id=$X -numa node,genport=genport$X,nodeid=$Y,initiator=$Z
-numa hmat-lb,initiator=$Z,target=$X,hierarchy=memory,data-type=access-latency,latency=$latency
-numa hmat-lb,initiator=$Z,target=$X,hierarchy=memory,data-type=access-bandwidth,bandwidth=$bandwidthM
for ((i = 0; i < total_nodes; i++)); do
	for ((j = 0; j < cxl_hbs; j++ )); do	# 2 CXL HBs
		-numa dist,src=$i,dst=$X,val=$dist
	done
done

See the genport run_qemu branch for full details.

[1]: https://www.computeexpresslink.org/download-the-specification
[2]: https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
[3]: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf
[4]: https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device%20SW%20Guide_Rev1p0.pdf
[5]: https://lore.kernel.org/linux-cxl/20230313195530.GA1532686@bhelgaas/T/#t
[6]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
[7]: https://github.com/pmem/run_qemu/tree/djiang/genport
[8]: https://github.com/davejiang/qemu/tree/genport

base-commit: 178e1ea6a68f12967ee0e9afc4d79a2939acd43c
---

Dave Jiang (22):
      cxl: Export QTG ids from CFMWS to sysfs as qos_class attribute
      cxl: Add checksum verification to CDAT from CXL
      cxl: Add support for reading CXL switch CDAT table
      acpi: Move common tables helper functions to common lib
      lib/firmware_table: tables: Add CDAT table parsing support
      base/node / acpi: Change 'node_hmem_attrs' to 'access_coordinates'
      acpi: numa: Create enum for memory_target access coordinates indexing
      acpi: numa: Add genport target allocation to the HMAT parsing
      acpi: Break out nesting for hmat_parse_locality()
      acpi: numa: Add setting of generic port system locality attributes
      acpi: numa: Add helper function to retrieve the performance attributes
      cxl: Add callback to parse the DSMAS subtables from CDAT
      cxl: Add callback to parse the DSLBIS subtable from CDAT
      cxl: Add callback to parse the SSLBIS subtable from CDAT
      cxl: Add support for _DSM Function for retrieving QTG ID
      cxl: Calculate and store PCI link latency for the downstream ports
      cxl: Store the access coordinates for the generic ports
      cxl: Add helper function that calculate performance data for downstream ports
      cxl: Compute the entire CXL path latency and bandwidth data
      cxl: Store QTG IDs and related info to the CXL memory device context
      cxl: Export sysfs attributes for memory device QoS class
      cxl: Check qos_class validity on memdev probe


 Documentation/ABI/testing/sysfs-bus-cxl |  49 +++++
 MAINTAINERS                             |   2 +
 drivers/acpi/Kconfig                    |   1 +
 drivers/acpi/numa/hmat.c                | 172 +++++++++++++---
 drivers/acpi/tables.c                   | 178 +----------------
 drivers/base/node.c                     |  12 +-
 drivers/cxl/Kconfig                     |   1 +
 drivers/cxl/acpi.c                      | 152 ++++++++++++++-
 drivers/cxl/core/Makefile               |   1 +
 drivers/cxl/core/cdat.c                 | 249 ++++++++++++++++++++++++
 drivers/cxl/core/mbox.c                 |   1 +
 drivers/cxl/core/memdev.c               |  34 ++++
 drivers/cxl/core/pci.c                  | 125 ++++++++++--
 drivers/cxl/core/port.c                 | 124 +++++++++++-
 drivers/cxl/cxl.h                       |  74 +++++++
 drivers/cxl/cxlmem.h                    |  23 +++
 drivers/cxl/cxlpci.h                    |  15 ++
 drivers/cxl/mem.c                       | 121 ++++++++++++
 drivers/cxl/port.c                      | 123 +++++++++++-
 include/linux/acpi.h                    |  54 +++--
 include/linux/fw_table.h                |  52 +++++
 include/linux/node.h                    |   8 +-
 lib/Kconfig                             |   3 +
 lib/Makefile                            |   2 +
 lib/fw_table.c                          | 237 ++++++++++++++++++++++
 25 files changed, 1545 insertions(+), 268 deletions(-)
 create mode 100644 drivers/cxl/core/cdat.c
 create mode 100644 include/linux/fw_table.h
 create mode 100644 lib/fw_table.c

--

