Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B38AEB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 21:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjFPVll (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjFPVlk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 17:41:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7630E7
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686951699; x=1718487699;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KD/WwmiqHJdHJiRbihNKfY4miUZ0EEIw7v5gAuYCvrA=;
  b=BHw7q/+UM1HIh7Z34fKYx5FpMgW34Z2r/1u8ZPEQNCUKlc4I3MiqNdUn
   VDriXzpQ+4mWfRX96zGPa9lYvvjHEdfjoMviMaTIh4R01K+p+cxFQ8Myb
   2izKxVcF/FzQb3Z0xbypyhiLRWaFuNA6oISNejqM+/9y2+j5J7oJzLtyF
   xPjcT8bRlJMwwy2S2RH6sXUAiLMeBGVea6Omtk2D6klSOTwkviqWg0KoK
   SyWG8qsPxAU6lgBEC2I4GGizrfD/eRCQHZL9QesxTO63Mhd3wlsg5BLho
   Cv7200Yo86+BY2hdKjSt6sob5upaIbJeXqgp0EazgdahIs+oO8DfmtJQp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422973107"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422973107"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="713028840"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="713028840"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.91])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:41:38 -0700
Subject: [PATCH v7 00/11] cxl: Add support for QTG ID retrieval for CXL
 subsystem
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 16 Jun 2023 14:41:37 -0700
Message-ID: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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
Both the ACPI series have been ack'd by Rafael. The access_coordinate patch has been ack'd
by GregKH. Please consider taking the entire series including the CXL bits for the next
convenient merge window. Thanks!

For v6, some of the patches has been split out to ease the review and upstream process.
The following have been split out from this series and are dependencies:
1. QTG series prep patches:
https://lore.kernel.org/linux-cxl/168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3/
2. ACPI CDAT handling
https://lore.kernel.org/linux-cxl/168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3/T/#t
3. 'node_hmem_attrs' to 'access_coordinates'
https://lore.kernel.org/linux-cxl/168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3/
4. ACPI hmat target update
https://lore.kernel.org/linux-cxl/168451341624.3465146.15355962690295941676.stgit@djiang5-mobl3/T/#t

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

---
Dave Jiang (11):
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
      cxl/mem: Add debugfs output for QTG related data


 Documentation/ABI/testing/debugfs-cxl   |  13 ++
 Documentation/ABI/testing/sysfs-bus-cxl |  34 ++++
 MAINTAINERS                             |   1 +
 drivers/cxl/Kconfig                     |   1 +
 drivers/cxl/acpi.c                      | 163 ++++++++++++++-
 drivers/cxl/core/Makefile               |   1 +
 drivers/cxl/core/cdat.c                 | 250 ++++++++++++++++++++++++
 drivers/cxl/core/mbox.c                 |   1 +
 drivers/cxl/core/memdev.c               |  46 +++++
 drivers/cxl/core/pci.c                  |  73 +++++++
 drivers/cxl/core/port.c                 | 113 ++++++++++-
 drivers/cxl/cxl.h                       |  79 ++++++++
 drivers/cxl/cxlmem.h                    |  23 +++
 drivers/cxl/cxlpci.h                    |  15 ++
 drivers/cxl/mem.c                       |  26 +++
 drivers/cxl/pci.c                       |  13 --
 drivers/cxl/port.c                      | 107 ++++++++++
 17 files changed, 938 insertions(+), 21 deletions(-)
 create mode 100644 drivers/cxl/core/cdat.c

---
base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6

