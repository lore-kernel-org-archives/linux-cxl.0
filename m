Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEA1C37B2;
	Fri, 16 Aug 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817313; cv=none; b=Ea2cv5F9lcfd67jFUx7bZqlBG6eNfYnOafcwa4JbRF5Cnwtv+shxVc0gYUqOENMJF/GQaspxahMaI8F0/6+d5j9CgI1OFR45/G5Hs4Vp6yLNVNsBToIEbuRyvrkobGsMTIXmXRBzUofuEsEV9p1KBAYid0wvSc+u0jee+YpXCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817313; c=relaxed/simple;
	bh=SCE7K6VtxQclQDx39FbDnKWrpMjPz1vZO2RhDR+ocNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+nPoEVQx2QbFcnIbl60CPfCHOcOALyXYuSi75bTP611uMzOCWYTiUyJlq+tec/90N6MXPUzRclgK1oNxBemohKSVV1BxMEcRJDfVY9pC+mknfOrH0toknHUQ2NY9kgd6/vkoyv1hXpTHb874jbEQqfa70Hdiy/B71ghh/1Ot6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZQT2kgc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZQT2kgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817312; x=1755353312;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SCE7K6VtxQclQDx39FbDnKWrpMjPz1vZO2RhDR+ocNI=;
  b=IZQT2kgcWnkMXprFxmo6tBS8AqXk33y2nxZb5157SJl0NHpsSyn9IxoJ
   LG3DFIE8PVSrMMiEVwfXIgCWsh+Jxds1PV3Aj+o6p5taBfh3xbTEfbZCg
   JFiBXQRlLGjdArzcCJSSP/X8RwiTJYs/9u62e/FtGQJtSFl/IlOheQuVF
   RwiUBtgF2MI/6sHRbLNGpJld4QHwaVCjuMjJEXFdABU5lJIlWkwoCwtST
   FSvX1EWj7QEq9xPf8oLoH3cQeyYxSkW5YvI9w1QJz4HUTmDQViPb/zX+d
   T5UDhIUazjOyq/k0hbItOYUg7S6jVKJqEn5IvohaX8/I13EZ3YBtOjeap
   g==;
X-CSE-ConnectionGUID: CeoTJmuOT6WqiPdWz7Wmwg==
X-CSE-MsgGUID: Gx210f/hRACZcxq++27HNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22085246"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22085246"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:31 -0700
X-CSE-ConnectionGUID: e8Im7zRERpy4lOSW5gzzBw==
X-CSE-MsgGUID: lUP6nyTKR8qfY0b4mZCMBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64571565"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:30 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:14 -0500
Subject: [PATCH RESEND v2 09/18] cxl/mem: Read extents on memory device
 discovery
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-9-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=10377;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=SCE7K6VtxQclQDx39FbDnKWrpMjPz1vZO2RhDR+ocNI=;
 b=mD6yeW8R6WSQns8krxn2Q/VE5alWbrmT3hmvcVSLxRo9u0BHpxTMeTDhw8OmQPrj4c6mlQ3ys
 oE3zCM1MeilAqcLmCE+58jz3Mg+JUBw/leX3GdWfe9Kac8jO1zxFhta
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

When a Dynamic Capacity Device (DCD) is realized some extents may
already be available within the DC Regions.  This can happen if the host
has accepted extents and been rebooted or any other time the host driver
software has become out of sync with the device hardware.

Read the available extents during probe and store them for later
use.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Change for v2:
[iweiny: new patch]
---
 drivers/cxl/core/mbox.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  36 +++++++++
 drivers/cxl/pci.c       |   4 +
 3 files changed, 235 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d769814f80e2..9b08c40ef484 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -824,6 +824,37 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+static int cxl_store_dc_extent(struct cxl_memdev_state *mds,
+			       struct cxl_dc_extent *dc_extent)
+{
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_dc_extent_data *extent;
+	int rc;
+
+	extent = kzalloc(sizeof(*extent), GFP_KERNEL);
+	if (!extent)
+		return -ENOMEM;
+
+	extent->dpa_start = le64_to_cpu(dc_extent->start_dpa);
+	extent->length = le64_to_cpu(dc_extent->length);
+	memcpy(extent->tag, dc_extent->tag, sizeof(extent->tag));
+	extent->shared_extent_seq = le16_to_cpu(dc_extent->shared_extn_seq);
+
+	dev_dbg(dev, "dynamic capacity extent DPA:0x%llx LEN:%llx\n",
+		extent->dpa_start, extent->length);
+
+	rc = xa_insert(&mds->dc_extent_list, extent->dpa_start, extent,
+			 GFP_KERNEL);
+	if (rc) {
+		if (rc == -EBUSY)
+			dev_warn_once(dev, "Duplicate extent DPA:%llx LEN:%llx\n",
+				      extent->dpa_start, extent->length);
+		kfree(extent);
+	}
+
+	return rc;
+}
+
 /*
  * General Media Event Record
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
@@ -1339,6 +1370,149 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
 
+static int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
+				     unsigned int *extent_gen_num)
+{
+	struct cxl_mbox_get_dc_extent get_dc_extent;
+	struct cxl_mbox_dc_extents dc_extents;
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_mbox_cmd mbox_cmd;
+	unsigned int count;
+	int rc;
+
+	/* Check GET_DC_EXTENT_LIST is supported by device */
+	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
+		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
+		return 0;
+	}
+
+	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
+		.extent_cnt = cpu_to_le32(0),
+		.start_extent_index = cpu_to_le32(0),
+	};
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
+		.payload_in = &get_dc_extent,
+		.size_in = sizeof(get_dc_extent),
+		.size_out = mds->payload_size,
+		.payload_out = &dc_extents,
+		.min_out = 1,
+	};
+
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	count = le32_to_cpu(dc_extents.total_extent_cnt);
+	*extent_gen_num = le32_to_cpu(dc_extents.extent_list_num);
+
+	return count;
+}
+
+static int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds,
+				  unsigned int start_gen_num,
+				  unsigned int exp_cnt)
+{
+	struct cxl_mbox_dc_extents *dc_extents;
+	unsigned int start_index, total_read;
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_mbox_cmd mbox_cmd;
+	int retry = 3;
+	int rc;
+
+	/* Check GET_DC_EXTENT_LIST is supported by device */
+	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
+		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
+		return 0;
+	}
+
+	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
+	if (!dc_extents)
+		return -ENOMEM;
+
+reset:
+	total_read = 0;
+	start_index = 0;
+	do {
+		unsigned int nr_ext, total_extent_cnt, gen_num;
+		struct cxl_mbox_get_dc_extent get_dc_extent;
+
+		get_dc_extent = (struct cxl_mbox_get_dc_extent) {
+			.extent_cnt = exp_cnt - start_index,
+			.start_extent_index = start_index,
+		};
+		
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
+			.payload_in = &get_dc_extent,
+			.size_in = sizeof(get_dc_extent),
+			.size_out = mds->payload_size,
+			.payload_out = dc_extents,
+			.min_out = 1,
+		};
+		
+		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		if (rc < 0)
+			goto out;
+		
+		nr_ext = le32_to_cpu(dc_extents->ret_extent_cnt);
+		total_read += nr_ext;
+		total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
+		gen_num = le32_to_cpu(dc_extents->extent_list_num);
+
+		dev_dbg(dev, "Get extent list count:%d generation Num:%d\n",
+			total_extent_cnt, gen_num);
+
+		if (gen_num != start_gen_num || exp_cnt != total_extent_cnt) {
+			dev_err(dev, "Extent list changed while reading; %u != %u : %u != %u\n",
+				gen_num, start_gen_num, exp_cnt, total_extent_cnt);
+			if (retry--)
+				goto reset;
+			return -EIO;
+		}
+		
+		for (int i = 0; i < nr_ext ; i++) {
+			dev_dbg(dev, "Storing extent %d/%d\n",
+				start_index + i, exp_cnt);
+			rc = cxl_store_dc_extent(mds, &dc_extents->extent[i]);
+			if (rc)
+				goto out;
+		}
+
+		start_index += nr_ext;
+	} while (exp_cnt > total_read);
+
+out:
+	kvfree(dc_extents);
+	return rc;
+}
+
+/**
+ * cxl_dev_get_dynamic_capacity_extents() - Reads the dynamic capacity
+ *					 extent list.
+ * @mds: The memory device state
+ *
+ * This will dispatch the get_dynamic_capacity_extent_list command to the device
+ * and on success add the extents to the host managed extent list.
+ *
+ * Return: 0 if command was executed successfully, -ERRNO on error.
+ */
+int cxl_dev_get_dynamic_capacity_extents(struct cxl_memdev_state *mds)
+{
+	unsigned int extent_gen_num;
+	int rc;
+
+	rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
+	dev_dbg(mds->cxlds.dev, "Extent count: %d Generation Num: %d\n",
+		rc, extent_gen_num);
+	if (rc <= 0) /* 0 == no records found */
+		return rc;
+
+	return cxl_dev_get_dc_extents(mds, extent_gen_num, rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dynamic_capacity_extents, CXL);
+
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
 		       resource_size_t size, const char *type)
@@ -1530,9 +1704,23 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
 
+static void cxl_destroy_mds(void *_mds)
+{
+	struct cxl_memdev_state *mds = _mds;
+	struct cxl_dc_extent_data *extent;
+	unsigned long index;
+
+	xa_for_each(&mds->dc_extent_list, index, extent) {
+		xa_erase(&mds->dc_extent_list, index);
+		kfree(extent);
+	}
+	xa_destroy(&mds->dc_extent_list);
+}
+
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 {
 	struct cxl_memdev_state *mds;
+	int rc;
 
 	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
 	if (!mds) {
@@ -1544,6 +1732,13 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
+	xa_init(&mds->dc_extent_list);
+
+	rc = devm_add_action_or_reset(dev, cxl_destroy_mds, mds);
+	if (rc) {
+		dev_err(dev, "Failed to set up memdev state; %d\n", rc);
+		return ERR_PTR(rc);
+	}
 
 	return mds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8c8f47b397ab..ad690600c1b9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,6 +6,7 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
+#include <linux/xarray.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -509,6 +510,7 @@ struct cxl_memdev_state {
 	u8 nr_dc_region;
 	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
 	size_t dc_event_log_size;
+	struct xarray dc_extent_list;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
@@ -749,6 +751,26 @@ struct cxl_event_mem_module {
 	u8 reserved[0x3d];
 } __packed;
 
+#define CXL_DC_EXTENT_TAG_LEN 0x10
+struct cxl_dc_extent_data {
+	u64 dpa_start;
+	u64 length;
+	u8 tag[CXL_DC_EXTENT_TAG_LEN];
+	u16 shared_extent_seq;
+};
+
+/*
+ * Dynamic Capacity Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.5; Table 8-47
+ */
+struct cxl_dc_extent {
+	__le64 start_dpa;
+	__le64 length;
+	u8 tag[CXL_DC_EXTENT_TAG_LEN];
+	__le16 shared_extn_seq;
+	u8 reserved[6];
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
@@ -796,6 +818,19 @@ struct cxl_mbox_dynamic_capacity {
 #define CXL_REGIONS_RETURNED(size_out) \
 	((size_out - 8) / sizeof(struct cxl_dc_region_config))
 
+struct cxl_mbox_get_dc_extent {
+	__le32 extent_cnt;
+	__le32 start_extent_index;
+} __packed;
+
+struct cxl_mbox_dc_extents {
+	__le32 ret_extent_cnt;
+	__le32 total_extent_cnt;
+	__le32 extent_list_num;
+	u8 rsvd[4];
+	struct cxl_dc_extent extent[];
+}  __packed;
+
 /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
 struct cxl_mbox_set_timestamp_in {
 	__le64 timestamp;
@@ -920,6 +955,7 @@ int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
+int cxl_dev_get_dynamic_capacity_extents(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a9b110ff1176..10c1a583113c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -930,6 +930,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
 
+	rc = cxl_dev_get_dynamic_capacity_extents(mds);
+	if (rc)
+		return rc;
+
 	pci_save_state(pdev);
 
 	return rc;

-- 
2.45.2

