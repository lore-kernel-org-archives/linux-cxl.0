Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DB26AD1
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5OA2fyE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344E2D2
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003148; x=1731539148;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oEDNXEfkZM0lcpbvsmZD6NlE4rSO8AY1yZm/cC73pqg=;
  b=e5OA2fyEcvXvS3EtANUI5xubJsue80jPTAokqA41cicHMuJJKVcxk8bN
   3ZoCt50W2OYFafOm+cBLJg4JmuEd7Eo9LL6hKPwVtzKScl1MWeWw07Ywi
   wPk4irD8IuDK6/xREHlmUBgGvaBPNmthaS6g7It/L7KHx3BWmUFV4IbCy
   sEdWf73DLxVxfkCrvpwjZjFmSTBdT2qeBfgebhEKzQva1PmpWIH11KgiA
   cQ1+8mto5FmKWd5e6IVgC2I0Mu9V5SPrHWCdTrmfn/uqQRrDGUr3BPByT
   ztcGgZYXYYp/rzUgUW+pHEf6U6hMLAEz4+nDFh54zvu9diKEGt+IoQyBv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12308543"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12308543"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12586013"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:46 -0800
Subject: [PATCH v12 16/18] cxl: Store QTG IDs and related info to the CXL
 memory device context
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:05:45 -0700
Message-ID: <170000314525.1974471.11087048767505392827.stgit@djiang5-mobl3>
In-Reply-To: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
References: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
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
v12:
- Have cxl_endpoint_port_probe() return 0 for perf data failures.
  (Gregory, Dan)
- Have the perf data put on individually matched lists (Dan)
---
 drivers/cxl/core/mbox.c |    3 +++
 drivers/cxl/cxlmem.h    |   23 ++++++++++++++++++++++
 drivers/cxl/port.c      |   50 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 36270dcfb42e..f4de0275f9dc 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1404,6 +1404,9 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.reg_map.host = dev;
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
+	INIT_LIST_HEAD(&mds->unmatched_perf_list);
+	INIT_LIST_HEAD(&mds->ram_perf_list);
+	INIT_LIST_HEAD(&mds->pmem_perf_list);
 
 	return mds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2fcbca253f3..975fe3b03564 100644
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
+ * struct perf_prop - performance property entry
+ * @list - list entry
+ * @dpa_range - range for DPA address
+ * @coord - QoS performance data (i.e. latency, bandwidth)
+ * @qos_class - QoS Class cookies
+ */
+struct perf_prop_entry {
+	struct list_head list;
+	struct range dpa_range;
+	struct access_coordinate coord;
+	int qos_class;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -455,6 +470,9 @@ struct cxl_dev_state {
  * @security: security driver state info
  * @fw: firmware upload / activation state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @ram_perf_list: performance data entries matched to RAM
+ * @pmem_qos_class: performance data entries matched to PMEM
+ * @unmatched_perf_list: unmatched performance data entries list
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -475,6 +493,11 @@ struct cxl_memdev_state {
 	u64 active_persistent_bytes;
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
+
+	struct list_head ram_perf_list;
+	struct list_head pmem_perf_list;
+	struct list_head unmatched_perf_list;
+
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 99a619360bc5..35929b3c52b0 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -105,6 +105,41 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	return 0;
 }
 
+static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
+				     struct list_head *dsmas_list)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct range pmem_range = {
+		.start = cxlds->pmem_res.start,
+		.end = cxlds->pmem_res.end,
+	};
+	struct range ram_range = {
+		.start = cxlds->ram_res.start,
+		.end = cxlds->ram_res.end,
+	};
+	struct perf_prop_entry *perf;
+	struct dsmas_entry *dent;
+
+	list_for_each_entry(dent, dsmas_list, list) {
+		perf = devm_kzalloc(cxlds->dev, sizeof(*perf), GFP_KERNEL);
+		if (!perf)
+			return;
+
+		perf->dpa_range = dent->dpa_range;
+		perf->coord = dent->coord;
+		perf->qos_class = dent->qos_class;
+
+		if (resource_size(&cxlds->ram_res) &&
+		    range_contains(&ram_range, &dent->dpa_range))
+			list_add_tail(&perf->list, &mds->ram_perf_list);
+		else if (resource_size(&cxlds->pmem_res) &&
+			 range_contains(&pmem_range, &dent->dpa_range))
+			list_add_tail(&perf->list, &mds->pmem_perf_list);
+		else
+			list_add_tail(&perf->list, &mds->unmatched_perf_list);
+	}
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -196,13 +231,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		rc = cxl_cdat_endpoint_process(port, &dsmas_list);
 		if (rc < 0) {
 			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
-		} else {
-			rc = cxl_port_perf_data_calculate(port, &dsmas_list);
-			if (rc)
-				dev_dbg(&port->dev,
-					"Failed to do perf coord calculations.\n");
+			goto out;
+		}
+
+		rc = cxl_port_perf_data_calculate(port, &dsmas_list);
+		if (rc) {
+			dev_dbg(&port->dev,
+				"Failed to do perf coord calculations.\n");
+			goto out;
 		}
 
+		cxl_memdev_set_qos_class(cxlds, &dsmas_list);
+out:
 		cxl_cdat_dsmas_list_destroy(&dsmas_list);
 	}
 


