Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C2281509
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034226; cv=fail; b=Xjh6iktp8g1wpLr4r6qOE7bUYQwUM5AFYs9Ob4gx6n68/63YulKJXV3YhkWvN4RcoauNbSGtTdG0bKtmhTistbDw3RXr4EQPekaEqXdu8DdKPk87XKfCXCgeoRb4ZN4YnKjqwBn/30ydSA3lCmqSxw+vay6jkklrnI6qQcel1sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034226; c=relaxed/simple;
	bh=4bhjLddkAvTzoBEfzFGSf0rMBGDoTn8tJzQeBsJthO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJUeSoR+N+T+y6EY8qKLktd9oJvlnmbT65L5wm7f1te8/czucwFLrw6pD/+vDinhkJHQwS4lWpxkYXJD+x8KnAl/zse5OK4suKY28Uqw8PU/G/upcTNpxBiNgb+nWPqj4icDatYxOsy9dCvUbVfii0HmgbWSxl2R2J+7v8QpNmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nskOdNZF; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nskOdNZF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXhdym1LLZke0zipwHje3FjjaKK95tbrXOvBfKWl0p8W2+fGhJd9NIoHTUYQ77UAcM+ljJSaeKQSWqv0GCTeS9fWplY+pPbbSazu73MfJvlwJCzJckSEcPxmhGOYhRFjHy7WUy6FpYvSDk4MTbJY0N9bG0iK1UHDYCjWVtKBMeOp8zBrF2DJdn3njY2ELtx6iIYGqmDMMTImGl/OdoFPyYkCpUHSVG8U0apwXOzJgx0msN0fVFW85RC12WIypvhUC+3S/Nok5FE1XkG7n3+SAF5561cNEWoP5W/QvDc93cM4OHUAcOs4UZoKWfok0e0Y6PgdjBR/dYwc5xeaeNT+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2XUM/6MQ6c767ye9L7qvU0mK4GQsb6PKucqWbQjCu4=;
 b=pCl716QkXdxRGeqF/ysnD2U4aH4A3oOh0fhJh2lB5jRyMzHoGzkWHIAYY3K2ftnnbXUt5wSQId9Twzz156WN6fTpQBs/P7IRKt7xgsO9C6ijohr+ncBnp1IOZ0hT++ZUxZkfI1Y7bwUCiK3sJzIKwnF1253h8USEyM+EviO31UL4zkJpdlKcntVi4cpRhUB84LWqzrr3QxOnGJ0q9hOALG7+d+D0qQW87NLD08aOCtcn8OsIG19SlLDZENWCv9hl6tKLudHr5Z8sbFC/V8nrL0TDFOBhCxG9nOIJ9KVxas+XYWVZM3HwhD49voTrMJGi4BaGqocgW0pVljhmKaqsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2XUM/6MQ6c767ye9L7qvU0mK4GQsb6PKucqWbQjCu4=;
 b=nskOdNZFmz/LDxoecLl1bPBXqOsRGWzqHPqTiuKwWdPbt/tNHD3HQgCWCyZUqk+Wz25KUD+nG+Sh5eBHVkITvFH+8SpOu4VGHPcYRpz3sN3YMOS28na4Q26IquUeXTNA5Y7HbRU0vlodY6x6pSQOjo4Hb/zmuvfU+FEYPFVXVas=
Received: from CH2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:610:20::34)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Tue, 12 Aug
 2025 21:30:17 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::c3) by CH2PR07CA0021.outlook.office365.com
 (2603:10b6:610:20::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Tue,
 12 Aug 2025 21:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:30:16 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:30:16 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 02/18] cxl: Move struct cxl_dev_state definition
Date: Tue, 12 Aug 2025 16:29:05 -0500
Message-ID: <20250812212921.9548-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 41940272-b893-4931-6e8f-08ddd9e76e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ee+7Mznd8UN/QVKEw+jb28087yL9iv91fllrgM52BF9ir0f9BECpwVKDjAPF?=
 =?us-ascii?Q?JZ3Vj8G4FQvvn+m8Dfwd1V3O/HAi9QuIXvDUZhq301kHC19lA77/mDJ+SGsV?=
 =?us-ascii?Q?wlUnAAMEkgXUXoqhLOA4cXAwwTZyPkMvFoFkrV6azR4KcT2cN0ohNypx7SGt?=
 =?us-ascii?Q?fV4rb7DpmP/ensbH6IfKXP2mhBVnGw0+MbqM9+dbx+5Itk3XWzUCm1PQFvFt?=
 =?us-ascii?Q?rjmPAw4UFLMabwNAAeS0s0Za4ch51fSF/xG/lBWDcvfMKtqjZpeN8WrurVFU?=
 =?us-ascii?Q?XR0TBf8g/9J3BeJ4qycuBC8xbFMnc3dVkAENI2CWmb48A9CXOSKUMKhxS5zb?=
 =?us-ascii?Q?edvhtNBigaY/n6qDNde0NiqvmVObRQAT/tbuL4D1ymLtFWrWp3sSJKmAxJ9q?=
 =?us-ascii?Q?GAtgQwslWxibKPpFNs+h9IV3KGl3Bhq8TLeTKP+d65agx3t6yECLYSOSFwOH?=
 =?us-ascii?Q?sjmPWBXHAERQoWjo6VplXGdR0sqMO5qFxtIm0y+0ZUMQFegC9emajfPRWTRN?=
 =?us-ascii?Q?CmrNJhonkMdQhTMVwU7XdDg9rTgcqJ9B8klIkxvT1R99z67NiQecyfqwn6rL?=
 =?us-ascii?Q?zLP/nXuJPJMOwMhXH/mB374SqpsFfEHEwYaDl62XZne42lSx39wRVieZa8Uf?=
 =?us-ascii?Q?co3523KBNsnYKEek7SVlKAOxTJBu6gt0I+gkTxSzZC30O9JO4vpi5ffhvkOI?=
 =?us-ascii?Q?mYEbCmTCl23H+IYntk60yghXCs9QkJe3gP+mOOFklGTgA5yKhrykfgUcqHCH?=
 =?us-ascii?Q?lT7NTcKwXn2raXpNn3O6oI689xigKdpECM6uu4LC5Icub4HytD+gOfqiyBzT?=
 =?us-ascii?Q?yDQIJAe/4PPds764h4DK31JGAjzjOYIg/rP5tsTOCiAOi+PqeeE3mQM2jKN2?=
 =?us-ascii?Q?WOIRmkWytVw06SwMoj4u21X+oMN8R4/w3zm0+rJ7CNsVED3mMBSq5NwsA5zB?=
 =?us-ascii?Q?lQFrUUJR6zbeyQqScZ9FSrEZWyyliGURCrMT0UMyd0gFFThIJkkEOwgQ1aRA?=
 =?us-ascii?Q?fyl0F00pOiWh/YnWW7FxYMPdOJePIGAYPx1/XPVG+3HJHPPygQrJ6RV3Gt7U?=
 =?us-ascii?Q?LnBWJz1sYNMehWo9Di4lGnsc91gAV6DkfmaFwf3mvx2PZ50ocWYJrzBZiU3R?=
 =?us-ascii?Q?99q1Sp7nJzl4BRx9R5JYfaDj5c+YpkUEjxEsACdqDko2knHtpKrY2mNHW59m?=
 =?us-ascii?Q?06NVoSVK89tKUxyo4XG48hezIl7uzaHNKk72F005KHrfJpRJdKITYoOYKynt?=
 =?us-ascii?Q?TfPMA929mxiNFgMrWwrDxdLzlybM+QaDuvjkm0Llf+DIe3PrE34Ra6lzsmTa?=
 =?us-ascii?Q?RY1qBkZIeNzqMwE8QzXipk8EVjNAzBWRdF2qAgg7Ar0XeP4d7UlJtwMma0s4?=
 =?us-ascii?Q?SuNkzWRfaz2vd9HaLAlKGIXdrKPF8sWfrRI2gfKdIp/WuWTbpo9tGBE+6IIf?=
 =?us-ascii?Q?VErDnYgXAD+3nGCi4paPHY4XUxr1fgZhCZCMEqyTBi0kw9Tn0x5pvaaxrGYx?=
 =?us-ascii?Q?DwrxyVANlXanB/hT8dHT+ubSR0vdUJNeQmXt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:30:16.7873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41940272-b893-4931-6e8f-08ddd9e76e5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777

Move struct cxl_dev_state (and associated structs) from cxlmem.h to
cxl.h. This is in preparation of adding a new CXL cache device type
that will also use cxl_dev_state.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cxl.h    | 114 +++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h | 113 ------------------------------------------
 2 files changed, 114 insertions(+), 113 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1de4fec5c8f4..751e5860423a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 #include <linux/node.h>
 #include <linux/io.h>
+#include <cxl/mailbox.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -696,6 +697,119 @@ struct cxl_ep {
 	struct cxl_port *next;
 };
 
+
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
+struct cxl_dev_ops {
+	int (*probe)(struct device *cxldev);
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
 /**
  * struct cxl_region_ref - track a region's interest in a port
  * @port: point in topology to install this reference
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5e0e551c9d6b..9c9d8a878785 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -34,10 +34,6 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-struct cxl_dev_ops {
-	int (*probe)(struct device *cxldev);
-};
-
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -113,17 +109,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
@@ -373,104 +358,6 @@ struct cxl_security_state {
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
2.34.1

