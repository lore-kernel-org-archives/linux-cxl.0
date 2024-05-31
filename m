Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD00256D;
	Fri, 31 May 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123759; cv=none; b=uVIr0cl0Q8SMJJc5AhF19j9hUMZeWjyQe72NPjE2UIWaoOswZufFL2xTEvZz91kEQHCqHTfd771q26OCFghw7oMKd8iy8jbeJNW8EiNOChnBIWhr3cVX0mBE1tJfguKkeWx3K7inz8M6Zy3+l/sBepn0Ef+/HSs8rnql4KAMQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123759; c=relaxed/simple;
	bh=yJZvW2qrzhlTHgN4Czd0hgGPxDlbm44gS6ttGvjiGKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aCuGkKajFznyAIEzyfGGVPws4jpoJGaYRw3kw8h1xd4RTnv8OxAg5KTe10gtqB0UIWwuP+T+qqkSvcN/rVHJLUECq3ot8MKgjwyHUMJP0dH9ShuKCuI4xxLVCaetYG49eHbWInn5//Ogm2kFOnlYjBUzGScOpcj8Th9VvvWNzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/ehFgOT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/ehFgOT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717123758; x=1748659758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yJZvW2qrzhlTHgN4Czd0hgGPxDlbm44gS6ttGvjiGKk=;
  b=S/ehFgOTsyItp43SDYS+E6bszcsz9EO5Qty/xM1vzFGeeSoU7loY59Pe
   2MgaBVJaNTCE76eb5fiDkOuNyv5Cvu0Es69Cvz7aTmCuB2i3hBXqOrwH0
   SaeXMbciLZhTWdGgniNfn6w0VaT3w4Y7rB/+dk9yx2qhuuY41uUicHyQB
   W3Czn6JsTCybwN9nn5R04GsCzeXANBmrtMYwhJH2z2JM/Wc+H2oLWKkf0
   wOADV4hxqnrNWOFvhBzAsTm9s4rKHIzw7U6HbzBbMkiRw/+uqFFRyG/nN
   +LnWWaXVO+alHLTszp1rXU26hsGjOQ1kVxgUblPtYDS+KTIq81oPdQorM
   g==;
X-CSE-ConnectionGUID: OnfA+sk/Q26nP7JAv9UObA==
X-CSE-MsgGUID: KLhSyHQKQW+OlPoyXGrnmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17482896"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="17482896"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 19:49:17 -0700
X-CSE-ConnectionGUID: PVooy1kcTReRDNmd4m/v9w==
X-CSE-MsgGUID: FeZz8sAaTrq98CUvqOpLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40585981"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.30.35])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 19:49:14 -0700
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
Subject: [PATCH] cxl/region: Support to calculate memory tier abstract distance
Date: Fri, 31 May 2024 10:48:52 +0800
Message-Id: <20240531024852.282767-1-ying.huang@intel.com>
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
 drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 00a9f0eef8dd..1f8f71a034ae 100644
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
+	int region_nid;
+	struct access_coordinate *perf;
+	int *adist = data;
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
@@ -2380,6 +2408,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
index 603c0120cff8..6891f87f8ef7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -534,6 +534,7 @@ struct cxl_region {
 	struct cxl_region_params params;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct notifier_block memory_notifier;
+	struct notifier_block adist_notifier;
 };
 
 struct cxl_nvdimm_bridge {
-- 
2.39.2

