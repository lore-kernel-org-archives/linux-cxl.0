Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461B13B7BC
	for <linux-cxl@vger.kernel.org>; Wed, 25 Dec 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115814; cv=none; b=MSADDgZ9SpB+oVRO/60FLNfkv32WgDnGLLQrTMTmf22Zs3NPzCmR+iL/mSTiC8CSkcuuCNmlCDBh0NjhPcnBqvBNegRx1znVYa+haUlyGhkk/FjQvzj5wkqrpKo/+zTfg5GuJPubXFf/qgsu+EgqQ5hdFp2qQJ1nVRdDI04RyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115814; c=relaxed/simple;
	bh=ID3qDUPKXECw4XJ1rJUAj16K/UiOCRsucEFa7BaBd70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M85eBoAOCE1Q/9tS9cEkXujG8XvosJISw4I2mgGAVBLd96PMZ7IGtinvnLp2NvgsGuYsnhUfDAliwiQAJ81sv3fChCghHvbg15OvBHFGGdWjj4+GWTFx5y1ZWYBWPSHfchpyyNbgzuRW02qkJntRlWZk/ux83MrJ9uxhchPpp30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxS3N9EB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxS3N9EB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735115811; x=1766651811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ID3qDUPKXECw4XJ1rJUAj16K/UiOCRsucEFa7BaBd70=;
  b=bxS3N9EB5fgs9kjabtstGS2jj9GAQhzmWlEsRSqkZH0p613bm1mZHxB2
   GIVNpkROrrnaMu/QCkvXXRDxroQ4X0kz1dfrjDuybkgGGvm4JGpUuLQt7
   csiu+YBEyms386kw6RyoMcZXRH5YrovJbTSCZ21awdj6ce9Ox67vqSv6W
   tH+1JPiQkOmnZH2JJd2M0TVF68EBCt4boGKbR5pqs3hirgJnAkY57mmBx
   UR3bihJNrp4YQTZ9FmaTXf3PdpFCDdgSV5o9KUVA24P+IY8624bscqXXj
   Ya2mg4ayAV3D1g7a6ZHhkyTb5RsCXoS6sQBUfb2NgbhQ0OF1XNzPEQYBY
   A==;
X-CSE-ConnectionGUID: Y/lnZApxSQSuXOKFOHTgIg==
X-CSE-MsgGUID: +/JmzCAJQgaN76/6E9g8xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="58030660"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; 
   d="scan'208";a="58030660"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 00:36:51 -0800
X-CSE-ConnectionGUID: 6FiD+a10Rvyl3iFb28kcuA==
X-CSE-MsgGUID: LhrKPiwlRtGiAqtpgJbgnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103760071"
Received: from unknown (HELO ixc04.bj.intel.com) ([10.238.153.130])
  by fmviesa003.fm.intel.com with ESMTP; 25 Dec 2024 00:36:49 -0800
From: Huaisheng Ye <huaisheng.ye@intel.com>
To: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com
Cc: pei.p.jia@intel.com,
	linux-cxl@vger.kernel.org,
	Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [PATCH] [RFC] cxl/core/regs: Refactor out functions to count regblocks of given type
Date: Wed, 25 Dec 2024 16:35:39 +0800
Message-Id: <20241225083539.2230150-1-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

16 81 00 23		PCIe extended Capability Header
02 c0 1e 98		Header 1
00 00 00 08		Header 2
--------------------------------------
00 00 01 00		RB 1 - Offset Low	Component
00 00 00 00		RB 1 - Offset High
--------------------------------------
00 00 03 02		RB 2 - Offset Low	Device Register
00 00 00 00		RB 2 - Offset High
--------------------------------------
00 01 04 02		RB 3 - Offset Low	PMU0
00 00 00 00		RB 3 - Offset High
--------------------------------------
00 02 04 02		RB 4 - Offset Low	PMU1
00 00 00 00		RB 4 - Offset High

RB: Register Block

2. cxl_count_regblock blocks the opportunity to get error codes from
cxl_find_regblock_instance. cxl_pci_probe has error code checking for almost
all function calls. This is a good behavior, but cxl_count_regblock couldn't.

With this patch, only need to add two lines of code in cxl_find_regblock_instance,
which can return the count of regblocks by given RBI in just one call. It is
more effective than before. Besides, the error code could be obtained by the
called function, here is cxl_pci_probe.

Based on the above reasons, cxl_count_regblock could be considered to remove.

This patch is tested by ndctl cxl_test and physical CXL expander card
with v6.12.

Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
---
 drivers/cxl/core/regs.c | 32 +++++++-------------------------
 drivers/cxl/cxl.h       |  2 +-
 drivers/cxl/pci.c       |  7 ++++++-
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e1082e749c69..d6b882a334d5 100644
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
+ * Return: 0 if register block enumerated, non-negative if counting instances,
+ * negative error code otherwise
  *
  * A CXL DVSEC may point to one or more register blocks, search for them
  * by @type and @index.
+ * Use CXL_INSTANCES_COUNT for @index if counting instances by @type.
  */
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, int index)
@@ -341,6 +343,9 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 		}
 	}
 
+	if (index == CXL_INSTANCES_COUNT)
+		return instance;
+
 	map->resource = CXL_RESOURCE_NONE;
 	return -ENODEV;
 }
@@ -364,29 +369,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
-/**
- * cxl_count_regblock() - Count instances of a given regblock type.
- * @pdev: The CXL PCI device to enumerate.
- * @type: Register Block Indicator id
- *
- * Some regblocks may be repeated. Count how many instances.
- *
- * Return: count of matching regblocks.
- */
-int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
-{
-	struct cxl_register_map map;
-	int rc, count = 0;
-
-	while (1) {
-		rc = cxl_find_regblock_instance(pdev, type, &map, count);
-		if (rc)
-			return count;
-		count++;
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, CXL);
-
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs)
 {
 	struct device *dev = map->host;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..3fbbd76da819 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -294,8 +294,8 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);
 
+#define CXL_INSTANCES_COUNT -1
 enum cxl_regloc_type;
-int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..5aa4dfda4a73 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -915,7 +915,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
+	rc = cxl_find_regblock_instance(pdev, CXL_REGLOC_RBI_PMU, &map, CXL_INSTANCES_COUNT);
+	if (rc < 0)
+		return rc;
+
+	pmu_count = rc;
+
 	for (i = 0; i < pmu_count; i++) {
 		struct cxl_pmu_regs pmu_regs;
 
-- 
2.39.3

