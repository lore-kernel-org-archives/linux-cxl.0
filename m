Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969F1369AF
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174683; cv=none; b=LGfW1cZfevn37edJeeLHZD8UJ8RjASAHf1co92mg8iK5oCIc6VJmW3rdXmmjZfz3ypN3tQKvCwRLb4brhnoxkS79iJ1WMXZxe5/YF4DmTbM8Iy1PT+tpbkGxDEH4KmrSUzMKaE9w0KZl+/H+rCt4zMhHnZt02ebLYzrRIVGRn8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174683; c=relaxed/simple;
	bh=enjD6fp97rDjCO5Bp5fTFg+gECDy9xJ6jMxLPlsDizI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j89QA3j3WenSNDx80+4lqAxsSdeSVyoVvUdt/bb23RvDhpscsY0JPTCkb7zgaWr8qVwFATXTPAhfLwwSY4OIdFsJOh3SlYFq6mbX9PWH7TJZRAXfI+v2MzZSQKTBeY9FCRqRszFLhF+6REVR5L+G2N4iwft5QZN0zfRroZgj8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKtJPo4/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKtJPo4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718174680; x=1749710680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=enjD6fp97rDjCO5Bp5fTFg+gECDy9xJ6jMxLPlsDizI=;
  b=LKtJPo4/mooGBI7ApiuV2/vSsTrg8SVONHW0KWNNEqjEqd9byrvog97l
   qkymPpl1+i/gDqmOUQqz5vDUtEX0+FXuz72TTjgiJ1LZFwRgaab18pN5o
   PxZ0npss/OUblt5LkmGFJl/NWqwWQio06C3+mxktqB8CBSELDOJbZAx6R
   Pn0QW/QKIE5xRwYwt5lJONV7+tU/qqzpX8VXuWMqNDv8PrnCmyjOqW4lq
   HTG64JVJFWRkBXzK5u0j/qLsOjewwPEAlKC5uGqCtxDrujTpCKcGIyL+g
   5MOdQlzQ22mxPD1EJFh8OlSnoZyRPYgdvE1VKsHe3qsD4FKKbCh5MRWs5
   Q==;
X-CSE-ConnectionGUID: tDjjopV4TMSqzL4WecxH0w==
X-CSE-MsgGUID: rhclXNU6SCCvnweO0GL6Bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25547778"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="25547778"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:44:40 -0700
X-CSE-ConnectionGUID: gWAFCEJVT6CcTtS5hk1EzA==
X-CSE-MsgGUID: w9vTuu4ISOaFOe54OY7b3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39615589"
Received: from yzha171-mobl1.ccr.corp.intel.com (HELO ming-ws..) ([10.249.168.88])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:44:38 -0700
From: Li Ming <ming4.li@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Li Ming <ming4.li@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 1/1] cxl/mem: Fix no cxl_nvd during pmem region auto-assembing
Date: Wed, 12 Jun 2024 14:44:23 +0800
Message-Id: <20240612064423.2567625-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CXL subsystem is auto-assembling a pmem region during cxl
endpoint port probing, always hit below calltrace.

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

The cxl_nvd of the memdev needs to be available during pmem region
probe. Currently the cxl_nvd is registered after the end port probe. The
end point probe, in the case of autoassembly of regions, can cause a
pmem region probe requiring the not yet available cxl_nvd. Adjust the
sequence so this dependency is met.
This requires adding a port parameter to cxl_find_nvdimm_bridge() that
can be used to query the ancestor root port. The endpoint port is not
yet available, but will share a common ancestor with it's parent, so
start the query from there instead.

Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

v3:
- rename the first parameter of devm_cxl_add_nvdimm() from port to
parent_port.(Jonathan)
- adjust changelog to be clearer.(Jonathan)
- add missing "Signed-off-by" and "Co-developed-by" for Dan.

v2:
- fix wrong function name in the description of
cxl_find_nvdimm_bridge().(lkp)

 drivers/cxl/core/pmem.c   | 16 +++++++++++-----
 drivers/cxl/core/region.c |  2 +-
 drivers/cxl/cxl.h         |  4 ++--
 drivers/cxl/mem.c         | 17 +++++++++--------
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index e69625a8d6a1..c00f3a933164 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -62,10 +62,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 	return is_cxl_nvdimm_bridge(dev);
 }
 
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
+/**
+ * cxl_find_nvdimm_bridge() - find a bridge device relative to a port
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
@@ -242,18 +246,20 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
 
 /**
  * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
+ * @parent_port: parent port for the (to be added) @cxlmd endpoint port
  * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
  *
  * Return: 0 on success negative error code on failure.
  */
-int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd)
+int devm_cxl_add_nvdimm(struct cxl_port *parent_port,
+			struct cxl_memdev *cxlmd)
 {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
 	struct device *dev;
 	int rc;
 
-	cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
+	cxl_nvb = cxl_find_nvdimm_bridge(parent_port);
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
index 603c0120cff8..42928926e0b2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -855,8 +855,8 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
 struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm_bridge(struct device *dev);
-int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
+int devm_cxl_add_nvdimm(struct cxl_port *parent_port, struct cxl_memdev *cxlmd);
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
base-commit: 49ba7b515c4c0719b866d16f068e62d16a8a3dd1
2.34.1

