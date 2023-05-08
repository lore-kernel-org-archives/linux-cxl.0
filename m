Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76067C7EE25
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 20:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjEHUq5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjEHUq4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 16:46:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01A4688
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 13:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578814; x=1715114814;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N5dApcTJgVTkHJHcdJoZ0Qr4sT3qn/OqfiQAQeQQcGw=;
  b=IPVTni5QsVJ+nHRYCcRCSEjC4JtP6oTIlpJA+p2sto5mWJsKQaXZefj3
   8zTFzJIoblDbQKmgdZ4DS63aByYvkOU/GyrH27np8/6GzoIi+WznxGoxu
   MWkPbrel8XMGw68FiVBp75wKoxz2Rga7OgUf+aYFp4fcLD/+P5QjuXdYY
   fcWHjTBic4TpgDC4+IUwRhbzqWzYiv/yKQeB/9FgRYTxyPAqhICkPGGRs
   5WZfYIPdyX9f62/bVCGo0FsFctX/g2n9KkPAPeze4O5vo9FibxgXT1RVc
   sxtwhB3nND4EOrZ9VFQzadXxkV5i4jZFfBi0wgpfHrgZlWACT6tBv67yD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="330113981"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="330113981"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="763531144"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="763531144"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.172.228])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:46:54 -0700
Subject: [PATCH v5 00/14] cxl: Add support for QTG ID retrieval for CXL
 subsystem
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 May 2023 13:46:53 -0700
Message-ID: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

For v6, some of the patches has been split out to ease the review and upstream process.
The following have been split out from this series and are dependencies:
1. QTG series prep patches:
https://lore.kernel.org/linux-cxl/168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3/
2. ACPI CDAT handling
https://lore.kernel.org/linux-cxl/168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3/
3. 'node_hmem_attrs' to 'access_coordinates'
https://lore.kernel.org/linux-cxl/168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3/
4. ACPI hmat target update
https://lore.kernel.org/linux-cxl/168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3/

This series adds the retrieval of QoS Throttling Group (QTG) IDs for the CXL Fixed
Memory Window Structure (CFMWS) and the CXL memory device. It provides the QTG IDs
to user space to provide some guidance with putting the proper DPA range under the
appropriate CFMWS window for a hot-plugged CXL memory device.

The CFMWS structure contains a QTG ID that is associated with the memory window that the
structure exports. On Linux, the CFMWS is represented as a CXL root decoder. The QTG
ID will be attached to the CXL root decoder and exported as a sysfs attribute (qtg_id).

The QTG ID for a device is retrieved via sending a _DSM method to the ACPI0017 device.
The _DSM expects an input package of 4 DWORDS that contains the read latency, write
latency, read bandwidth, and write banwidth. These are the caluclated numbers for the
path between the CXL device and the CPU. The QTG ID is also exported as a sysfs
attribute under the mem device memory partition type:
/sys/bus/cxl/devices/memX/ram/qos_class
/sys/bus/cxl/devices/memX/pmem/qos_class
Only the first QTG ID is exported. The rest of the information can be found under
/sys/kernel/debug/cxl/memX/qtgmap where all the DPA ranges with the correlated QTG ID
are displayed. Each DSMAS from the device CDAT will provide a DPA range.

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

This series is based on Lukas's latest DOE changes [5]. Kernel branch with all the code can
be retrieved here [6] for convenience.

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

Dave Jiang (14):
      cxl: Add callback to parse the DSMAS subtables from CDAT
      cxl: Add callback to parse the DSLBIS subtable from CDAT
      cxl: Add callback to parse the SSLBIS subtable from CDAT
      cxl: Add support for _DSM Function for retrieving QTG ID
      cxl: Calculate and store PCI link latency for the downstream ports
      cxl: Store the access coordinates for the generic ports
      cxl: Add helper function that calculate performance data for downstream ports
      cxl: Compute the entire CXL path latency and bandwidth data
      cxl: Wait Memory_Info_Valid before access memory related info
      cxl: Move identify and partition query from pci probe to port probe
      cxl: Move read_cdat_data() to after media is ready
      cxl: Store QTG IDs and related info to the CXL memory device context
      cxl: Export sysfs attributes for memory device QoS class
      cxl/mem: Add debugfs output for QTG related data


 Documentation/ABI/testing/debugfs-cxl   |  11 ++
 Documentation/ABI/testing/sysfs-bus-cxl |  32 ++++
 MAINTAINERS                             |   1 +
 drivers/cxl/acpi.c                      | 154 ++++++++++++++++-
 drivers/cxl/core/Makefile               |   1 +
 drivers/cxl/core/cdat.c                 | 214 ++++++++++++++++++++++++
 drivers/cxl/core/mbox.c                 |   3 +
 drivers/cxl/core/memdev.c               |  26 +++
 drivers/cxl/core/pci.c                  | 156 ++++++++++++++++-
 drivers/cxl/core/port.c                 | 116 ++++++++++++-
 drivers/cxl/cxl.h                       |  71 ++++++++
 drivers/cxl/cxlmem.h                    |  21 +++
 drivers/cxl/cxlpci.h                    |  17 ++
 drivers/cxl/mem.c                       |  17 ++
 drivers/cxl/pci.c                       |  21 ---
 drivers/cxl/port.c                      | 134 ++++++++++++++-
 include/acpi/actbl1.h                   |   3 +
 17 files changed, 957 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cxl
 create mode 100644 drivers/cxl/core/cdat.c

--

