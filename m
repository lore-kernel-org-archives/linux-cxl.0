Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C22D606
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EilHPM7t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704412117; x=1735948117;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6xaO1GGEthfMuhwJc7WawlCklJrGXxRIzWxhWnGvII=;
  b=EilHPM7tbdGNUpLX2Z1EHN7NDrVeGQbmyo7wbjEHu6kfPwqhofEGVHG/
   OL3duK1chzGWPrk3eOL+xXKggVi282xc9JzFfciQg0r47MC/MPk1wfC8L
   dCZkg3ZVMBSGT+6Yt85MNT1bJw97zkv4yvCJ9+VvW7I3gAlPF9dGfk9Lf
   rpvVKH+T+g7YCdIgXUTqfHX7c5I+TXwI6nB9Ul6QQ6o3vFJEq19JLTqEu
   KA1of0yW6qbuM+TvsvlkYOmVhywoyjiQGCFyrKF/Grg6ABPZ64ymX79//
   W3ihi38qtq1BrTZ8k8M4pZu3je4gxlKUCjzEftwQjRsqbhNVuBdTOv/3Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382369915"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="382369915"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="871087869"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="871087869"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:48:35 -0800
Subject: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Huang,
 Ying" <ying.huang@intel.com>, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 04 Jan 2024 16:48:34 -0700
Message-ID: <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
In-Reply-To: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
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
Additional regions may overwrite the initial data, but since this is
for the same proximity domain it's a don't care for now.

node_set_perf_attrs() symbol is exported to allow update of perf attribs
for a node. The sysfs path of
/sys/devices/system/node/nodeX/access0/initiators/* is created by
ndoe_set_perf_attrs() for the various attributes where nodeX is matched
to the proximity domain of the CXL region.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
- use read_bandwidth as check for valid coords (Jonathan)
- Remove setting of coord access level 1. (Jonathan)
---
 drivers/base/node.c       |    1 +
 drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |    3 +++
 3 files changed, 46 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index cb2b6cc7f6e6..48e5cb292765 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(node_set_perf_attrs);
 
 /**
  * struct node_cache_info - Internal tracking for memory node caches
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d28d24524d41..bee65f535d6c 100644
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
@@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
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
@@ -2997,6 +3034,11 @@ static int cxl_region_probe(struct device *dev)
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


