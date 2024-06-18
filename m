Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E81B3F35;
	Tue, 18 Jun 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700423; cv=none; b=IPks9JyZGFtHk7CJMehB0JwxoRN+mE28TkYf81Oc3kGZaBhMBW4LCQyWwMXcROYtqCM65vyDtUq7UM8HmHmPfiZ8LTEV7ROjhug9Mhzu2IyO7zkm9iwYC4sogUR1CxrNoYvuESjAzADo/RDbqTvuaG3i+tZSq9nsa/PMXsOYWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700423; c=relaxed/simple;
	bh=8EXyhcs1Eq8K5vB1Kf8SAGnjJsugyqsBbacd5PBZfB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXLKLGtF3l+LspyHLdGVHcGkORggfjlage7T0u309K1r3yXZwY6Ak8MqQDcE/jYRpSUiDpwybRHl5/dgPdVio7vOrcKPYyW6y6lXDx5sdwvm8nNl3S0hmbMDbHSRG0/tOjt8WW3uI9MDuq+oCHcsRzgw8/qbRX5TGEddUAUzg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hELUaf6w; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hELUaf6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718700422; x=1750236422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8EXyhcs1Eq8K5vB1Kf8SAGnjJsugyqsBbacd5PBZfB0=;
  b=hELUaf6wvoxR+qzNb5L0tmEF/6wys02CCCydsS9fqBcB0GBWwwz5rCPw
   FLBN5CoEBBvYclXa7MII6yH/BE5Sl+pM/tQQ+HFZnKby005rz7u2JgCui
   wjwNxvpQTbh/Ov699s2MILvIV1kYn5lQCCyZJ4B4DfvrzP6tXKG58VaYO
   AYFVt+OVNQekizbwsOMWrtmlT6yNIZ7zoaANb6ae1m1USN8KIGOmaS0RF
   6hL3h1Jz/5X3T+q8VZfBWSfHzl9EtvP7+10E3Ttf5CRXbty0A4qd8DRb/
   rfA/zbSAo5pcjTyH87/g9aV5x7mnCs9FXMQl5dnRWA3Y5mQYKu+UxxAvO
   A==;
X-CSE-ConnectionGUID: dgz1g0q8S0uMsDkNYp4b7Q==
X-CSE-MsgGUID: iamcR+iCS0CznPCx57i0Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15431613"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15431613"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:47:02 -0700
X-CSE-ConnectionGUID: Gp/1WNAaQHuyaMoTwLIalw==
X-CSE-MsgGUID: xDS04ZgLRruFXWzIg4mulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="78933646"
Received: from shilinmu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:46:58 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 2/3] cxl/region: Support to calculate memory tier abstract distance
Date: Tue, 18 Jun 2024 16:46:38 +0800
Message-Id: <20240618084639.1419629-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618084639.1419629-1-ying.huang@intel.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An abstract distance value must be assigned by the driver that makes
the memory available to the system. It reflects relative performance
and is used to place memory nodes backed by CXL regions in the appropriate
memory tiers allowing promotion/demotion within the existing memory tiering
mechanism.

The abstract distance is calculated based on the memory access latency
and bandwidth of CXL regions.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/region.c | 27 +++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 51aeef2c012c..dc15ceba7ab7 100644
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
@@ -2228,6 +2229,7 @@ static void unregister_region(void *_cxlr)
 	int i;
 
 	unregister_memory_notifier(&cxlr->memory_notifier);
+	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
 	device_del(&cxlr->dev);
 
 	/*
@@ -2340,6 +2342,27 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
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
@@ -2382,6 +2405,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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

