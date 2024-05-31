Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DB81AC8
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138981; cv=none; b=O+o19KP1hdoYJDBRpEnw8wJRt85h+ASAiFVwyYAIp5tvDP8wojX/sE/6tS2Ih9+fMgHhKJBnhIz30gz3AvFz/Sd7lnCeN+QtAxObmT4WdLjyRI2hLKVtHRDaoZKh2ZEkwfX+IN8A+u6Ww0p3METwfRosM7crT80Ynkf/9vhasW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138981; c=relaxed/simple;
	bh=03usN0ICS4NpHsCYxcbn2gLihsVkCekYNUDmy2lKHxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WOFNYhu2jbKxjeYQiRr285QyuevdqWoofqK+5A3KX8Y5aaDEtqGnvaeBf39PH981M64Pdl/SDrmtQzm5SXG3+vaPFGrMTmY0cvEYqaFegU+xp22fQXVzlVlJix+JFccFZwXQ7sdkuO2suNVYfdVjHFQ5Fmh+SP+V6V3TY9rKHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxE9bYbv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxE9bYbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717138979; x=1748674979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=03usN0ICS4NpHsCYxcbn2gLihsVkCekYNUDmy2lKHxU=;
  b=YxE9bYbvgGOSFGxk5bUWWTwQDDAykG834dbLJVI+EkazvLg4XK0oU5iQ
   holctzXym3beNOg23ccfaAuE6liG+V40sI92lC5naOsfuOOvQ3D8zTG4b
   DBDeDbpSg9ONS926GDp4MRLxx1IrEI7gDHoqiFPQLSsT1QUea+sqWxMAw
   Sdfjv7mldfLedpfAoSPS2EUqvqzOUEQcNsT32iRECLyHAD2t+761Eg6Yc
   5+b7gmlJSoz7oQHnuNobzuxZBEdDefVxsI2xpoOCleYgimPN3vhe+PxW6
   8ZkaF6Rz1srBPB8GxW+tJZBjjdZ8QUQqkTcvHnEN/1XCM4CpgrrtVxpg4
   g==;
X-CSE-ConnectionGUID: JrYizc01RbWJ9KNRXiI9bw==
X-CSE-MsgGUID: J5ry/ZrtSgeQPmV6WUbkbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13836192"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13836192"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 00:02:56 -0700
X-CSE-ConnectionGUID: 3YuzdLJ4R5qIkREwl06CKw==
X-CSE-MsgGUID: xiq9QJ56SOO08QQbmPaZpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36147506"
Received: from yigan-mobl.ccr.corp.intel.com (HELO ming-ws..) ([10.254.213.6])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 00:02:54 -0700
From: Li Ming <ming4.li@intel.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: Li Ming <ming4.li@intel.com>
Subject: [PATCH 1/1] cxl/mem: Fix no cxl_nvd during pmem region auto-assembing
Date: Fri, 31 May 2024 15:02:29 +0800
Message-Id: <20240531070229.1596811-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CXL subsystem is auto-assembling a pmem region during cxl
endpoint port probing, always output below calltrace.

 BUG: kernel NULL pointer dereference, address: 0000000000000078
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 RIP: 0010:cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
 Call Trace:
  <TASK>
  ? __die+0x24/0x70
  ? page_fault_oops+0x82/0x160
  ? do_user_addr_fault+0x65/0x6b0
  ? exc_page_fault+0x7d/0x170
  ? asm_exc_page_fault+0x26/0x30
  ? cxl_pmem_region_probe+0x22e/0x360 [cxl_pmem]
  ? cxl_pmem_region_probe+0x1ac/0x360 [cxl_pmem]
  cxl_bus_probe+0x1b/0x60 [cxl_core]
  really_probe+0x173/0x410
  ? __pfx___device_attach_driver+0x10/0x10
  __driver_probe_device+0x80/0x170
  driver_probe_device+0x1e/0x90
  __device_attach_driver+0x90/0x120
  bus_for_each_drv+0x84/0xe0
  __device_attach+0xbc/0x1f0
  bus_probe_device+0x90/0xa0
  device_add+0x51c/0x710
  devm_cxl_add_pmem_region+0x1b5/0x380 [cxl_core]
  cxl_bus_probe+0x1b/0x60 [cxl_core]

Because the cxl_nvd of the memdev is necessary during pmem region
probing, but the cxl_nvd can be registered only after endpoint port
probing done, that is a collision dependency, so adjust the sequence
between cxl_nvd registration and endpoint port registration to guarantee
there is a cxl_nvd in memdev during the pmem region auto-assembling.

Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/pmem.c   | 15 ++++++++++-----
 drivers/cxl/core/region.c |  2 +-
 drivers/cxl/cxl.h         |  4 ++--
 drivers/cxl/mem.c         | 17 +++++++++--------
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index e69625a8d6a1..31b398c13be9 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -62,10 +62,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 	return is_cxl_nvdimm_bridge(dev);
 }
 
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
+/**
+ * cxl_nvdimm_bridge() - find a bridge device relative to a port
+ * @port: any descendant port of an nvdimm-bridge associated
+ *        root-cxl-port
+ */
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port)
 {
-	struct cxl_root *cxl_root __free(put_cxl_root) =
-		find_cxl_root(cxlmd->endpoint);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct device *dev;
 
 	if (!cxl_root)
@@ -242,18 +246,19 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
 
 /**
  * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
+ * @port: parent port for the (to be added) @cxlmd endpoint port
  * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
  *
  * Return: 0 on success negative error code on failure.
  */
-int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
+int devm_cxl_add_nvdimm(struct cxl_port *port, struct cxl_memdev *cxlmd)
 {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
 	struct device *dev;
 	int rc;
 
-	cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
+	cxl_nvb = cxl_find_nvdimm_bridge(port);
 	if (!cxl_nvb)
 		return -ENODEV;
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c2b6144be23..f0cafc7ffb45 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2847,7 +2847,7 @@ static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
 		 * bridge for one device is the same for all.
 		 */
 		if (i == 0) {
-			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
+			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
 			if (!cxl_nvb)
 				return -ENODEV;
 			cxlr->cxl_nvb = cxl_nvb;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 603c0120cff8..e8fca6c6952b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -855,8 +855,8 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm_bridge(struct device *dev);
-int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
+int devm_cxl_add_nvdimm(struct cxl_port *port, struct cxl_memdev *cxlmd);
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0c79d9ce877c..2f1b49bfe162 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -152,6 +152,15 @@ static int cxl_mem_probe(struct device *dev)
 		return -ENXIO;
 	}
 
+	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
+		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
+		if (rc) {
+			if (rc == -ENODEV)
+				dev_info(dev, "PMEM disabled by platform\n");
+			return rc;
+		}
+	}
+
 	if (dport->rch)
 		endpoint_parent = parent_port->uport_dev;
 	else
@@ -174,14 +183,6 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
-		rc = devm_cxl_add_nvdimm(cxlmd);
-		if (rc == -ENODEV)
-			dev_info(dev, "PMEM disabled by platform\n");
-		else
-			return rc;
-	}
-
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
-- 
2.34.1

