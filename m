Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3D8488;
	Tue, 11 Jun 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718085335; cv=none; b=KllMSjYUVR+6y+2HzYZt/NnTbOTywz/N+sBvivU3Ptc+ZX+alK0DNEUPts4o3X42FFIxrERW3XOiShkGoMX2YBDvhysaGzk/T71A8eAuHbj/UoWogVP6VFVsP5zzjUNWw4qVLiEQzfIyMeHrwd4ueOK9x3S449TUdkpBD/pW+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718085335; c=relaxed/simple;
	bh=5WJnw+QfBbs5yTDUK9w0ojlydX7oAy7NLby1XCx60AA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJO67qKDnin0UVOKVCj9VctFM0zuAXVCkuqQGaT8V/XZnUY+/S9JWkcpoVmpRknXc0sgshBcfVfFX6ayk2FHky2A2DQlGYHQoV0HJvdbJGDzQpr6WMo4PxPYCxtnJQvtH8XQXBoyNFIhItmAEHVWfVMtGJexZNY/PRDeMiYAbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4QR4x33; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4QR4x33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718085333; x=1749621333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5WJnw+QfBbs5yTDUK9w0ojlydX7oAy7NLby1XCx60AA=;
  b=j4QR4x33nw/Ri4xm7fvJ3V5TvJpaJjYgTDR+p9UwwHSl/XZ3DoQSUFPT
   2kVzIgesmBxBsCSne/T2Bdo2o5IQlycwPV9rto5fTz8asJR6PGNe3sXuS
   fj+YJCVEiPmNh8Zc53m4IEGrZ63J+3Rt2IX5dcEC+Nv7B1w0s+LMDrQwO
   5NVZLKMlj4EL6mdH92qfhYPCvP56Um8EZ7Y9B9bir9dk7jI3m5CscogXe
   BbvznJaK+3eFzDIdeVFF5haQScq74Hs2vvBz9haLNNRkERfnAyAIG+Sy1
   gApF3+MS9BRDCglrYUYJK1LOIvIPl3Kdcqza7JO1x8HNKhu48w0QCXaoe
   A==;
X-CSE-ConnectionGUID: NTtFCz96RUiU7Xaxk3xH/Q==
X-CSE-MsgGUID: EGlKfzhwQ3GuJv0mHgb71w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14944085"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14944085"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:55:32 -0700
X-CSE-ConnectionGUID: PFSKzgwrRLKjLkzj9UHfKA==
X-CSE-MsgGUID: duvF6b9uS/yuTdY4v6qUEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="70109088"
Received: from xianju6x-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:55:30 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH -V2] cxl/region: Support to calculate memory tier abstract distance
Date: Tue, 11 Jun 2024 13:54:23 +0800
Message-Id: <20240611055423.470574-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To place memory nodes backed by CXL regions in the appropriate memory
tiers.  So that, pages can be promoted/demoted with the existing
memory tiering mechanism.

The abstract distance is calculated based on the memory access latency
and bandwidth of CXL regions.  Which in turn comes from the HMAT
and CDAT, etc.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
Changes:

v2:

- Added comments to struct cxl_region and minor fixes (Thanks Jonathan!)
- Link to v1: https://lore.kernel.org/linux-cxl/20240531024852.282767-1-ying.huang@intel.com/

---
 drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3c2b6144be23..81d0910c0a02 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -9,6 +9,7 @@
 #include <linux/uuid.h>
 #include <linux/sort.h>
 #include <linux/idr.h>
+#include <linux/memory-tiers.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
@@ -2304,14 +2305,20 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 	return true;
 }
 
+static int cxl_region_nid(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled = p->targets[0];
+	struct cxl_decoder *cxld = &cxled->cxld;
+
+	return phys_to_target_node(cxld->hpa_range.start);
+}
+
 static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 					  unsigned long action, void *arg)
 {
 	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
 					       memory_notifier);
-	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_endpoint_decoder *cxled = p->targets[0];
-	struct cxl_decoder *cxld = &cxled->cxld;
 	struct memory_notify *mnb = arg;
 	int nid = mnb->status_change_nid;
 	int region_nid;
@@ -2319,7 +2326,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
 		return NOTIFY_DONE;
 
-	region_nid = phys_to_target_node(cxld->hpa_range.start);
+	region_nid = cxl_region_nid(cxlr);
 	if (nid != region_nid)
 		return NOTIFY_DONE;
 
@@ -2329,6 +2336,27 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int cxl_region_calculate_adistance(struct notifier_block *nb,
+					  unsigned long nid, void *data)
+{
+	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
+					       adist_notifier);
+	struct access_coordinate *perf;
+	int *adist = data;
+	int region_nid;
+
+	region_nid = cxl_region_nid(cxlr);
+	if (nid != region_nid)
+		return NOTIFY_OK;
+
+	perf = &cxlr->coord[ACCESS_COORDINATE_CPU];
+
+	if (mt_perf_to_adistance(perf, adist))
+		return NOTIFY_OK;
+
+	return NOTIFY_STOP;
+}
+
 /**
  * devm_cxl_add_region - Adds a region to a decoder
  * @cxlrd: root decoder
@@ -2371,6 +2399,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
 	register_memory_notifier(&cxlr->memory_notifier);
 
+	cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
+	cxlr->adist_notifier.priority = 100;
+	register_mt_adistance_algorithm(&cxlr->adist_notifier);
+
 	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
 	if (rc)
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 603c0120cff8..f46252373159 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -522,6 +522,7 @@ struct cxl_region_params {
  * @params: active + config params for the region
  * @coord: QoS access coordinates for the region
  * @memory_notifier: notifier for setting the access coordinates to node
+ * @adist_notifier: notifier for calculating the abstract distance of node
  */
 struct cxl_region {
 	struct device dev;
@@ -534,6 +535,7 @@ struct cxl_region {
 	struct cxl_region_params params;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block memory_notifier;
+	struct notifier_block adist_notifier;
 };
 
 struct cxl_nvdimm_bridge {
-- 
2.39.2

