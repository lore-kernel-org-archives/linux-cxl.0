Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zp+7csL0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E12F1712
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 15:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701991924; x=1733527924;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHCKPZEi8y/1+jm5CaPw2uB0tv+0sUGm80nfXA2gUCw=;
  b=Zp+7csL0HhiW4SzCnhr2LLuJYWuTKMgYUy1gOnzneEab6ZSIKYLd2u/L
   oWqSwbIT5vlBtHo1pjee2RMsWfEFud/mWZjUA5YfMwSjb55MpbosEoeiy
   rwa63xWpEJgkoKRgTGT3w25zY3c0dwvyqE362OEeCLemKFUChHftBMkbz
   JwGIMVazgEHcqh1KoVKOOC5M3zqdI3zZGM8CrrhYXzgEPWmGStbCfiRg7
   tofNn9p1ztLnztODdXyMu+4xBOrcDfwa/cL5Wd8dDUg3r+kSAkeySgrKN
   zPl2CtoL55rBWQRcT/E61lBcYNH5sIr9lmtb4vBEivTf5/BBfPM76hbxp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1432001"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1432001"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895326361"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="895326361"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:32:03 -0800
Subject: [PATCH 3/3] cxl: Add memory hotplug notifier for cxl region
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 16:32:02 -0700
Message-ID: <170199192262.3543815.6979022920061286874.stgit@djiang5-mobl3>
In-Reply-To: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
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
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/base/node.c       |    1 +
 drivers/cxl/core/region.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |    2 ++
 3 files changed, 47 insertions(+)

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
index 72c47f624d63..3794e91e12b1 100644
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
@@ -2958,6 +2959,37 @@ static int is_system_ram(struct resource *res, void *arg)
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
+	struct access_coordinate coord;
+	int region_nid;
+
+	if (nid == NUMA_NO_NODE || action != MEM_ONLINE || !cxlr->coord)
+		return NOTIFY_STOP;
+
+	region_nid = phys_to_target_node(cxld->hpa_range.start);
+	if (nid != region_nid)
+		return NOTIFY_STOP;
+
+	/* Adjust latencies from psec to nsec to be consistent with HMAT targets */
+	coord = *cxlr->coord;
+	coord.read_latency = DIV_ROUND_UP(coord.read_latency, 1000);
+	coord.write_latency = DIV_ROUND_UP(coord.write_latency, 1000);
+
+	node_set_perf_attrs(nid, &coord, 0);
+	node_set_perf_attrs(nid, &coord, 1);
+
+	return NOTIFY_STOP;
+}
+
 static int cxl_region_perf_data_calculate(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
@@ -3077,6 +3109,10 @@ static int cxl_region_probe(struct device *dev)
 
 	cxl_region_perf_data_calculate(cxlr);
 
+	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
+	cxlr->memory_notifier.priority = HMAT_CALLBACK_PRI;
+	register_memory_notifier(&cxlr->memory_notifier);
+
 	/*
 	 * From this point on any path that changes the region's state away from
 	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
@@ -3108,9 +3144,17 @@ static int cxl_region_probe(struct device *dev)
 	}
 }
 
+static void cxl_region_remove(struct device *dev)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	unregister_memory_notifier(&cxlr->memory_notifier);
+}
+
 static struct cxl_driver cxl_region_driver = {
 	.name = "cxl_region",
 	.probe = cxl_region_probe,
+	.remove = cxl_region_remove,
 	.id = CXL_DEVICE_REGION,
 };
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 265da412c5bd..c326ee8956ec 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -6,6 +6,7 @@
 
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
+#include <linux/notifier.h>
 #include <linux/bitops.h>
 #include <linux/node.h>
 #include <linux/log2.h>
@@ -530,6 +531,7 @@ struct cxl_region {
 	unsigned long flags;
 	struct cxl_region_params params;
 	struct access_coordinate *coord;
+	struct notifier_block memory_notifier;
 };
 
 struct cxl_nvdimm_bridge {


