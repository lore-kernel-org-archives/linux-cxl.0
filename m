Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AE77657
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIRz6HxD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196148; x=1734732148;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=67/44qwNRFRCbYP7s5J5stVnCj6lbOhynFqY2O+WAus=;
  b=kIRz6HxDeMA2+n0Sce5tohQrFf81s3L48d6ffuy31UotoSUtY8qbKHjB
   /MsiRWYwUwcEXcu+/HFBkCyLk2X6/90rgPCySZPB3J+6jeshuxY/UNFms
   Uc2hC+mdbI+KiOvK/tFVhuRTiAImiwpK6jQoQzIR9QCsavwIFPwXvW9O/
   0ZvgKuaohzQc+2DaJO6eJ63OEvtq9QIz/3C79MzniQVzJUhhfj7JWPnhT
   /z2zMVku6PxceUvXfnDZep2yFOSTUcyEle4fA0tLKvGYbOHbVjd0aIMwC
   E6X2ra1dNFWkC/aS3zgp/bq7A7nrURS2ls8c5Z5g0VbOq4HFApb9Jtqaa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="14725592"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="14725592"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:02:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1024007920"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1024007920"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:02:25 -0800
Subject: [PATCH v15 00/19] cxl: Add support for QTG ID retrieval for CXL
 subsystem
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Len Brown <lenb@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:02:25 -0700
Message-ID: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Jonathan and Rafael,
Please take a look at [6/19 acpi: numa: Add setting of generic port system locality attributes].
I have changed the way the generic target coordinates are being updated. Thank you!

v15:
- Update the hmat generic targets via hmat_update_target_attrs() to retain the best
  performance numbers from HMAT table.
- Refactor qos_class valid checks to simplify (Jonathan)

v14:
- Fix 0day issue with fw_table usage (Dan)
- Move all DSMAS processing local to core/cdat.c (Dan)
- Change get_qos_class() to qos_class() (Dan)
- Fix perf entry allocation lifetime (Dan)
- Rename perf_prop_entry to cxl_dpa_perf (Dan)
- Cleanup gotos using DEFINE_FREE() (Dan)
- Move qos computation before regions arrive. (Dan)
- Drop unmatched perf list (Dan)
- Add target_lock locking for retrieving genport coordinates (Dan)

v13:
- Convert temp dsmas list to xarray, optimize DSLBIS matching (Dan)
- Add a cxl_test fix for mock ACPI cxl host bridge UID.

v12:
- Tested on hardware
- Rebased to v6.7-rc1
- Dropped all patches upstreamed
- Rebased against changes from Huang Ying for abstract distance calculation
- Do not fail if qos calculation not successful (Jonathan, Dan)
- Match generic target device_handle with UID
- Support storing multiple QTG IDs and match against multiple QTG IDs. (Dan)
- Fix link latency calculation loop.
- Add adjustment of genport latency from nsec to psec due to HMAT code normalization.
- Make cxl/core/cdat.o as part of cxl core build.
- See individual patches for detailed changes.

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

Previous series is here [5]. A git branch [6] is available as well.

[1]: https://www.computeexpresslink.org/download-the-specification
[2]: https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
[3]: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf
[4]: https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device%20SW%20Guide_Rev1p0.pdf
[5]: https://lore.kernel.org/linux-cxl/170248552797.801570.14580769385012396142.stgit@djiang5-mobl3/T/#t
[6]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg

base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
---

Dave Jiang (19):
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
      tools/testing/cxl: Add hostbridge UID string for cxl_test mock hb devices
      cxl: Store the access coordinates for the generic ports
      cxl: Add helper function that calculate performance data for downstream ports
      cxl: Compute the entire CXL path latency and bandwidth data
      cxl: Store QTG IDs and related info to the CXL memory device context
      cxl: Export sysfs attributes for memory device QoS class
      cxl: Check qos_class validity on memdev probe


 Documentation/ABI/testing/sysfs-bus-cxl |  34 ++
 drivers/acpi/numa/hmat.c                | 193 +++++++--
 drivers/acpi/tables.c                   |   5 +-
 drivers/base/node.c                     |  12 +-
 drivers/cxl/Kconfig                     |   3 +
 drivers/cxl/acpi.c                      | 157 +++++++-
 drivers/cxl/core/Makefile               |   1 +
 drivers/cxl/core/cdat.c                 | 515 ++++++++++++++++++++++++
 drivers/cxl/core/core.h                 |   2 +
 drivers/cxl/core/mbox.c                 |   2 +
 drivers/cxl/core/pci.c                  |  72 ++++
 drivers/cxl/core/port.c                 | 122 +++++-
 drivers/cxl/cxl.h                       |  40 ++
 drivers/cxl/cxlmem.h                    |  21 +
 drivers/cxl/cxlpci.h                    |  13 +
 drivers/cxl/mem.c                       |  67 ++-
 drivers/cxl/port.c                      |   3 +
 include/linux/acpi.h                    |  11 +
 include/linux/fw_table.h                |  21 +-
 include/linux/memory-tiers.h            |  10 +-
 include/linux/node.h                    |   8 +-
 lib/fw_table.c                          |  75 +++-
 mm/memory-tiers.c                       |  12 +-
 tools/testing/cxl/Kbuild                |   1 +
 tools/testing/cxl/test/cxl.c            |   4 +
 25 files changed, 1325 insertions(+), 79 deletions(-)
 create mode 100644 drivers/cxl/core/cdat.c

--

