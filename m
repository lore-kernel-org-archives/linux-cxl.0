Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44E77F03
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4PbXwfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196252; x=1734732252;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nu1wogwfHUIF97AThQpUwSJoSX2VWn48GLonQDmvuGE=;
  b=S4PbXwfymLXQAeZqL+7mjy0pqV2AjUVNkLBJ+cS/vcXQlgWU1cDoJzMZ
   wiBIf+7lcsJDqkktqXJ7goA4KKpn9TnLKCqpQhTioqCU9MsoelSloDHGr
   HwnFAy2Ae0lt6SmQSjjy8cdFdo/UNQ6Lm1KiX/uYyuDZF++B6lEbUHVyu
   4Bv4/rijz1j9w6PJKGtcm9gDA7a2T3rAulyHRdEPLNw5NgyDk4p1/d/+m
   De4o0LlzQ9UCnwayXvfqtmJgsrK7msCb56JJz5NxYMrYcsvkc98lFUEG+
   4aQgrWWEV6SMKLShYUr7VwM072nmWRYYWrbqQzv0nYtsOAk5p0GdL7PE9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="398831632"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="398831632"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:04:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895242847"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="895242847"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:04:11 -0800
Subject: [PATCH v15 17/19] cxl: Store QTG IDs and related info to the CXL
 memory device context
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:04:11 -0700
Message-ID: <170319625109.2212653.11872111896220384056.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
the return package. Create a list of entries in the cxl_memdev context and
store the QTG ID as qos_class token and the associated DPA range. This
information can be exposed to user space via sysfs in order to help region
setup for hot-plugged CXL memory devices.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v15:
- Fix comment header for cxl_memdev_state
---
 drivers/cxl/core/cdat.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mbox.c |    2 +
 drivers/cxl/cxlmem.h    |   21 +++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 43dfef80fb84..8c561f1deec6 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -6,6 +6,7 @@
 #include <linux/node.h>
 #include <linux/overflow.h>
 #include "cxlpci.h"
+#include "cxlmem.h"
 #include "cxl.h"
 
 struct dsmas_entry {
@@ -206,6 +207,69 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	return 0;
 }
 
+static void add_perf_entry(struct device *dev, struct dsmas_entry *dent,
+			   struct list_head *list)
+{
+	struct cxl_dpa_perf *dpa_perf;
+
+	dpa_perf = kzalloc(sizeof(*dpa_perf), GFP_KERNEL);
+	if (!dpa_perf) {
+		dev_dbg(dev, "failed to add entry for dsmas dpa: %#llx\n",
+			dent->dpa_range.start);
+		return;
+	}
+
+	dpa_perf->dpa_range = dent->dpa_range;
+	dpa_perf->coord = dent->coord;
+	dpa_perf->qos_class = dent->qos_class;
+	list_add_tail(&dpa_perf->list, list);
+}
+
+static void free_perf_ents(void *data)
+{
+	struct cxl_memdev_state *mds = data;
+	struct cxl_dpa_perf *dpa_perf, *n;
+	LIST_HEAD(discard);
+
+	list_splice_tail_init(&mds->ram_perf_list, &discard);
+	list_splice_tail_init(&mds->pmem_perf_list, &discard);
+	list_for_each_entry_safe(dpa_perf, n, &discard, list) {
+		list_del(&dpa_perf->list);
+		kfree(dpa_perf);
+	}
+}
+
+static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
+				     struct xarray *dsmas_xa)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct device *dev = cxlds->dev;
+	struct range pmem_range = {
+		.start = cxlds->pmem_res.start,
+		.end = cxlds->pmem_res.end,
+	};
+	struct range ram_range = {
+		.start = cxlds->ram_res.start,
+		.end = cxlds->ram_res.end,
+	};
+	struct dsmas_entry *dent;
+	unsigned long index;
+
+	xa_for_each(dsmas_xa, index, dent) {
+		if (resource_size(&cxlds->ram_res) &&
+		    range_contains(&ram_range, &dent->dpa_range))
+			add_perf_entry(dev, dent, &mds->ram_perf_list);
+		else if (resource_size(&cxlds->pmem_res) &&
+			 range_contains(&pmem_range, &dent->dpa_range))
+			add_perf_entry(dev, dent, &mds->pmem_perf_list);
+		else
+			dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
+				dent->dpa_range.start);
+	}
+
+	devm_add_action_or_reset(&cxlds->cxlmd->dev, free_perf_ents, mds);
+}
+
 static void discard_dsmas(struct xarray *xa)
 {
 	unsigned long index;
@@ -221,6 +285,8 @@ DEFINE_FREE(dsmas, struct xarray *, if (_T) discard_dsmas(_T))
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct xarray __dsmas_xa;
 	struct xarray *dsmas_xa __free(dsmas) = &__dsmas_xa;
 	int rc;
@@ -241,6 +307,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 		return;
 	}
 
+	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 36270dcfb42e..fbaa508ab245 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1404,6 +1404,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.reg_map.host = dev;
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
+	INIT_LIST_HEAD(&mds->ram_perf_list);
+	INIT_LIST_HEAD(&mds->pmem_perf_list);
 
 	return mds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2fcbca253f3..205bc2a016b2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,6 +6,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
+#include <linux/node.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -391,6 +392,20 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
+/**
+ * struct cxl_dpa_perf - DPA performance property entry
+ * @list - list entry
+ * @dpa_range - range for DPA address
+ * @coord - QoS performance data (i.e. latency, bandwidth)
+ * @qos_class - QoS Class cookies
+ */
+struct cxl_dpa_perf {
+	struct list_head list;
+	struct range dpa_range;
+	struct access_coordinate coord;
+	int qos_class;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -455,6 +470,8 @@ struct cxl_dev_state {
  * @security: security driver state info
  * @fw: firmware upload / activation state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @ram_perf_list: performance data entries matched to RAM
+ * @pmem_perf_list: performance data entries matched to PMEM
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -475,6 +492,10 @@ struct cxl_memdev_state {
 	u64 active_persistent_bytes;
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
+
+	struct list_head ram_perf_list;
+	struct list_head pmem_perf_list;
+
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;


