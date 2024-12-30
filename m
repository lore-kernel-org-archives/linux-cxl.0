Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1892AD3B
	for <linux-cxl@vger.kernel.org>; Mon, 30 Dec 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735561450; cv=none; b=tUUJc0GrjJkepQgrifCdZ2T4K9LJUKG/bFOVJ1DnEHZpGDfrYKLiIauacHC/ptxni8OyXozfVpPxMJj6x9a5xxmr5hETtitk/eHdvfhPDdOKWK4aX6vwJaDjR0xrV7kJVDPzp5kcRXZDptP/ePABkQeUI0RSEIaU/LSGI++1RYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735561450; c=relaxed/simple;
	bh=VpCw0HjifuHWa621HvXmywubwmpdUHTMblqiZcqKPJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i8Cl7R4Y5k2d6TT5Y6E/xfPOVWkRGcXHgpADeTeARYLZMLLJfDLlcJ0zVZON//WtHafd2TNj8KSau+Vp41WL4j1wZB5IlePvPrnP4Ffogs1kWXdcP/AuHOHSWu1qvfFt/QTBj+YBmFgHtp+DCsM+1ZtglADhPf+af7866DGm3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8HIyj34; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8HIyj34"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735561448; x=1767097448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VpCw0HjifuHWa621HvXmywubwmpdUHTMblqiZcqKPJ8=;
  b=C8HIyj347zv8IrgOGw//Wf1HrljPcq0DPF1gn8YoC86d7+5fpM2tv0r7
   WdCqGgObK3eSpSmHtAynr7DdO/57rPbQUoz9sQJ4cuKWVpdBwCaSIFY55
   jqeBGztIB9vTsiftQ1uLMmAiiGfqJ5r09CEMPtI8i2VDx3CkxKggDR3W+
   QKnZJzhkmHwvmbwY1S7g9djwAklEgInr2AE+jC9GnKvXkZ0sv8EbRyg+R
   ZqLs6/nMaB4BYVFLSXkQ1EkpzA9lEmNNPF84twSfs/BN99oOuNl44nUGL
   OhaXqdnH9leRr0HaGx2Fsu6yc+TRx2Ogr1pgFOiMOyjKKZjET2KF+uuDz
   Q==;
X-CSE-ConnectionGUID: wbab8MrCTM2jkQoyQy/tXQ==
X-CSE-MsgGUID: OV9CiKr9T2KAIYoPORavpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="35155210"
X-IronPort-AV: E=Sophos;i="6.12,276,1728975600"; 
   d="scan'208";a="35155210"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 04:24:08 -0800
X-CSE-ConnectionGUID: jwimBqPWT/eH8g4zrpCzkw==
X-CSE-MsgGUID: U6ICZjvES1WqSjg5jOZf4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,276,1728975600"; 
   d="scan'208";a="101288403"
Received: from unknown (HELO ixc04.bj.intel.com) ([10.238.153.130])
  by fmviesa009.fm.intel.com with ESMTP; 30 Dec 2024 04:24:05 -0800
From: Huaisheng Ye <huaisheng.ye@intel.com>
To: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	ming.li@zohomail.com
Cc: pei.p.jia@intel.com,
	linux-cxl@vger.kernel.org,
	Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [PATCH v2] cxl/core/regs: Refactor out functions to count regblocks of given type
Date: Mon, 30 Dec 2024 20:22:39 +0800
Message-Id: <20241230122239.3445117-1-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock was
added for counting regblocks of a given RBI (Register Block Identifier).
It is workable, but has two drawbacks that can be improved.

1. In order to get the count of instances, cxl_count_regblock has to tentatively
repeat the call of cxl_find_regblock_instance by increasing index from 0. It
will not stop until an error value is returned. Actually, It needs to search for
Register Blocks in dvsec again every time by taking a start from the head. This
is a bit inefficient.

For example, to determine if PMU1 exists, cxl_find_regblock_instance must check
all Register Blocks by the type and index from RB1 to RB4. If there are more RBs
of the same type in the future, the situation will be even worse.

16 81 00 23             PCIe extended Capability Header
02 c0 1e 98             Header 1
00 00 00 08             Header 2
--------------------------------------
00 00 01 00             RB 1 - Offset Low       Component
00 00 00 00             RB 1 - Offset High
--------------------------------------
00 00 03 02             RB 2 - Offset Low       Device Register
00 00 00 00             RB 2 - Offset High
--------------------------------------
00 01 04 02             RB 3 - Offset Low       PMU0
00 00 00 00             RB 3 - Offset High
--------------------------------------
00 02 04 02             RB 4 - Offset Low       PMU1
00 00 00 00             RB 4 - Offset High

RB: Register Block

2. cxl_count_regblock blocks the opportunity to get error codes from
cxl_find_regblock_instance. cxl_pci_probe has error code checking for almost
all function calls. This is a good behavior, but cxl_count_regblock couldn't.

With this patch, only need to add two lines of code in cxl_find_regblock_instance,
which can return the count of regblocks by given RBI in just one call. It is
more effective than before. Besides, the error code could be obtained by the
called function, here is cxl_pci_probe.

Based on the above reasons, refactor out cxl_count_regblock for counting
instances more efficiently.

This patch is tested by ndctl cxl_test and physical CXL expander card
with v6.13-rc5.

1. Ndctl CXL test suite v80 could pass with this patch applied.
$ meson test -C build --suite cxl
ninja: Entering directory `/home/work/source/ndctl/build'
[1/48] Generating version.h with a custom command
 1/11 ndctl:cxl / cxl-topology.sh               OK               3.48s
 2/11 ndctl:cxl / cxl-region-sysfs.sh           OK               2.74s
 3/11 ndctl:cxl / cxl-labels.sh                 OK               1.75s
 4/11 ndctl:cxl / cxl-create-region.sh          OK               3.51s
 5/11 ndctl:cxl / cxl-xor-region.sh             OK               1.89s
 6/11 ndctl:cxl / cxl-events.sh                 OK               1.63s
 7/11 ndctl:cxl / cxl-sanitize.sh               OK               4.48s
 8/11 ndctl:cxl / cxl-destroy-region.sh         OK               1.90s
 9/11 ndctl:cxl / cxl-qos-class.sh              OK               2.65s
10/11 ndctl:cxl / cxl-poison.sh                 OK               2.86s
11/11 ndctl:cxl / cxl-security.sh               OK               0.91s

2. Test patch with Qemu x4 switch topology:

                       ACPI0017:00 [root0]
                           |
                         HB_0 [port1]
                        /             \
                     RP_0             RP_1
                      |                 |
                USP [port2]
            /    /    \    \
          DSP   DSP   DSP   DSP
           |     |     |     |
          mem1  mem0  mem2  mem3

Every card has 2 PMU RBs, here are the pmu_mem devices.

$ pwd
/sys/bus/cxl/devices
$ tree
[snip]
├── pmu_mem0.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:01.0/0000:10:00.0/pmu_mem0.0
├── pmu_mem0.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:01.0/0000:10:00.0/pmu_mem0.1
├── pmu_mem1.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:00.0/0000:0f:00.0/pmu_mem1.0
├── pmu_mem1.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:00.0/0000:0f:00.0/pmu_mem1.1
├── pmu_mem2.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:02.0/0000:11:00.0/pmu_mem2.0
├── pmu_mem2.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:02.0/0000:11:00.0/pmu_mem2.1
├── pmu_mem3.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:03.0/0000:12:00.0/pmu_mem3.0
├── pmu_mem3.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:03.0/0000:12:00.0/pmu_mem3.1

Changes
=======
v1 -> v2:

1. Reserved cxl_count_regblock() for original function interface
2. Reset 'map->resource' to 'CXL_RESOURCE_NONE' before returning the count of instances in
   cxl_find_regblock_instance()
3. Append results of ndctl test suite and Qemu testing PMU devices to commit log
4. Rebase patch to v6.13-rc5

 [v1] https://lore.kernel.org/all/20241225083539.2230150-1-huaisheng.ye@intel.com/

Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
---
 drivers/cxl/core/regs.c | 19 +++++++++----------
 drivers/cxl/cxl.h       |  1 +
 drivers/cxl/pci.c       |  3 +++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 59cb35b40c7e..d0db954da0ff 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -290,17 +290,19 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 }
 
 /**
- * cxl_find_regblock_instance() - Locate a register block by type / index
+ * cxl_find_regblock_instance() - Locate a register block or count instances by type / index
  * @pdev: The CXL PCI device to enumerate.
  * @type: Register Block Indicator id
  * @map: Enumeration output, clobbered on error
  * @index: Index into which particular instance of a regblock wanted in the
  *	   order found in register locator DVSEC.
  *
- * Return: 0 if register block enumerated, negative error code otherwise
+ * Return: 0 if register block enumerated, non-negative if instances counted,
+ * negative error code otherwise
  *
  * A CXL DVSEC may point to one or more register blocks, search for them
  * by @type and @index.
+ * Use CXL_INSTANCES_COUNT for @index if counting instances by @type and @index.
  */
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, int index)
@@ -342,6 +344,9 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 	}
 
 	map->resource = CXL_RESOURCE_NONE;
+	if (index == CXL_INSTANCES_COUNT)
+		return instance;
+
 	return -ENODEV;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock_instance, "CXL");
@@ -371,19 +376,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, "CXL");
  *
  * Some regblocks may be repeated. Count how many instances.
  *
- * Return: count of matching regblocks.
+ * Return: non-negative count of matching regblocks, negative error code otherwise.
  */
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
 {
 	struct cxl_register_map map;
-	int rc, count = 0;
 
-	while (1) {
-		rc = cxl_find_regblock_instance(pdev, type, &map, count);
-		if (rc)
-			return count;
-		count++;
-	}
+	return cxl_find_regblock_instance(pdev, type, &map, CXL_INSTANCES_COUNT);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, "CXL");
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad38..18bd05f29354 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -302,6 +302,7 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
 
+#define CXL_INSTANCES_COUNT -1
 enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6d94ff4a4f1a..c68c4a0bdbe0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1009,6 +1009,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 
 	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
+	if (pmu_count < 0)
+		return pmu_count;
+
 	for (i = 0; i < pmu_count; i++) {
 		struct cxl_pmu_regs pmu_regs;
 
-- 
2.39.3

