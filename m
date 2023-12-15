Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2695913B124
	for <linux-cxl@vger.kernel.org>; Fri, 15 Dec 2023 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cz2fcoKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702682188; x=1734218188;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lhh6h6VpcnNzOx7mMq5yvLv3XcBlAd+IWi1ASlHnI7A=;
  b=Cz2fcoKvA16h+HfN7roGFQINknc5eecAw2tNaqWw8MOobxjxHywB/v/K
   0qdYmLYiZMnyDBMWfiL2+593vOMXzDKcoijzYHXRH6RwuuYo4ZnvBQpRN
   kpjd22Z0qLQlVCin7GPOHw+IKidXcOyjMqtE3CWhw2DYCYmIb2uU4z3To
   mM3KWNPVzVNM9wsGNwP4QXrcdfKpCQBMemY3YrHlqo5dRD+M41X3k+ine
   sWDRojkehYMz9hZo6mAOHbHCNZ9HVfpKOT21Xca+Qy5ZB/LiGRKJogUi6
   aLb7mRAt7LtATYR7Bf1CT5LEQQizdEZUfp+BAEnFqAvmsitTMULw+4zrp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2192036"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2192036"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:16:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="1022091049"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="1022091049"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.188.77])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:16:11 -0800
Subject: [PATCH v2 3/3] cxl: Add memory hotplug notifier for cxl region
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Huang,
 Ying" <ying.huang@intel.com>, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, brice.goglin@gmail.com,
 nifan.cxl@gmail.com
Date: Fri, 15 Dec 2023 16:16:11 -0700
Message-ID: <170268217159.1381493.10875292326564731198.stgit@djiang5-mobl3>
In-Reply-To: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
References: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

When the CXL region is formed, the driver would computed the performance
data for the region. However this data is not available at the node data
collection that has been populated by the HMAT during kernel
initialization. Add a memory hotplug notifier to update the performance
data to the node hmem_attrs to expose the newly calculated region
performance data. The CXL region is created under specific CFMWS. The
node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
The notifier will run once only and turn itself off after the initial
run. Additional regions may overwrite the initial data, but since this is
for the same poximity domain it's a don't care for now.

node_set_perf_attrs() is exported to allow update of perf attribs for a
node. Given that only CXL is using this, export only to CXL namespace.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Fix notifier return values (Dan)
- Use devm_add_action_or_reset() instead of adding a remove callback (Dan)
- Add Ying review tag
---
 drivers/base/node.c       |    1 +
 drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |    3 +++
 3 files changed, 46 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index cb2b6cc7f6e6..f5b5a3f11894 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 		}
 	}
 }
+EXPORT_SYMBOL_NS_GPL(node_set_perf_attrs, CXL);
 
 /**
  * struct node_cache_info - Internal tracking for memory node caches
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d97fa5f32e86..1765bf716484 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4,6 +4,7 @@
 #include <linux/genalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/memory.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
 #include <linux/sort.h>
@@ -2960,6 +2961,42 @@ static int is_system_ram(struct resource *res, void *arg)
 	return 1;
 }
 
+static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
+					  unsigned long action, void *arg)
+{
+	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
+					       memory_notifier);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled = p->targets[0];
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct memory_notify *mnb = arg;
+	int nid = mnb->status_change_nid;
+	int region_nid;
+
+	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+		return NOTIFY_DONE;
+
+	region_nid = phys_to_target_node(cxld->hpa_range.start);
+	if (nid != region_nid)
+		return NOTIFY_DONE;
+
+	/* Don't set if there's no coordinate information */
+	if (!cxlr->coord.write_bandwidth)
+		return NOTIFY_DONE;
+
+	node_set_perf_attrs(nid, &cxlr->coord, 0);
+	node_set_perf_attrs(nid, &cxlr->coord, 1);
+
+	return NOTIFY_OK;
+}
+
+static void remove_coord_notifier(void *data)
+{
+	struct cxl_region *cxlr = data;
+
+	unregister_memory_notifier(&cxlr->memory_notifier);
+}
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -2985,6 +3022,11 @@ static int cxl_region_probe(struct device *dev)
 		goto out;
 	}
 
+	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
+	cxlr->memory_notifier.priority = HMAT_CALLBACK_PRI;
+	register_memory_notifier(&cxlr->memory_notifier);
+	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, cxlr);
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4639d0d6ef54..2498086c8edc 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -6,6 +6,7 @@
 
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
+#include <linux/notifier.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/node.h>
@@ -520,6 +521,7 @@ struct cxl_region_params {
  * @flags: Region state flags
  * @params: active + config params for the region
  * @coord: QoS access coordinates for the region
+ * @memory_notifier: notifier for setting the access coordinates to node
  */
 struct cxl_region {
 	struct device dev;
@@ -531,6 +533,7 @@ struct cxl_region {
 	unsigned long flags;
 	struct cxl_region_params params;
 	struct access_coordinate coord;
+	struct notifier_block memory_notifier;
 };
 
 struct cxl_nvdimm_bridge {


