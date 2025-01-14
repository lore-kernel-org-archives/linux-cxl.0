Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9E236EC1
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jan 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860260; cv=none; b=mcFN+nE8Q+a/2mAoKKxVqvBRvZgra3y2ihUkB86f0qBUpe4NKcbU6CpdNARChG4l6IVlLe2lOMv3yuyPuDyS25vFc9FczzmpbrSbrJHNnkvqPplIBMl197+x5bcrAF438N/AQwVMbKcou1CSpBigJaVPzd5nQbQljrJAsXzXWAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860260; c=relaxed/simple;
	bh=2FKm3PARaank/rM4uLLrQeK12n8sdb7jQrO3WkWy9YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ahyxK8ju4HE2uy+5w61iQNfIeSlFuivjvAPvNP8qiJ6OHP8kfx5oN6Wy14pjAvFfQgi+Kf96tcr9nNQdXKK5kjSOIfJ3l4n9TYAdoKcrVDd/l/bLsW4bpBYK2iDZRk4Ol8L4wKnmzq5LOfr+uVrzEPy7xKwo0+6VC0zarKsNx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlPWCIW1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlPWCIW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736860258; x=1768396258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2FKm3PARaank/rM4uLLrQeK12n8sdb7jQrO3WkWy9YA=;
  b=jlPWCIW1vd4RstB7CteB4Rss4HBFAhVFdFn/DgEJpEUytSRp186w49cD
   lbGRyM6NnHXXb2e46/nrkMMCIVAgD6BF9LqI+OSEmNB79HO3pE7myBLb9
   XvJa/PcsKOgqPXSZiginNt4R6m0hqhsPZt5wwCon1nMTbB1r7yZ6Xv+Nq
   dRjwTSEWCJEBw19vOw9g16xdR14Y30tIwOTAtfM/6ZbPd84SA2sCIa95m
   RY+Ivu4KVmToI5FxcUM+hx7bcmr8WuampRroefh9f7U8y7ld3Bftif1lF
   q4eTObvhmz9g2WGJtcDPD5n4m85KyQ0lKoXVGHuHJLLrhpuUnuRJ1qHLl
   w==;
X-CSE-ConnectionGUID: ZijiEEHqS0Wsngv+NqGUBQ==
X-CSE-MsgGUID: 77CGeX30TI+IwuzTvMAIOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54695982"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="54695982"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 05:10:58 -0800
X-CSE-ConnectionGUID: JPlIve8NSYS2ps8Mg+t0gA==
X-CSE-MsgGUID: 8hNOvhUsS42HiJBFIbFLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128050893"
Received: from unknown (HELO ixc04.bj.intel.com) ([10.238.153.130])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 05:10:56 -0800
From: Huaisheng Ye <huaisheng.ye@intel.com>
To: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	ming.li@zohomail.com
Cc: pei.p.jia@intel.com,
	linux-cxl@vger.kernel.org,
	Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [PATCH v4 1/1] cxl/core/regs: Refactor out functions to count regblocks of given type
Date: Tue, 14 Jan 2025 21:10:41 +0800
Message-Id: <20250114131041.17512-2-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250114131041.17512-1-huaisheng.ye@intel.com>
References: <20250114131041.17512-1-huaisheng.ye@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock was
added for counting regblocks of a given RBI (Register Block Identifier).
It is workable, but the implementation can be improved.

1. In order to get the count of instances, cxl_count_regblock has to tentatively
repeat the call of cxl_find_regblock_instance by increasing index from 0. It
will not stop until an error value is returned. Actually, It needs to search for
Register Blocks in dvsec again every time by taking a start from the head. The
operations can be optimized.

For example, to determine if PMU1 exists, cxl_find_regblock_instance must check
all Register Blocks by the type and index from RB1 to RB4, starting from scratch,
even if PMU0 just has been searched. If there are more RBs of the same type in the
future, the situation will be even worse.

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
all function calls. This is a good behavior, but existing cxl_count_regblock
couldn't return error codes.

With this patch, only need to have minor modifications in
__cxl_find_regblock_instance, which can return the count of regblocks by given
RBI in just one call. It is more effective than before. Besides, the error code
could be obtained by the called function, here is cxl_pci_probe.

Based on the above reasons, refactor out cxl_count_regblock and create
__cxl_find_regblock_instance for counting instances more efficiently.

Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Changes
=======
v3 -> v4:
1. Simplify code comments of __cxl_find_regblock_instance() (Jonathan)
2. Move testing setup to cover letter (Jonathan)
3. Get Reviewed-by from Jonathan

---
 drivers/cxl/core/regs.c | 52 +++++++++++++++++++++++++----------------
 drivers/cxl/cxl.h       |  3 ++-
 drivers/cxl/pci.c       |  6 ++++-
 3 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 59cb35b40c7e..dd1fe83db366 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -290,19 +290,15 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 }
 
 /**
- * cxl_find_regblock_instance() - Locate a register block by type / index
- * @pdev: The CXL PCI device to enumerate.
- * @type: Register Block Indicator id
- * @map: Enumeration output, clobbered on error
- * @index: Index into which particular instance of a regblock wanted in the
- *	   order found in register locator DVSEC.
- *
- * Return: 0 if register block enumerated, negative error code otherwise
+ * __cxl_find_regblock_instance() - Locate a register block or count instances by type / index
+ * Use CXL_INSTANCES_COUNT for @index if counting instances.
  *
- * A CXL DVSEC may point to one or more register blocks, search for them
- * by @type and @index.
+ * __cxl_find_regblock_instance() may return:
+ * 0 - if register block enumerated.
+ * >= 0 - if counting instances.
+ * < 0 - error code otherwise.
  */
-int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
+static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, int index)
 {
 	u32 regloc_size, regblocks;
@@ -342,8 +338,30 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 	}
 
 	map->resource = CXL_RESOURCE_NONE;
+	if (index == CXL_INSTANCES_COUNT)
+		return instance;
+
 	return -ENODEV;
 }
+
+/**
+ * cxl_find_regblock_instance() - Locate a register block by type / index
+ * @pdev: The CXL PCI device to enumerate.
+ * @type: Register Block Indicator id
+ * @map: Enumeration output, clobbered on error
+ * @index: Index into which particular instance of a regblock wanted in the
+ *	   order found in register locator DVSEC.
+ *
+ * Return: 0 if register block enumerated, negative error code otherwise
+ *
+ * A CXL DVSEC may point to one or more register blocks, search for them
+ * by @type and @index.
+ */
+int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
+			struct cxl_register_map *map, unsigned int index)
+{
+	return __cxl_find_regblock_instance(pdev, type, map, index);
+}
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock_instance, "CXL");
 
 /**
@@ -360,7 +378,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_find_regblock_instance, "CXL");
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map)
 {
-	return cxl_find_regblock_instance(pdev, type, map, 0);
+	return __cxl_find_regblock_instance(pdev, type, map, 0);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, "CXL");
 
@@ -371,19 +389,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, "CXL");
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
+	return __cxl_find_regblock_instance(pdev, type, &map, CXL_INSTANCES_COUNT);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, "CXL");
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad38..7fc456d5b917 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -302,10 +302,11 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
 
+#define CXL_INSTANCES_COUNT -1
 enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
-			       struct cxl_register_map *map, int index);
+			       struct cxl_register_map *map, unsigned int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6d94ff4a4f1a..a96e54c6259e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -907,7 +907,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
-	int i, rc, pmu_count;
+	int rc, pmu_count;
+	unsigned int i;
 	bool irq_avail;
 
 	/*
@@ -1009,6 +1010,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return rc;
 
 	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
+	if (pmu_count < 0)
+		return pmu_count;
+
 	for (i = 0; i < pmu_count; i++) {
 		struct cxl_pmu_regs pmu_regs;
 
-- 
2.39.3

