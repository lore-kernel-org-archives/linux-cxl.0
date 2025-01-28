Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D321DED68;
	Tue, 28 Jan 2025 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738090276; cv=none; b=hwP2RpA0v71+0cuUjp/zDmzHgvyDfO7nwyFUC9zIpOXabglCFPm9IuKluSbDdoAjwwfN8Pdrn9aFdPp6+XK/J6c745+SAE660EjBx/pXSiusvHG0bOmSAGJRoh6YXlKiFFDvftcfzcQPS2sSIofBRyxcW91pyCCPmznfUMO43UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738090276; c=relaxed/simple;
	bh=nciEEbfU0BhnuH1s6XyWojuv+UQ1iYS1TNk6c2h7y1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KP4YvvQU9YG/2Noo10aYOd/yUVoVwdg1w0/JDr3284BgwArjydZnfpD7qGawH0GVJRWdL1iU2e8F/TPAQa52JYLcU/eE4Ow/7p9AmBlgnt0oXEVG2QCtTJCsqr53XzVvRBpXLsmgBdEWnxDAy3H2f0NHtKdxmQsygZLdifvIK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAEvuZ+K; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAEvuZ+K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738090274; x=1769626274;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nciEEbfU0BhnuH1s6XyWojuv+UQ1iYS1TNk6c2h7y1A=;
  b=QAEvuZ+KBKJgDNdxo5OBl/Xk8L4hfeAa7CrPJh4+FE1Je4s6liRQ/Z6S
   pnojIaNbs7KiCrm2QSiUKVACKtEhmu+2EPQ5mqwXorJhgPxN0OyJkmj7Y
   xYkE/xg1e5SU8QtkxEjiTO5xuc77yMdr8RJIviADwCgEdhyjgFfqgUaWr
   sTMVV495bjgkKySUd8oBLeS9zFjoOQgBYMouNOxWgwnoQt/57fJvj/N+R
   nijAyP5OU63g2BkEexUrHZRuNUnFvqnuCWndkBQh+ZIwinb80TLnkUJtX
   5R1QbcsnKOMaUoonzxcGN6UoaxdzrOnlTbRMqaiqKQlUdOIFocMjKfdf6
   Q==;
X-CSE-ConnectionGUID: FxcGI/h8RvmDqkQMrFFSKg==
X-CSE-MsgGUID: mfk/c3Q3RraBpQX/kzHZOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49177338"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="49177338"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 10:51:14 -0800
X-CSE-ConnectionGUID: E1YHFUg4SUeBVrWJFmIZ0A==
X-CSE-MsgGUID: Joe46UvpT/qU3OJidt5C9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108676684"
Received: from puneetse-mobl.amr.corp.intel.com (HELO localhost) ([10.125.108.40])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 10:51:14 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 28 Jan 2025 12:51:08 -0600
Subject: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738090268; l=10863;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=nciEEbfU0BhnuH1s6XyWojuv+UQ1iYS1TNk6c2h7y1A=;
 b=9UBjsmdTeDfowrTKx5A4YIgaH3ODUJ3ke4RrpjqrwVM4nak23EPN+lG6N9S8ZSx2VKucqCLTg
 UmbLh7P8q32AceoSUw0f2wWyWNotv5gv/6sJqT2KUB98//J4Y2H9CRT
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

As was mentioned by Dan[1] cxl_memdev_state stores values which are only
used during device probe.  This clutters the data structure and is a
hindrance on code maintenance.  Those values are best handled with
temporary variables.

Adjust the query of memory devices to read byte sizes in one call which
takes partition information into account.  Use the values to create
partitions for device state initialization.  Take care to separate the
mailbox queries from the initialization of device state to steer the
mbox code toward taking mailbox objects rather than memdev states.
Update spec references while changing these calls.

Link: https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c      | 77 +++++++++++++++++---------------------------
 drivers/cxl/cxlmem.h         | 25 +++++++-------
 drivers/cxl/pci.c            | 13 +++++---
 tools/testing/cxl/test/mem.c | 13 +++++---
 4 files changed, 59 insertions(+), 69 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 998e1df36db673c47c4e87b957df9c29bf3f291a..44618746ad79b0459501bb3001518f6b7d2ceaba 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1068,6 +1068,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
 /**
  * cxl_mem_get_partition_info - Get partition info
  * @mds: The driver data for the operation
+ * @dev_info: Device info results
  *
  * Retrieve the current partition info for the device specified.  The active
  * values are the current capacity in bytes.  If not 0, the 'next' values are
@@ -1075,9 +1076,10 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
  *
  * Return: 0 if no error: or the result of the mailbox command.
  *
- * See CXL @8.2.9.5.2.1 Get Partition Info
+ * See CXL 3.1 @8.2.9.9.2.1 Get Partition Info
  */
-static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
+static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds,
+				      struct cxl_mem_dev_info *dev_info)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_partition_info pi;
@@ -1093,9 +1095,9 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 	if (rc)
 		return rc;
 
-	mds->active_volatile_bytes =
+	dev_info->volatile_bytes =
 		le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
-	mds->active_persistent_bytes =
+	dev_info->persistent_bytes =
 		le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
 
 	return 0;
@@ -1104,18 +1106,24 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 /**
  * cxl_dev_state_identify() - Send the IDENTIFY command to the device.
  * @mds: The driver data for the operation
+ * @dev_info: Device info results
  *
  * Return: 0 if identify was executed successfully or media not ready.
  *
- * This will dispatch the identify command to the device and on success populate
- * structures to be exported to sysfs.
+ * This will dispatch the identify and partition info commands to the device
+ * and on success populate structures required for the memory device to
+ * operate.
+ *
+ * See CXL 3.1 @8.2.9.9.1.1 Identify Memory Device
  */
-int cxl_dev_state_identify(struct cxl_memdev_state *mds)
+int cxl_dev_state_identify(struct cxl_memdev_state *mds,
+			   struct cxl_mem_dev_info *dev_info)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
+	struct device *dev = cxl_mbox->host;
 	struct cxl_mbox_identify id;
 	struct cxl_mbox_cmd mbox_cmd;
+	u64 partition_align_bytes;
 	u32 val;
 	int rc;
 
@@ -1131,14 +1139,22 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 	if (rc < 0)
 		return rc;
 
-	mds->total_bytes =
+	dev_info->total_bytes =
 		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
-	mds->volatile_only_bytes =
+	dev_info->volatile_bytes =
 		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
-	mds->persistent_only_bytes =
+	dev_info->persistent_bytes =
 		le64_to_cpu(id.persistent_capacity) * CXL_CAPACITY_MULTIPLIER;
-	mds->partition_align_bytes =
+
+	partition_align_bytes =
 		le64_to_cpu(id.partition_align) * CXL_CAPACITY_MULTIPLIER;
+	if (partition_align_bytes != 0) {
+		rc = cxl_mem_get_partition_info(mds, dev_info);
+		if (rc) {
+			dev_err(dev, "Failed to query partition information\n");
+			return rc;
+		}
+	}
 
 	mds->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(mds->firmware_version, id.fw_revision,
@@ -1237,7 +1253,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return rc;
 }
 
-static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
+void cxl_add_partition(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
 {
 	int i = info->nr_partitions;
 
@@ -1251,40 +1267,7 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
 	info->part[i].mode = mode;
 	info->nr_partitions++;
 }
-
-int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
-{
-	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct device *dev = cxlds->dev;
-	int rc;
-
-	if (!cxlds->media_ready) {
-		info->size = 0;
-		return 0;
-	}
-
-	info->size = mds->total_bytes;
-
-	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
-		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
-		return 0;
-	}
-
-	rc = cxl_mem_get_partition_info(mds);
-	if (rc) {
-		dev_err(dev, "Failed to query partition information\n");
-		return rc;
-	}
-
-	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
-	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
-		 CXL_PARTMODE_PMEM);
-
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_add_partition, "CXL");
 
 int cxl_set_timestamp(struct cxl_memdev_state *mds)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 29817f533e5e408243d361c46ddbf0c295b4fda4..62e641d69eac975bae023f221c40713ad0317d1a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -542,12 +542,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @firmware_version: Firmware version for the memory device.
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
- * @total_bytes: sum of all possible capacities
- * @volatile_only_bytes: hard volatile capacity
- * @persistent_only_bytes: hard persistent capacity
- * @partition_align_bytes: alignment size for partition-able capacity
- * @active_volatile_bytes: sum of hard + soft volatile
- * @active_persistent_bytes: sum of hard + soft persistent
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
@@ -562,12 +556,6 @@ struct cxl_memdev_state {
 	char firmware_version[0x10];
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
-	u64 total_bytes;
-	u64 volatile_only_bytes;
-	u64 persistent_only_bytes;
-	u64 partition_align_bytes;
-	u64 active_volatile_bytes;
-	u64 active_persistent_bytes;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
@@ -885,10 +873,19 @@ enum {
 
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
-int cxl_dev_state_identify(struct cxl_memdev_state *mds);
+
+struct cxl_mem_dev_info {
+	u64 total_bytes;
+	u64 volatile_bytes;
+	u64 persistent_bytes;
+};
+
+int cxl_dev_state_identify(struct cxl_memdev_state *mds,
+			   struct cxl_mem_dev_info *dev_info);
+void cxl_add_partition(struct cxl_dpa_info *info, u64 start, u64 size,
+		       enum cxl_partition_mode mode);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
-int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index fa30e763a0ce4fd78441f486ce08c81e21207e29..b69ba756e7f722a327c42fb57f843635cf8367a2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -903,6 +903,7 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	struct cxl_mem_dev_info dev_info = { 0 };
 	struct cxl_dpa_info range_info = { 0 };
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
@@ -989,13 +990,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_dev_state_identify(mds);
+	rc = cxl_dev_state_identify(mds, &dev_info);
 	if (rc)
 		return rc;
 
-	rc = cxl_mem_dpa_fetch(mds, &range_info);
-	if (rc)
-		return rc;
+	if (cxlds->media_ready) {
+		range_info.size = dev_info.total_bytes;
+		cxl_add_partition(&range_info, 0, dev_info.volatile_bytes,
+				  CXL_PARTMODE_RAM);
+		cxl_add_partition(&range_info, dev_info.volatile_bytes,
+				  dev_info.persistent_bytes, CXL_PARTMODE_PMEM);
+	}
 
 	rc = cxl_dpa_setup(cxlds, &range_info);
 	if (rc)
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index ed365e083c8f545b6c1308f48b5f4f7bc51135e8..b88bc3fd8122e6dd2969d525e72f1ea8d5069913 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1477,6 +1477,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	struct cxl_dev_state *cxlds;
 	struct cxl_mockmem_data *mdata;
 	struct cxl_mailbox *cxl_mbox;
+	struct cxl_mem_dev_info dev_info = { 0 };
 	struct cxl_dpa_info range_info = { 0 };
 	int rc;
 
@@ -1534,13 +1535,17 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return rc;
 
 	cxlds->media_ready = true;
-	rc = cxl_dev_state_identify(mds);
+	rc = cxl_dev_state_identify(mds, &dev_info);
 	if (rc)
 		return rc;
 
-	rc = cxl_mem_dpa_fetch(mds, &range_info);
-	if (rc)
-		return rc;
+	if (cxlds->media_ready) {
+		range_info.size = dev_info.total_bytes;
+		cxl_add_partition(&range_info, 0, dev_info.volatile_bytes,
+				  CXL_PARTMODE_RAM);
+		cxl_add_partition(&range_info, dev_info.volatile_bytes,
+				  dev_info.persistent_bytes, CXL_PARTMODE_PMEM);
+	}
 
 	rc = cxl_dpa_setup(cxlds, &range_info);
 	if (rc)

-- 
2.48.1

