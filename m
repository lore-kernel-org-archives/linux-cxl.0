Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D3281508
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897275; cv=fail; b=otdbcrfQ9kCZmkWLtbD/6B2c+LQB/59FzVaUwcd4gT547JGgD6safz7kKBrqt6TEdlfSWAqNdTIoNd++71dpEEY9aGyzpLOzfzQbXlvIchMBb87wkDHCfgr/EEDW2UZfm7kq2LoB//W02gIFxazsLyJokz6STpaGkMdQoUOaw2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897275; c=relaxed/simple;
	bh=XXy3/nXrdnUrFfjQniy7lBIWNGTPdp7gaO481A/2/m8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx/y7GNnnZSaE2rgo3KZAa8WOgA9HofUAqwTgVwe3XdytAWHlBx4BAVC7hh3yLVqNzSbW5Wvd3bPU+NO0yK7MZI0dwOUe3UUEoh/10wW5AbDzQrDneicWWevn4n6cGANb3jNZKm620QDI3r9Zi3zveMZtxeNAjk0zKJe1C63b7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nLTNW57D; arc=fail smtp.client-ip=40.93.194.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nLTNW57D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gn9b67wYun5lB3McjL3110tBbvBhPfzdE+hFAndx8OBu9FDd6CW64P+dJ3vPr13gdyWyfmy3xSB58u8hpxbUUkJRxX6uhPZVvnL2+gi43YfmPhIwmWH+bAk+8aFVdymXp5/S/M/Yk6OhcJYpbYn5voJSzFsDpiRjC6+FVa9YFgO5jejDHlzKn7mX2tZnKTO6BivUoUkpjPygWJNq61S6CvTlUEXmrYNiKo7gxfLoHH4eYO33DQ9LVuXiAkp9tklfDPBMyNA7kkK+2pPSVPEP2cCsNy+WgqbMmRRKx3fSbHqxHddk125qkHudl0JTdaVKNS6oWk86l3RzhGngJ1xOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH69VK/IIxMNO4oiai7/kqnndU0KG9C1Qx9C/zNbjVM=;
 b=zV5AtfRiMZkYnFTZrGaJhVGukvDBWJyTwXUVHAJosnYHoTXX0wfe/D6pFhaLpOr7lyao+7SJO1A6vFc2KqgVfA8/Pq8zxbL9JA6svR9RYc2xWj4gF/Ud2E6dCWqGmUsBit1VOcgjOVB/NjkZWCe7LGkjOMVP6YWM6EzLCjQv8Us46CqP2txpvbJ5yejqh/RZuO+oFPJTTs0VWxqYzPkTJsQn5J57mc1ZctoiPL1Iueb3LsjMTlTtXnPzUYZscQQoaRodVah9BJZrcZf6PqdA6bbtxnyfOqYG1CiGMCKmwZbeeYCeVx8wpa4UFM2jjJula28XI1lzTWCpCmrdXISKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH69VK/IIxMNO4oiai7/kqnndU0KG9C1Qx9C/zNbjVM=;
 b=nLTNW57DVboaYhVD3cCgMXU++hyMEETrF739lhetylVsxVqoGGJuEUtlcs3rPQm8AusI7z1mTllA+vnbLWRXP69orm0qJVvD4RdNQei0de7e7u0cYnradQcXqvV5441HjpIMFJUQcwkhz27VG7sVbpmCOJTJ5ddPNWe/v7GSyqY=
Received: from BL1PR13CA0363.namprd13.prod.outlook.com (2603:10b6:208:2c0::8)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 21:41:10 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::68) by BL1PR13CA0363.outlook.office365.com
 (2603:10b6:208:2c0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:41:10 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:41:09 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 02/17] cxl: Move struct cxl_dev_state definition
Date: Tue, 11 Nov 2025 15:40:17 -0600
Message-ID: <20251111214032.8188-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fa1eeb-4da2-442b-b1cd-08de216b074a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zsiSQ37P4WDUAi1BkAVZAIGjjVnqm4R5MKIqMwan2cwf23BfXDBMSk2fvbMS?=
 =?us-ascii?Q?u4qxq0FhYTdZyInBAglCVkCgSbBHo/nzkB0f4c9uGbzIE3iGORWPgPnRHdMS?=
 =?us-ascii?Q?5dFDAskc8pIi/sKW2w/vbbI1Pvr5I7qpOok+9+9ZMixD5YHUO4Y5WVi0vTVa?=
 =?us-ascii?Q?MjyNtNjSgg2ipe3dOxu+qU/cmhCUeMvfl1NkHKfXNQ66p7bj/QIPdM9ms0CW?=
 =?us-ascii?Q?pqSHYrAAdI1zlLjKfZse5A7J+MMWigAJKm7fH2n8ClgKkJxzrG1GvxD0rmv5?=
 =?us-ascii?Q?RJA4ASQJPuSTt6nXvX14twXaNY2FIW7ZsS1rnESm5tdXafbxriwsX5+TgY8A?=
 =?us-ascii?Q?pqs7WTRIW1+XP2ycoTnJygfEDbRpA4ni2/4jX1xQMu513pg+fH0TuD6HJ8qJ?=
 =?us-ascii?Q?w83Ea1n0miX65W+XW3c2zvRTgdjdbs0FgLd3kS6qbBAx/9qhvHYbdoIDu2Y9?=
 =?us-ascii?Q?Ip5BauShdwzGxn8gtpcQj6ezOeE3LrsjaK6V1Y1PCURzdUOB3D85iBtt30mi?=
 =?us-ascii?Q?SMhH8RGQjnSAp4yY3Jhp/fi6vmZ80f5c2IiDr7kqPIFKqxQ187A+eQRAXX5L?=
 =?us-ascii?Q?rWQ+nGak2cj4RR5MX9lt/hF1B46RSYeTLI29W6UMX8oRiqXlTmZP7UyA4vKV?=
 =?us-ascii?Q?W3xLqTx90Z/MlK1avWAuYva8keInQHcAGseLE8rQMXnt6AjHmRxeNqvqPaPd?=
 =?us-ascii?Q?khlidn+jF552Efayc2zYu7Yl1je4Gv+INWHjVhSM7neDzDM76JN4zc1bgL9O?=
 =?us-ascii?Q?K/9up69aSKaZE1ukDW5fhPsTL6aEsNYmG17w0NDOkG2d0n8TiMX52i01Qr+l?=
 =?us-ascii?Q?bUsu7yQowiN7G+aCo9STjmsSlBbvn3T20o7vqn6ICxaZtH2ZY/cobjzRXyDv?=
 =?us-ascii?Q?tQLUI3j9x+KOBs6Y6Iv4HQrs02pQJQCrzEOWB4/wKOaPlvXTaQq/YUbkuGyF?=
 =?us-ascii?Q?bCktBYZURcex/JxlW+h7YYD6wXQwmwOEpkJMMSVZD+wLxy5AMQ06eerOfjID?=
 =?us-ascii?Q?LAYdRy+QA9LbueI6kRUr9Bk3TD2spRUckBVbvikMmSfOt+REKbkIsoI/d2Qt?=
 =?us-ascii?Q?BZHrARJ+tRlVys4OopNgDEWo3azVuXe6PcRpkUHwNb+X2t50kSheprCkLnOe?=
 =?us-ascii?Q?CBgnXvIMHGneuHicU5pD754fjCVHeg+uIgi3Op0obru6KwKcWDPrPi8TyU1B?=
 =?us-ascii?Q?cIIEtmMaLHF8D21U55WPfgL2zqyqhEtbihFWeFbJmX2Dk9Jp+is2R3xmJe4N?=
 =?us-ascii?Q?RMiM5EGpkjlhKxuArquxJ4c8TgZh6zZurQLVSuPn7+IIKY8TN68upNDKZQS0?=
 =?us-ascii?Q?xKjbUnzdCHVjethwHcQkMyXgjR9sPQBEqtaDajSVsy0c5L0O4FHvkIonnTUv?=
 =?us-ascii?Q?WiuWnwLoXad141q7a1KWCWsAOBBiRc1ukb+pybsDG5l+GsKnynemNZIUlQ3M?=
 =?us-ascii?Q?FYPOGXafp+cxlzA1ZnuGfgJKAztE4WjxgBKjc4UsRvTHeN9dMe3kcXNmzl2b?=
 =?us-ascii?Q?ZZLPPfh9VkZtbp/KFmWq9Q/YY7MNxTTWcGilIHasIazdZ1++HxOFJxUAyoU4?=
 =?us-ascii?Q?aaseEm7Scx8gSdtG4Uk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:41:10.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fa1eeb-4da2-442b-b1cd-08de216b074a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

Move struct cxl_dev_state (and associated structs) from cxlmem.h to
cxl.h. This is in preparation of adding a new CXL cache device type
that will also use cxl_dev_state.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cxl.h    | 110 +++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h | 109 ------------------------------------------
 2 files changed, 110 insertions(+), 109 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 231ddccf8977..1950cf3d5399 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -12,6 +12,7 @@
 #include <linux/node.h>
 #include <linux/io.h>
 #include <linux/range.h>
+#include <cxl/mailbox.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -707,6 +708,115 @@ struct cxl_ep {
 	struct cxl_port *next;
 };
 
+/*
+ * enum cxl_devtype - delineate type-2 from a generic type-3 device
+ * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
+ *			 HDM-DB, no requirement that this device implements a
+ *			 mailbox, or other memory-device-standard manageability
+ *			 flows.
+ * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
+ *			   HDM-H and class-mandatory memory device registers
+ */
+enum cxl_devtype {
+	CXL_DEVTYPE_DEVMEM,
+	CXL_DEVTYPE_CLASSMEM,
+};
+
+/**
+ * struct cxl_dpa_perf - DPA performance property entry
+ * @dpa_range: range for DPA address
+ * @coord: QoS performance data (i.e. latency, bandwidth)
+ * @cdat_coord: raw QoS performance data from CDAT
+ * @qos_class: QoS Class cookies
+ */
+struct cxl_dpa_perf {
+	struct range dpa_range;
+	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
+	int qos_class;
+};
+
+/**
+ * struct cxl_dpa_partition - DPA partition descriptor
+ * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
+ * @perf: performance attributes of the partition from CDAT
+ * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
+ */
+struct cxl_dpa_partition {
+	struct resource res;
+	struct cxl_dpa_perf perf;
+	enum cxl_partition_mode mode;
+};
+
+#define CXL_NR_PARTITIONS_MAX 2
+
+struct cxl_dpa_info {
+	u64 size;
+	struct cxl_dpa_part_info {
+		struct range range;
+		enum cxl_partition_mode mode;
+	} part[CXL_NR_PARTITIONS_MAX];
+	int nr_partitions;
+};
+
+/**
+ * struct cxl_dev_state - The driver device state
+ *
+ * cxl_dev_state represents the CXL driver/device state.  It provides an
+ * interface to mailbox commands as well as some cached data about the device.
+ * Currently only memory devices are represented.
+ *
+ * @dev: The device associated with this CXL state
+ * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @reg_map: component and ras register mapping parameters
+ * @regs: Parsed register blocks
+ * @cxl_dvsec: Offset to the PCIe device DVSEC
+ * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @media_ready: Indicate whether the device media is usable
+ * @dpa_res: Overall DPA resource tree for the device
+ * @part: DPA partition array
+ * @nr_partitions: Number of DPA partitions
+ * @serial: PCIe Device Serial Number
+ * @type: Generic Memory Class device or Vendor Specific Memory device
+ * @cxl_mbox: CXL mailbox context
+ * @cxlfs: CXL features context
+ */
+struct cxl_dev_state {
+	struct device *dev;
+	struct cxl_memdev *cxlmd;
+	struct cxl_register_map reg_map;
+	struct cxl_regs regs;
+	int cxl_dvsec;
+	bool rcd;
+	bool media_ready;
+	struct resource dpa_res;
+	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
+	unsigned int nr_partitions;
+	u64 serial;
+	enum cxl_devtype type;
+	struct cxl_mailbox cxl_mbox;
+#ifdef CONFIG_CXL_FEATURES
+	struct cxl_features_state *cxlfs;
+#endif
+};
+
+static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
+{
+	/*
+	 * Static PMEM may be at partition index 0 when there is no static RAM
+	 * capacity.
+	 */
+	for (int i = 0; i < cxlds->nr_partitions; i++)
+		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
+			return resource_size(&cxlds->part[i].res);
+	return 0;
+}
+
+static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
+{
+	return dev_get_drvdata(cxl_mbox->host);
+}
+
 /**
  * struct cxl_region_ref - track a region's interest in a port
  * @port: point in topology to install this reference
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 434031a0c1f7..0b6339916559 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -105,17 +105,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
 
-#define CXL_NR_PARTITIONS_MAX 2
-
-struct cxl_dpa_info {
-	u64 size;
-	struct cxl_dpa_part_info {
-		struct range range;
-		enum cxl_partition_mode mode;
-	} part[CXL_NR_PARTITIONS_MAX];
-	int nr_partitions;
-};
-
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
 
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
@@ -365,104 +354,6 @@ struct cxl_security_state {
 	struct kernfs_node *sanitize_node;
 };
 
-/*
- * enum cxl_devtype - delineate type-2 from a generic type-3 device
- * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
- *			 HDM-DB, no requirement that this device implements a
- *			 mailbox, or other memory-device-standard manageability
- *			 flows.
- * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
- *			   HDM-H and class-mandatory memory device registers
- */
-enum cxl_devtype {
-	CXL_DEVTYPE_DEVMEM,
-	CXL_DEVTYPE_CLASSMEM,
-};
-
-/**
- * struct cxl_dpa_perf - DPA performance property entry
- * @dpa_range: range for DPA address
- * @coord: QoS performance data (i.e. latency, bandwidth)
- * @cdat_coord: raw QoS performance data from CDAT
- * @qos_class: QoS Class cookies
- */
-struct cxl_dpa_perf {
-	struct range dpa_range;
-	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
-	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
-	int qos_class;
-};
-
-/**
- * struct cxl_dpa_partition - DPA partition descriptor
- * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
- * @perf: performance attributes of the partition from CDAT
- * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
- */
-struct cxl_dpa_partition {
-	struct resource res;
-	struct cxl_dpa_perf perf;
-	enum cxl_partition_mode mode;
-};
-
-/**
- * struct cxl_dev_state - The driver device state
- *
- * cxl_dev_state represents the CXL driver/device state.  It provides an
- * interface to mailbox commands as well as some cached data about the device.
- * Currently only memory devices are represented.
- *
- * @dev: The device associated with this CXL state
- * @cxlmd: The device representing the CXL.mem capabilities of @dev
- * @reg_map: component and ras register mapping parameters
- * @regs: Parsed register blocks
- * @cxl_dvsec: Offset to the PCIe device DVSEC
- * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
- * @media_ready: Indicate whether the device media is usable
- * @dpa_res: Overall DPA resource tree for the device
- * @part: DPA partition array
- * @nr_partitions: Number of DPA partitions
- * @serial: PCIe Device Serial Number
- * @type: Generic Memory Class device or Vendor Specific Memory device
- * @cxl_mbox: CXL mailbox context
- * @cxlfs: CXL features context
- */
-struct cxl_dev_state {
-	struct device *dev;
-	struct cxl_memdev *cxlmd;
-	struct cxl_register_map reg_map;
-	struct cxl_regs regs;
-	int cxl_dvsec;
-	bool rcd;
-	bool media_ready;
-	struct resource dpa_res;
-	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
-	unsigned int nr_partitions;
-	u64 serial;
-	enum cxl_devtype type;
-	struct cxl_mailbox cxl_mbox;
-#ifdef CONFIG_CXL_FEATURES
-	struct cxl_features_state *cxlfs;
-#endif
-};
-
-static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
-{
-	/*
-	 * Static PMEM may be at partition index 0 when there is no static RAM
-	 * capacity.
-	 */
-	for (int i = 0; i < cxlds->nr_partitions; i++)
-		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
-			return resource_size(&cxlds->part[i].res);
-	return 0;
-}
-
-static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
-{
-	return dev_get_drvdata(cxl_mbox->host);
-}
-
 /**
  * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
  *
-- 
2.51.1

