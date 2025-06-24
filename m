Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB983594B
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726427; cv=none; b=QoDH/VZhxaciVKjg+EIU0Lv1xFXcHXw0QKkrG2PX2zPf5eGBS2lovlBVcQtLCoqMDfFXijyo+SReWa80IzBXvIWqD0xqIh86CzHsIFsbV4QgQlSZUyk57BKpgHKp+cnOpEc1sdAGNLLYtSoukdl41l0XQlg2V0KEMfmyFQJ6eIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726427; c=relaxed/simple;
	bh=xI5+jMDjodJg1jiA0qJct4MoSUOELQUNUrOFBiUAnd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFf0Jq6xHx/HmbZTi+TLbiS0qIi8NLTDBNTDMpqzMQnG94DyeEdPJ4YD8yPxgbuqjFG8dCYJnD8etUjvAq34LmdC6rrBA70D7Gks/tw5nKouOs2MGZTvwpeISTjuidlfkgimIo+gcgUUX6IRIQIrX7wvBpxkATayO5+Z/+eShqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W//LpnaY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W//LpnaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750726426; x=1782262426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xI5+jMDjodJg1jiA0qJct4MoSUOELQUNUrOFBiUAnd4=;
  b=W//LpnaY4oxPuqSreWfMiTb4tKaEGS/O8Hdz74KdUlmzmeXIfspAczaP
   UdUaNcVtXnOsPTWhnLCTCuex9AzhXDn7TyKhM3sn3eQDm9x2QmFSyJ15z
   fd5XBoLezzHCE9693OzAjVmi8gKwokP5YzztmKNOVBs9ErjxWCfQ3SWao
   d9hX7j3blYQjFYfGfXg3JxiEbIoicJx9TYvCnfv6t0zr/MMPuIfU0tCUG
   8qWZXftiK3NTtzry2avmy3RSe067QBDazCqAcs+OWCBq8IvRFTyItrAJD
   DG83bm4MO1kmU2p/9mmCKKrrxSm9yqwFgFVL7smOzGvTur8GSLfOilShX
   Q==;
X-CSE-ConnectionGUID: iIzBhkZrQ522WVohDCxoyg==
X-CSE-MsgGUID: LeMEjnVNRTepBCmkqtvSMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56728819"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="56728819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:53:46 -0700
X-CSE-ConnectionGUID: ePmuSELLQ9yBU+az+xzJhg==
X-CSE-MsgGUID: JX2iRGLnRYKAE42c5c3dZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="156129162"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:53:44 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 3/3] cxl/region: Add inject and clear poison by HPA
Date: Mon, 23 Jun 2025 17:53:36 -0700
Message-ID: <50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1750725512.git.alison.schofield@intel.com>
References: <cover.1750725512.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Add CXL region debugfs attributes to inject and clear poison based
on Host Physical Addresses (HPA). These new interfaces allow users
to operate on poison at the region level without needing to resolve
Device Physical Addresses (DPA) or target individual memdevs.

The implementation leverages an internal HPA-to-DPA helper, which
applies decoder interleave logic, including XOR-based address decoding
when applicable. Note that XOR decodes rely on driver internal xormaps
which are not exposed to userspace. So, this support is not only a
simplification of poison operations that could be done using existing
per memdev operations, but also it enables the functionality for XOR
interleaved regions for the first time.

The new debugfs attributes are added under /sys/kernel/debug/regionX/:
inject_poison and clear_poison. These are only exposed if all memdevs
participating in the region support both inject and clear commands,
ensuring consistent and reliable behavior across multi-device regions.

If tracing is enabled, these operations are logged as cxl_poison
events in /sys/kernel/tracing/trace.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/debugfs-cxl |  33 +++++++
 drivers/cxl/core/core.h               |   4 +
 drivers/cxl/core/memdev.c             |  11 +++
 drivers/cxl/core/region.c             | 120 +++++++++++++++++++++++++-
 4 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index 12488c14be64..c784885cdf07 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -35,6 +35,39 @@ Description:
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
 
+
+What:		/sys/kernel/debug/regionX/inject_poison
+Date:		August, 2025
+KernelVersion:	v6.17
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
+
+What:		/sys/kernel/debug/regionX/clear_poison
+Date:		August, 2025
+KernelVersion:	v6.17
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
+
 What:		/sys/kernel/debug/cxl/einj_types
 Date:		January, 2024
 KernelVersion:	v6.9
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..66ca5f899fd6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -109,6 +109,10 @@ enum cxl_poison_trace_type {
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
index b38141761f47..7616e68fa79e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -200,6 +200,17 @@ static ssize_t security_erase_store(struct device *dev,
 static struct device_attribute dev_attr_security_erase =
 	__ATTR(erase, 0200, NULL, security_erase_store);
 
+bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
+			       enum poison_cmd_enabled_bits cmd)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (test_bit(cmd, mds->poison.enabled_cmds))
+		return true;
+
+	return false;
+}
+
 static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d2d904c4b427..e9ed5ac7309e 100644
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
@@ -3004,8 +3005,7 @@ static struct hpa_decode_result decode_hpa_to_dpa(u64 hpa_offset, u8 eiw,
 	return result;
 }
 
-static struct cxl_dpa_result __maybe_unused
-cxl_hpa_to_dpa(struct cxl_region *cxlr, u64 hpa)
+static struct cxl_dpa_result cxl_hpa_to_dpa(struct cxl_region *cxlr, u64 hpa)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
@@ -3616,10 +3616,101 @@ static void shutdown_notifiers(void *_cxlr)
 	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
 }
 
+static void remove_debugfs(void *dentry)
+{
+	debugfs_remove_recursive(dentry);
+}
+
+static int cxl_region_debugfs_poison_inject(void *data, u64 hpa)
+{
+	struct cxl_region *cxlr = data;
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_dpa_result result;
+	int rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc) {
+		up_read(&cxl_region_rwsem);
+		return rc;
+	}
+
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_err_once(&cxlr->dev, "HPA 0x%llx not in region %pr\n", hpa,
+			     p->res);
+		rc = -EINVAL;
+		goto out;
+	}
+	result = cxl_hpa_to_dpa(cxlr, hpa);
+	if (!result.cxlmd || result.dpa == ULLONG_MAX) {
+		dev_err(&cxlr->dev, "Failed to resolve DPA from HPA 0x%llx\n",
+			hpa);
+
+		rc = -EINVAL;
+		goto out;
+	}
+	rc = __inject_poison_locked(result.cxlmd, result.dpa);
+
+out:
+	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
+			 cxl_region_debugfs_poison_inject, "%llx\n");
+
+static int cxl_region_debugfs_poison_clear(void *data, u64 hpa)
+{
+	struct cxl_region *cxlr = data;
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_dpa_result result;
+	int rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc) {
+		up_read(&cxl_region_rwsem);
+		return rc;
+	}
+
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_err_once(&cxlr->dev, "HPA 0x%llx not in region %pr\n", hpa,
+			     p->res);
+		rc = -EINVAL;
+		goto out;
+	}
+	result = cxl_hpa_to_dpa(cxlr, hpa);
+	if (!result.cxlmd || result.dpa == ULLONG_MAX) {
+		dev_err(&cxlr->dev, "Failed to resolve DPA from HPA 0x%llx\n",
+			hpa);
+
+		rc = -EINVAL;
+		goto out;
+	}
+	rc = __clear_poison_locked(result.cxlmd, result.dpa);
+out:
+	up_read(&cxl_dpa_rwsem);
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
+			 cxl_region_debugfs_poison_clear, "%llx\n");
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
+	bool poison_supported = true;
 	int rc;
 
 	rc = down_read_interruptible(&cxl_region_rwsem);
@@ -3663,6 +3754,31 @@ static int cxl_region_probe(struct device *dev)
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

