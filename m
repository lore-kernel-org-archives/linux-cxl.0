Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB919F49E
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217280; cv=none; b=eOS9FSIKmWOhkTq8V/gHlfIHl7rPs7G3naU3aLqNd1BilBXiDmTpaA4O6OYluq+Hw3ZkX/Ww1zdhpaEXY4oY2vA/jMKlTbsb1iRK5id81eycslI78Z1suv+8tEnmNpuDa1l83NmXr+VvH7NnjXTj3tGtnRV8+OfQkoiQyHFpXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217280; c=relaxed/simple;
	bh=yngAGZe8cSQpVfq+dkWANJooBANcu1ToMdOMNQglSu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPSvV5G7A9bpeBa03+VtpwL7rfBVZRA8rVDU7xZbUPmF3+RmJisRQpHumKbOXxRxyOSz5aQdLkxe8Yh40SWVjpFGmZjqisJWXulU4uJZRXMS63dmUC7NQxLYmIm18LM+JuL1swCYlbK6n3H6CiNNpk8Wg+ia3Dn7FcZGsluMRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPhoU7wM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPhoU7wM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753217278; x=1784753278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yngAGZe8cSQpVfq+dkWANJooBANcu1ToMdOMNQglSu8=;
  b=bPhoU7wMLNvF3+MRZeUhuVN/ZRwmLTE94YkBEQdlhDSqeBoSA1ATbXqD
   hjPOb2qjTELAEbh3b/F4+K0n+lRAyoBHaL+bcsNpAbgsdAib61tsPl/lI
   15gPoDkFG3GaLgLXHwG1uXJRu3GGN45KrVZ5/JQfiK/M3G2Ptd/u8pZ3G
   FHaui12DOwITPYN50xGKFr1zQt4i/+A3MJ2iNTZ55kaelhHg3owvETIaG
   7cD4ZSK/gMnULvOvH5cKmVl0sVhLTFXg9leNAIgOlkGGOpSsIJb7asHdP
   adBR+9TDFqM5zyZdvSTKvwQr+Xk2qdtun8LBpwqj6pP/7bhWFh11V60i1
   Q==;
X-CSE-ConnectionGUID: HIMklViaQ16jcV3d5ezzSQ==
X-CSE-MsgGUID: xuzxC+gfQYe6CNVohzMnCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58100194"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="58100194"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:58 -0700
X-CSE-ConnectionGUID: 551cuJnlQzmc1ctCAMQN8Q==
X-CSE-MsgGUID: VFyMiPgYSzKkXggLjkzO5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="159001638"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.207])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:47:57 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 5/5] cxl/region: Add inject and clear poison by region offset
Date: Tue, 22 Jul 2025 13:47:44 -0700
Message-ID: <c2b92d82281600f97e4e26ae28d6a71f3094ebd3.1753214969.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1753214969.git.alison.schofield@intel.com>
References: <cover.1753214969.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Add CXL region debugfs attributes to inject and clear poison based
on an offset into the region. These new interfaces allow users to
operate on poison at the region level without needing to resolve
Device Physical Addresses (DPA) or target individual memdevs.

The implementation uses a new helper, region_offset_to_dpa_result()
that applies decoder interleave logic, including XOR-based address
decoding when applicable. Note that XOR decodes rely on driver
internal xormaps which are not exposed to userspace. So, this support
is not only a simplification of poison operations that could be done
using existing per memdev operations, but also it enables this
functionality for XOR interleaved regions for the first time.

New debugfs attributes are added in /sys/kernel/debug/cxl/regionX/:
inject_poison and clear_poison. These are only exposed if all memdevs
participating in the region support both inject and clear commands,
ensuring consistent and reliable behavior across multi-device regions.

If tracing is enabled, these operations are logged as cxl_poison
events in /sys/kernel/tracing/trace.

The ABI documentation warns users of the significant risks that
come with using these capabilities.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---

Changes in v4: none

 Documentation/ABI/testing/debugfs-cxl |  87 +++++++++++++++++
 drivers/cxl/core/core.h               |   4 +
 drivers/cxl/core/memdev.c             |   8 ++
 drivers/cxl/core/region.c             | 131 +++++++++++++++++++++++++-
 4 files changed, 227 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index 12488c14be64..e1f69e727190 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -19,6 +19,20 @@ Description:
 		is returned to the user. The inject_poison attribute is only
 		visible for devices supporting the capability.
 
+		TEST-ONLY INTERFACE: This interface is intended for testing
+		and validation purposes only. It is not a data repair mechanism
+		and should never be used on production systems or live data.
+
+		DATA LOSS RISK: For CXL persistent memory (PMEM) devices,
+		poison injection can result in permanent data loss. Injected
+		poison may render data permanently inaccessible even after
+		clearing, as the clear operation writes zeros and does not
+		recover original data.
+
+		SYSTEM STABILITY RISK: For volatile memory, poison injection
+		can cause kernel crashes, system instability, or unpredictable
+		behavior if the poisoned addresses are accessed by running code
+		or critical kernel structures.
 
 What:		/sys/kernel/debug/memX/clear_poison
 Date:		April, 2023
@@ -35,6 +49,79 @@ Description:
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
 
+		TEST-ONLY INTERFACE: This interface is intended for testing
+		and validation purposes only. It is not a data repair mechanism
+		and should never be used on production systems or live data.
+
+		CLEAR IS NOT DATA RECOVERY: This operation writes zeros to the
+		specified address range and removes the address from the poison
+		list. It does NOT recover or restore original data that may have
+		been present before poison injection. Any original data at the
+		cleared address is permanently lost and replaced with zeros.
+
+		CLEAR IS NOT A REPAIR MECHANISM: This interface is for testing
+		purposes only and should not be used as a data repair tool.
+		Clearing poison is fundamentally different from data recovery
+		or error correction.
+
+What:		/sys/kernel/debug/cxl/regionX/inject_poison
+Date:		August, 2025
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a Host Physical Address (HPA) is written to this
+		attribute, the region driver translates it to a Device
+		Physical Address (DPA) and identifies the corresponding
+		memdev. It then sends an inject poison command to that memdev
+		at the translated DPA. Refer to the memdev ABI entry at:
+		/sys/kernel/debug/cxl/memX/inject_poison for the detailed
+		behavior. This attribute is only visible if all memdevs
+		participating in the region support both inject and clear
+		poison commands.
+
+		TEST-ONLY INTERFACE: This interface is intended for testing
+		and validation purposes only. It is not a data repair mechanism
+		and should never be used on production systems or live data.
+
+		DATA LOSS RISK: For CXL persistent memory (PMEM) devices,
+		poison injection can result in permanent data loss. Injected
+		poison may render data permanently inaccessible even after
+		clearing, as the clear operation writes zeros and does not
+		recover original data.
+
+		SYSTEM STABILITY RISK: For volatile memory, poison injection
+		can cause kernel crashes, system instability, or unpredictable
+		behavior if the poisoned addresses are accessed by running code
+		or critical kernel structures.
+
+What:		/sys/kernel/debug/cxl/regionX/clear_poison
+Date:		August, 2025
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a Host Physical Address (HPA) is written to this
+		attribute, the region driver translates it to a Device
+		Physical Address (DPA) and identifies the corresponding
+		memdev. It then sends a clear poison command to that memdev
+		at the translated DPA. Refer to the memdev ABI entry at:
+		/sys/kernel/debug/cxl/memX/clear_poison for the detailed
+		behavior. This attribute is only visible if all memdevs
+		participating in the region support both inject and clear
+		poison commands.
+
+		TEST-ONLY INTERFACE: This interface is intended for testing
+		and validation purposes only. It is not a data repair mechanism
+		and should never be used on production systems or live data.
+
+		CLEAR IS NOT DATA RECOVERY: This operation writes zeros to the
+		specified address range and removes the address from the poison
+		list. It does NOT recover or restore original data that may have
+		been present before poison injection. Any original data at the
+		cleared address is permanently lost and replaced with zeros.
+
+		CLEAR IS NOT A REPAIR MECHANISM: This interface is for testing
+		purposes only and should not be used as a data repair tool.
+		Clearing poison is fundamentally different from data recovery
+		or error correction.
+
 What:		/sys/kernel/debug/cxl/einj_types
 Date:		January, 2024
 KernelVersion:	v6.9
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2669f251d677..eac8cc1bdaa0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -135,6 +135,10 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_CLEAR,
 };
 
+enum poison_cmd_enabled_bits;
+bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
+			       enum poison_cmd_enabled_bits cmd);
+
 long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 90d3390d9c7c..e370d733e440 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -200,6 +200,14 @@ static ssize_t security_erase_store(struct device *dev,
 static struct device_attribute dev_attr_security_erase =
 	__ATTR(erase, 0200, NULL, security_erase_store);
 
+bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
+			       enum poison_cmd_enabled_bits cmd)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return test_bit(cmd, mds->poison.enabled_cmds);
+}
+
 static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index da0759acb87e..281a31df686f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/memregion.h>
 #include <linux/genalloc.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/memory.h>
@@ -3003,9 +3004,8 @@ struct dpa_result {
 	u64 dpa;
 };
 
-static int __maybe_unused region_offset_to_dpa_result(struct cxl_region *cxlr,
-						      u64 offset,
-						      struct dpa_result *result)
+static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
+				       struct dpa_result *result)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
@@ -3648,6 +3648,105 @@ static void shutdown_notifiers(void *_cxlr)
 	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
 }
 
+static void remove_debugfs(void *dentry)
+{
+	debugfs_remove_recursive(dentry);
+}
+
+static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	resource_size_t region_size;
+	u64 hpa;
+
+	if (offset < p->cache_size) {
+		dev_err(&cxlr->dev,
+			"Offset %#llx is within extended linear cache %#llx\n",
+			offset, p->cache_size);
+		return -EINVAL;
+	}
+
+	region_size = resource_size(p->res);
+	if (offset >= region_size) {
+		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %#llx\n",
+			offset, region_size);
+		return -EINVAL;
+	}
+
+	hpa = p->res->start + offset;
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_err(&cxlr->dev, "HPA %#llx not in region %pr\n", hpa,
+			p->res);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
+{
+	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
+	struct cxl_region *cxlr = data;
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return rc;
+
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return rc;
+
+	if (validate_region_offset(cxlr, offset))
+		return -EINVAL;
+
+	rc = region_offset_to_dpa_result(cxlr, offset, &result);
+	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
+		dev_dbg(&cxlr->dev,
+			"Failed to resolve DPA for region offset %#llx rc %d\n",
+			offset, rc);
+
+		return rc ? rc : -EINVAL;
+	}
+
+	return cxl_inject_poison_locked(result.cxlmd, result.dpa);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
+			 cxl_region_debugfs_poison_inject, "%llx\n");
+
+static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
+{
+	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
+	struct cxl_region *cxlr = data;
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return rc;
+
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return rc;
+
+	if (validate_region_offset(cxlr, offset))
+		return -EINVAL;
+
+	rc = region_offset_to_dpa_result(cxlr, offset, &result);
+	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
+		dev_dbg(&cxlr->dev,
+			"Failed to resolve DPA for region offset %#llx rc %d\n",
+			offset, rc);
+
+		return rc ? rc : -EINVAL;
+	}
+
+	return cxl_clear_poison_locked(result.cxlmd, result.dpa);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
+			 cxl_region_debugfs_poison_clear, "%llx\n");
+
 static int cxl_region_can_probe(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
@@ -3677,6 +3776,7 @@ static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
+	bool poison_supported = true;
 	int rc;
 
 	rc = cxl_region_can_probe(cxlr);
@@ -3700,6 +3800,31 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	/* Create poison attributes if all memdevs support the capabilities */
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		if (!cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_INJECT) ||
+		    !cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_CLEAR)) {
+			poison_supported = false;
+			break;
+		}
+	}
+
+	if (poison_supported) {
+		struct dentry *dentry;
+
+		dentry = cxl_debugfs_create_dir(dev_name(dev));
+		debugfs_create_file("inject_poison", 0200, dentry, cxlr,
+				    &cxl_poison_inject_fops);
+		debugfs_create_file("clear_poison", 0200, dentry, cxlr,
+				    &cxl_poison_clear_fops);
+		rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
+		if (rc)
+			return rc;
+	}
+
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
 		rc = devm_cxl_region_edac_register(cxlr);
-- 
2.37.3

