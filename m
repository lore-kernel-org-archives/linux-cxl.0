Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B3EB64DB
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 19:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjFNTTk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjFNTTj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 15:19:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D44B2137
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686770377; x=1718306377;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=cKeS+U4sYUhplZfWFntMyShCYSXobYHb2rZR1SYY6F8=;
  b=hL7UdEKmyKN3DCEb7kgPrPPEGoQY95AIWbfk8b3RRaDIUIz6fDfKeVIM
   nV/NQ69eY+bJv5ZkJX8I4Dtz7awLIoq7/w+175x7Amr2QgJINO92f+q2O
   09J/3FikCGNJ3v+GJNmklJl+X7q/ApKX/kdUqGXnACLQUBE3ZhAeXNE1d
   IR7PIlC8dRmxX+efW3hXmEQxvu4SwUshGsNYuVKYBApQth15+//rTkC2W
   ZAq/HGCnwV0LFvUoGaFG3dcWVOJMO/7h4R0O/bAFoww5FE8FoHw1ZFMgN
   LoBCTudLmkx7W7/Tadi8PIWGPgymnt8v8aBs5PicdjDkLF3Dy/YV20IzG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338347273"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338347273"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="886384233"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="886384233"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.116.198])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:33 -0700
From:   ira.weiny@intel.com
Date:   Wed, 14 Jun 2023 12:16:28 -0700
Subject: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from the
 device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
To:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686770367; l=15127;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=PcsN4I9rqNsPCQZzgSCQbJjGpJotFPnQ2dQGxBeKS8g=;
 b=EpVaah1GhS7j8Xt4k1WLlUhAw/3OAqTChjeOYGReiIjeIGz0Kdl8n8tp8Aq6K0do3Z3FG4/hz
 A1i8qjyOx/ZBvl39g/leeyHfrNZeZ2sYhGVy1TZpb2yIIH9H32MJEaj
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Navneet Singh <navneet.singh@intel.com>

Read the Dynamic capacity configuration and store dynamic capacity region
information in the device state which driver will use to map into the HDM
ranges.

Implement Get Dynamic Capacity Configuration (opcode 4800h) mailbox
command as specified in CXL 3.0 spec section 8.2.9.8.9.1.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>

---
[iweiny: ensure all mds->dc_region's are named]
---
 drivers/cxl/core/mbox.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/cxlmem.h    |  70 +++++++++++++++++-
 drivers/cxl/pci.c       |   4 +
 3 files changed, 256 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 3ca0bf12c55f..c5b696737c87 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -111,6 +111,37 @@ static u8 security_command_sets[] = {
 	0x46, /* Security Passthrough */
 };
 
+static bool cxl_is_dcd_command(u16 opcode)
+{
+#define CXL_MBOX_OP_DCD_CMDS 0x48
+
+	if ((opcode >> 8) == CXL_MBOX_OP_DCD_CMDS)
+		return true;
+
+	return false;
+}
+
+static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
+					u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_DC_CONFIG:
+		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
+		break;
+	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
+		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
+		break;
+	case CXL_MBOX_OP_ADD_DC_RESPONSE:
+		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
+		break;
+	case CXL_MBOX_OP_RELEASE_DC:
+		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
+		break;
+	default:
+		break;
+	}
+}
+
 static bool cxl_is_security_command(u16 opcode)
 {
 	int i;
@@ -666,6 +697,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
 static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 {
 	struct cxl_cel_entry *cel_entry;
+	struct cxl_mem_command *cmd;
 	const int cel_entries = size / sizeof(*cel_entry);
 	struct device *dev = mds->cxlds.dev;
 	int i;
@@ -674,11 +706,12 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 
 	for (i = 0; i < cel_entries; i++) {
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
-		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
+		cmd = cxl_mem_find_command(opcode);
 
-		if (!cmd && !cxl_is_poison_command(opcode)) {
-			dev_dbg(dev,
-				"Opcode 0x%04x unsupported by driver\n", opcode);
+		if (!cmd && !cxl_is_poison_command(opcode) &&
+		    !cxl_is_dcd_command(opcode)) {
+			dev_dbg(dev, "Opcode 0x%04x unsupported by driver\n",
+				opcode);
 			continue;
 		}
 
@@ -688,6 +721,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		if (cxl_is_poison_command(opcode))
 			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
 
+		if (cxl_is_dcd_command(opcode))
+			cxl_set_dcd_cmd_enabled(mds, opcode);
+
 		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
 	}
 }
@@ -1059,7 +1095,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 	if (rc < 0)
 		return rc;
 
-	mds->total_bytes =
+	mds->total_static_capacity =
 		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
 	mds->volatile_only_bytes =
 		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
@@ -1077,10 +1113,137 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 		mds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
 	}
 
+	mds->dc_event_log_size = le16_to_cpu(id.dc_event_log_size);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
 
+/**
+ * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
+ * information from the device.
+ * @mds: The memory device state
+ * Return: 0 if identify was executed successfully.
+ *
+ * This will dispatch the get_dynamic_capacity command to the device
+ * and on success populate structures to be exported to sysfs.
+ */
+int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = cxlds->dev;
+	struct cxl_mbox_dynamic_capacity *dc;
+	struct cxl_mbox_get_dc_config get_dc;
+	struct cxl_mbox_cmd mbox_cmd;
+	u64 next_dc_region_start;
+	int rc, i;
+
+	for (i = 0; i < CXL_MAX_DC_REGION; i++)
+		sprintf(mds->dc_region[i].name, "dc%d", i);
+
+	/* Check GET_DC_CONFIG is supported by device */
+	if (!test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds)) {
+		dev_dbg(dev, "unsupported cmd: get_dynamic_capacity_config\n");
+		return 0;
+	}
+
+	dc = kvmalloc(mds->payload_size, GFP_KERNEL);
+	if (!dc)
+		return -ENOMEM;
+
+	get_dc = (struct cxl_mbox_get_dc_config) {
+		.region_count = CXL_MAX_DC_REGION,
+		.start_region_index = 0,
+	};
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
+		.payload_in = &get_dc,
+		.size_in = sizeof(get_dc),
+		.size_out = mds->payload_size,
+		.payload_out = dc,
+		.min_out = 1,
+	};
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0)
+		goto dc_error;
+
+	mds->nr_dc_region = dc->avail_region_count;
+
+	if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
+		dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
+			mds->nr_dc_region);
+		rc = -EINVAL;
+		goto dc_error;
+	}
+
+	for (i = 0; i < mds->nr_dc_region; i++) {
+		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
+
+		dcr->base = le64_to_cpu(dc->region[i].region_base);
+		dcr->decode_len =
+			le64_to_cpu(dc->region[i].region_decode_length);
+		dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
+		dcr->len = le64_to_cpu(dc->region[i].region_length);
+		dcr->blk_size = le64_to_cpu(dc->region[i].region_block_size);
+
+		/* Check regions are in increasing DPA order */
+		if ((i + 1) < mds->nr_dc_region) {
+			next_dc_region_start =
+				le64_to_cpu(dc->region[i + 1].region_base);
+			if ((dcr->base > next_dc_region_start) ||
+			    ((dcr->base + dcr->decode_len) > next_dc_region_start)) {
+				dev_err(dev,
+					"DPA ordering violation for DC region %d and %d\n",
+					i, i + 1);
+				rc = -EINVAL;
+				goto dc_error;
+			}
+		}
+
+		/* Check the region is 256 MB aligned */
+		if (!IS_ALIGNED(dcr->base, SZ_256M)) {
+			dev_err(dev, "DC region %d not aligned to 256MB\n", i);
+			rc = -EINVAL;
+			goto dc_error;
+		}
+
+		/* Check Region base and length are aligned to block size */
+		if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
+		    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
+			dev_err(dev, "DC region %d not aligned to %#llx\n", i,
+				dcr->blk_size);
+			rc = -EINVAL;
+			goto dc_error;
+		}
+
+		dcr->dsmad_handle =
+			le32_to_cpu(dc->region[i].region_dsmad_handle);
+		dcr->flags = dc->region[i].flags;
+		sprintf(dcr->name, "dc%d", i);
+
+		dev_dbg(dev,
+			"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
+			dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
+	}
+
+	/*
+	 * Calculate entire DPA range of all configured regions which will be mapped by
+	 * one or more HDM decoders
+	 */
+	mds->total_dynamic_capacity =
+		mds->dc_region[mds->nr_dc_region - 1].base +
+		mds->dc_region[mds->nr_dc_region - 1].decode_len -
+		mds->dc_region[0].base;
+	dev_dbg(dev, "Total dynamic capacity: %#llx\n",
+		mds->total_dynamic_capacity);
+
+dc_error:
+	kvfree(dc);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
+
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
 		       resource_size_t size, const char *type)
@@ -1112,6 +1275,11 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct device *dev = cxlds->dev;
 	int rc;
+	size_t untenanted_mem =
+		mds->dc_region[0].base - mds->total_static_capacity;
+
+	mds->total_capacity = mds->total_static_capacity +
+			untenanted_mem + mds->total_dynamic_capacity;
 
 	if (!cxlds->media_ready) {
 		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
@@ -1121,13 +1289,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
 	}
 
 	cxlds->dpa_res =
-		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
+		(struct resource)DEFINE_RES_MEM(0, mds->total_capacity);
+
+	for (int i = 0; i < CXL_MAX_DC_REGION; i++) {
+		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
+
+		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
+				 dcr->base, dcr->decode_len, dcr->name);
+		if (rc)
+			return rc;
+	}
 
 	if (mds->partition_align_bytes == 0) {
 		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
 				 mds->volatile_only_bytes, "ram");
 		if (rc)
 			return rc;
+
 		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
 				   mds->volatile_only_bytes,
 				   mds->persistent_only_bytes, "pmem");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 89e560ea14c0..9c0b2fa72bdd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -239,6 +239,15 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/* Device enabled DCD commands */
+enum dcd_cmd_enabled_bits {
+	CXL_DCD_ENABLED_GET_CONFIG,
+	CXL_DCD_ENABLED_GET_EXTENT_LIST,
+	CXL_DCD_ENABLED_ADD_RESPONSE,
+	CXL_DCD_ENABLED_RELEASE,
+	CXL_DCD_ENABLED_MAX
+};
+
 /* Device enabled poison commands */
 enum poison_cmd_enabled_bits {
 	CXL_POISON_ENABLED_LIST,
@@ -284,6 +293,9 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
+#define CXL_MAX_DC_REGION 8
+#define CXL_DC_REGION_SRTLEN 8
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -300,6 +312,8 @@ enum cxl_devtype {
  * @dpa_res: Overall DPA resource tree for the device
  * @pmem_res: Active Persistent memory capacity configuration
  * @ram_res: Active Volatile memory capacity configuration
+ * @dc_res: Active Dynamic Capacity memory configuration for each possible
+ *          region
  * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
@@ -315,6 +329,7 @@ struct cxl_dev_state {
 	struct resource dpa_res;
 	struct resource pmem_res;
 	struct resource ram_res;
+	struct resource dc_res[CXL_MAX_DC_REGION];
 	resource_size_t component_reg_phys;
 	u64 serial;
 	enum cxl_devtype type;
@@ -334,9 +349,12 @@ struct cxl_dev_state {
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
  * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
+ * @dcd_cmds: List of DCD commands implemented by memory device
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
- * @total_bytes: sum of all possible capacities
+ * @total_capacity: Sum of static and dynamic capacities
+ * @total_static_capacity: Sum of RAM and PMEM capacities
+ * @total_dynamic_capacity: Complete DPA range occupied by DC regions
  * @volatile_only_bytes: hard volatile capacity
  * @persistent_only_bytes: hard persistent capacity
  * @partition_align_bytes: alignment size for partition-able capacity
@@ -344,6 +362,10 @@ struct cxl_dev_state {
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
+ * @nr_dc_region: number of DC regions implemented in the memory device
+ * @dc_region: array containing info about the DC regions
+ * @dc_event_log_size: The number of events the device can store in the
+ * Dynamic Capacity Event Log before it overflows
  * @event: event log driver state
  * @poison: poison driver state info
  * @mbox_send: @dev specific transport for transmitting mailbox commands
@@ -357,9 +379,13 @@ struct cxl_memdev_state {
 	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
-	u64 total_bytes;
+
+	u64 total_capacity;
+	u64 total_static_capacity;
+	u64 total_dynamic_capacity;
 	u64 volatile_only_bytes;
 	u64 persistent_only_bytes;
 	u64 partition_align_bytes;
@@ -367,6 +393,20 @@ struct cxl_memdev_state {
 	u64 active_persistent_bytes;
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
+
+	u8 nr_dc_region;
+
+	struct cxl_dc_region_info {
+		u8 name[CXL_DC_REGION_SRTLEN];
+		u64 base;
+		u64 decode_len;
+		u64 len;
+		u64 blk_size;
+		u32 dsmad_handle;
+		u8 flags;
+	} dc_region[CXL_MAX_DC_REGION];
+
+	size_t dc_event_log_size;
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
 	int (*mbox_send)(struct cxl_memdev_state *mds,
@@ -415,6 +455,10 @@ enum cxl_opcode {
 	CXL_MBOX_OP_UNLOCK		= 0x4503,
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
 	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
+	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
+	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
+	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
+	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
@@ -462,6 +506,7 @@ struct cxl_mbox_identify {
 	__le16 inject_poison_limit;
 	u8 poison_caps;
 	u8 qos_telemetry_caps;
+	__le16 dc_event_log_size;
 } __packed;
 
 /*
@@ -617,7 +662,27 @@ struct cxl_mbox_set_partition_info {
 	u8 flags;
 } __packed;
 
+struct cxl_mbox_get_dc_config {
+	u8 region_count;
+	u8 start_region_index;
+} __packed;
+
+/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
+struct cxl_mbox_dynamic_capacity {
+	u8 avail_region_count;
+	u8 rsvd[7];
+	struct cxl_dc_region_config {
+		__le64 region_base;
+		__le64 region_decode_length;
+		__le64 region_length;
+		__le64 region_block_size;
+		__le32 region_dsmad_handle;
+		u8 flags;
+		u8 rsvd[3];
+	} __packed region[];
+} __packed;
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
+#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
 
 /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
 struct cxl_mbox_set_timestamp_in {
@@ -742,6 +807,7 @@ enum {
 int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
+int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4e2845b7331a..ac1a41bc083d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -742,6 +742,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_dev_dynamic_capacity_identify(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_create_range_info(mds);
 	if (rc)
 		return rc;

-- 
2.40.0

