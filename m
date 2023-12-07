Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HV2Lko5B"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A532310EF
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 15:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701990012; x=1733526012;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UCLXLaihvbAMDPvZfDF9fJM9C9wXN4gxx3IDPc/Np/4=;
  b=HV2Lko5BO63E8u/bEtBm+Ewprj5UR0xH6s7pLnzFPBHD9+rECK/D0+eT
   aCqj+/l19BQhy8AuUSGEiu7J//ILWEG2u1yPGoPEeFTujJBZxbpEc4+ZG
   IXwHeQVu0EMbl3cXIbFQ5trxt2w9lPT5h/HlseMr3Wx8zSMYef5ir2vOf
   bmanOIAtVyGvlDmT1vPeHhIrqfu1nnUxCEnC0LLlBai3XQlfQJe2Sdca+
   +b9M975BdPuvkZwTKRsHMNQcfjIGC7RQ+1pQzTr2W7amNV6D7xHmbKw9d
   KVxMociah4eX1P68mhe5ghq9lGY659Gj9MINL1ml2LSX1irS3HWUu6vnr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397107827"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="397107827"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:00:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895313112"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="895313112"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:00:09 -0800
Subject: [PATCH v13 17/19] cxl: Store QTG IDs and related info to the CXL
 memory device context
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 16:00:07 -0700
Message-ID: <170199000744.3522351.15387313851314896921.stgit@djiang5-mobl3>
In-Reply-To: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
References: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
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
v13:
- convert to use dsmas_xa (Dan)
---
 drivers/cxl/core/mbox.c |    3 +++
 drivers/cxl/cxlmem.h    |   23 +++++++++++++++++++++
 drivers/cxl/port.c      |   51 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 72 insertions(+), 5 deletions(-)

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
index 1a059d48154f..2e22d0c1f494 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -106,6 +106,42 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	return 0;
 }
 
+static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
+				     struct xarray *dsmas_xa)
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
+	unsigned long index;
+
+	xa_for_each(dsmas_xa, index, dent) {
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
@@ -197,13 +233,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		rc = cxl_cdat_endpoint_process(port, &dsmas_xa);
 		if (rc < 0) {
 			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
-		} else {
-			rc = cxl_port_perf_data_calculate(port, &dsmas_xa);
-			if (rc)
-				dev_dbg(&port->dev,
-					"Failed to do perf coord calculations.\n");
+			goto out;
+		}
+
+		rc = cxl_port_perf_data_calculate(port, &dsmas_xa);
+		if (rc) {
+			dev_dbg(&port->dev,
+				"Failed to do perf coord calculations.\n");
+			goto out;
 		}
 
+		cxl_memdev_set_qos_class(cxlds, &dsmas_xa);
+out:
 		cxl_cdat_dsmas_xa_destroy(&dsmas_xa);
 	}
 


