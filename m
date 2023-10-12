Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F6358B5
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apw8YUBV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05583C0
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136932; x=1728672932;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7MhPfyiIXMaWQR9Wmb8Dak0RR8zuyj/7tltszk38rpQ=;
  b=apw8YUBVxNrQ5vvEd1BTf4ZcRrOHz1KzG10CHsfphu1XUwNX/EV19Ugh
   PQgj1/JYjrCcjcYq8YcYmec32L/00PzFIKfgk0lSDhbGCkEC29u2Y1DK4
   EIJgaNo5lGfUEacC2tdzaeOqjlcdFbrkwoyKuwqmbZX337LbGKeSsF5P/
   GQ25v0Tp07ibIMR15YL90C+8kGyo/V7BLvKddDDcziiBQKTdYBPJz3uks
   JNwieYaRHxKjfQfb7RKL/a2v+CVdenqBxA7PENCgxZ2qmYFzTajA036VI
   DZrCnH3U0AMA3uKvUYPzd7R+yIxzzJnlbZwLUZy4HBZBC3YH3yh5A6a6r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3604289"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="3604289"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="824724642"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="824724642"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:55:30 -0700
Subject: [PATCH v11 20/22] cxl: Store QTG IDs and related info to the CXL
 memory device context
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:55:30 -0700
Message-ID: <169713693022.2205276.8814476945721343862.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
the return package. Create a list of entries in the cxl_memdev context and
store the QTG ID as qos_class token and the associated DPA range. This
information can be exposed to user space via sysfs in order to help region
setup for hot-plugged CXL memory devices.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v11:
- Detected multiple entries and emit such case. (Jonathan)
- Preserve first found entry if there are multiple entries.
- Refactor dsmas processing paths in switch port (Jonathan)
v10:
- Store single qos_class value. (Dan)
- Rename cxl_memdev_set_qtg() to cxl_memdev_set_qos_class()
- Removed Jonathan's review tag due to code changes.
---
 drivers/cxl/core/mbox.c |    1 +
 drivers/cxl/cxlmem.h    |   23 ++++++++++++++++++
 drivers/cxl/port.c      |   60 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4df4f614f490..6193b8d57469 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1378,6 +1378,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
+	INIT_LIST_HEAD(&mds->perf_list);
 
 	return mds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef4..a310a51a3fa4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,6 +6,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
+#include <linux/node.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -388,6 +389,20 @@ enum cxl_devtype {
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
@@ -452,6 +467,9 @@ struct cxl_dev_state {
  * @security: security driver state info
  * @fw: firmware upload / activation state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @ram_qos_class: QoS class cookies for volatile region
+ * @pmem_qos_class: QoS class cookies for persistent region
+ * @perf_list: performance data entries list
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -472,6 +490,11 @@ struct cxl_memdev_state {
 	u64 active_persistent_bytes;
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
+
+	int ram_qos_class;
+	int pmem_qos_class;
+	struct list_head perf_list;
+
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 99a619360bc5..7eb26cefe2cb 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -105,6 +105,49 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
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
+		list_add_tail(&perf->list, &mds->perf_list);
+
+		if (resource_size(&cxlds->ram_res) &&
+		    range_contains(&ram_range, &dent->dpa_range)) {
+			if (mds->ram_qos_class == CXL_QOS_CLASS_INVALID)
+				mds->ram_qos_class = perf->qos_class;
+			else
+				dev_dbg(cxlds->dev,
+					"Multiple DSMAS entries for ram region.\n");
+		} else if (resource_size(&cxlds->pmem_res) &&
+			 range_contains(&pmem_range, &dent->dpa_range)) {
+			if (mds->pmem_qos_class == CXL_QOS_CLASS_INVALID)
+				mds->pmem_qos_class = perf->qos_class;
+			else
+				dev_dbg(cxlds->dev,
+					"Multiple DSMAS entries for pmem region.\n");
+		}
+	}
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -196,17 +239,22 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		rc = cxl_cdat_endpoint_process(port, &dsmas_list);
 		if (rc < 0) {
 			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
-		} else {
-			rc = cxl_port_perf_data_calculate(port, &dsmas_list);
-			if (rc)
-				dev_dbg(&port->dev,
-					"Failed to do perf coord calculations.\n");
+			goto out;
 		}
 
+		rc = cxl_port_perf_data_calculate(port, &dsmas_list);
+		if (rc) {
+			dev_dbg(&port->dev,
+				"Failed to do perf coord calculations.\n");
+			goto out;
+		}
+
+		cxl_memdev_set_qos_class(cxlds, &dsmas_list);
+out:
 		cxl_cdat_dsmas_list_destroy(&dsmas_list);
 	}
 
-	return 0;
+	return rc;
 }
 
 static int cxl_port_probe(struct device *dev)


