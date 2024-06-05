Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F618FC98
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582536; cv=none; b=VVyk2dfmAjAR2QzbYKh1GvLqh1+GWxWlU3bzwrvjTMVfHmRSxbYxBkIY3CRlpUrBDZSgIfI9AmDyxU+1mYauD1idvTYe7oD8bO2xD4LxRdd34aNgiPWlr3QhvplI92bfLpnNvX6Mn1JcsL+1Jl6/loZ4IcUEfC98H4N9CBsWb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582536; c=relaxed/simple;
	bh=tbuZWMATusTeUk5xYS7+qOyiUtAwr37B8otq+KPspmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRLb8XRZBTOTVILVgTLIh8CYqQR4ch4Hfwr14yirqLAX10Dmp69jM09wpREdosxsjcuPbobnERXzIFhKmjDSCO5Om34dolAyNs0fgiTjILlsbjUkpRoWtkjhhKGeOTnLXM3qWSlnvtRMJ4zMJiAoNeDP7s4BAqnoUEjFyz99gK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULDVm+pr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULDVm+pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717582533; x=1749118533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tbuZWMATusTeUk5xYS7+qOyiUtAwr37B8otq+KPspmE=;
  b=ULDVm+pru82GL/Ps/LVlA/UJdMx9Iu+zrzBi8toffmQfVJmHlh4PewfI
   RaQ7To7kVNUcifhNV7ggk2CjO+zrYhuO9SL322HbOigx1IAxZ+MRokAhn
   rG6J6JXvWTYe5tpdP0NCrFdlOqlwkrUDaYNTN3tkCd+MKH8qMzav37sLb
   yU1E+v8uXOmRnnA3AD5NvwBGFTSIetEf+MVvMroodpbFxQMqdQ1i3LW45
   t1z80DsiLQqYiaJQ2yfyWHmphd2c1nDX6aYHPrV5zsT76fYYeD2sw5TdA
   pnuEtfso/rFVxYJHZk0VT3pv0SujhRTaHb1Y3L9lHj/Hsp0Fp0JkroJHk
   w==;
X-CSE-ConnectionGUID: tZE16Y/7Seq2+Tz5T4vj0A==
X-CSE-MsgGUID: 3cTGnvB0Rr2Tq1OvQgJ5pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="18022582"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="18022582"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:15:33 -0700
X-CSE-ConnectionGUID: hgkMrcONQ8CLYtDEtAuR6g==
X-CSE-MsgGUID: 4A+QY6QIQFid364atFOCPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37482702"
Received: from liuliu-mobl1.amr.corp.intel.com (HELO ming-ws..) ([10.255.30.91])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:15:31 -0700
From: Li Ming <ming4.li@intel.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: Li Ming <ming4.li@intel.com>
Subject: [PATCH v2 1/1] cxl/mem: Fix no cxl_nvd during pmem region auto-assembing
Date: Wed,  5 Jun 2024 18:15:24 +0800
Message-Id: <20240605101524.2244180-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CXL subsystem is auto-assembling a pmem region during cxl
endpoint port probing, always hit below calltrack.

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
between cxl_nvd registration and adding endpoint port to guarantee there
is a cxl_nvd in memdev during the pmem region auto-assembling.

Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming4.li@intel.com>
---

v2:
- fix wrong function name in the description of
cxl_find_nvdimm_bridge()(lkp)


 drivers/cxl/core/pmem.c   | 15 ++++++++++-----
 drivers/cxl/core/region.c |  2 +-
 drivers/cxl/cxl.h         |  4 ++--
 drivers/cxl/mem.c         | 17 +++++++++--------
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index e69625a8d6a1..78c6f4672fcf 100644
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
base-commit: 49ba7b515c4c0719b866d16f068e62d16a8a3dd1
2.34.1

