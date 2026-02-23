Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795F286D5E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856818; cv=fail; b=V/pSdMs78jSc7jnd8aOiCllNfEpQ4o6YPEV03S3DRLl/tIaMncWeBSa97V2Iw/OVHgUi7PLnRwV7Ow720gvcZ2vkMG4Kd5sv8b6OuIVgrwsWWCEPwzGVc7xpbm/gRrdmoK0dvlaCDoIJ9LCRdRn74JKTsCkvWRlxpDti72gIJK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856818; c=relaxed/simple;
	bh=tuxLO+ym9tiXV6WJ2P/Wmf4BsZ9kHmEkjm177veIdhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r96/27Glb0n9xurzdAMiH4sh/Vg5OA+3xSkECVcehD/aUk6IGqSs+iUvgjRaaEbD8Yog+BxCyZqEAxm1+pYB8Ob4xtlM9NOnkZxQZNOFIx0/q8ilylahz13AVgSpDboedAinBT0EOJmTa7ZMue6BokMsdeq56CvbJusU/Io3M8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rFbxZRp3; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rFbxZRp3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1yvlSy9+ZUDHCODBhW6mnx6UdAVAD7E7iSfhJvHSJoHu6QCxUAp7qTGrHusaM8pzyFG4qcgnaCOe3y7N50SBeBHUK3Kvj9oBp43EkVlBnaynC2SBOQ4V4ddYhaMYgg6IpH/YEkgpic4SL+GMNIxJlO/OWmqQ+5nZElKdASJRQN8D/bLP9IcWESw5NJWZoVxSl7h1GbGkwZpQSUpnex3dbzXqljwbq6TyoXyoKJhfGBCoKI2pYzxOyq8gF+hlYtqvVDBjni/PZ6/ij2Wem9DRFo0kN6AsmlBR1eeUNvOpsW0DGtzTznMN2e3fARIzQd44ox0STqNxSZ24VlYUdc8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/g+9IBVAJYOr57p/zYH4keERzeJjpyo/Fh3b6GOVPE=;
 b=euyYx7+owRiADvCbVlzJNhcam3ra/64wYKp6nxyRsfPzX2tX66lJ4kHAaRNDMwnKcfmVhczsbARbR8gppWSANVAk5P1gw9PA7c/AlbozzWwTrptv4tkDBAlcGoyjPCe5EDq40DmYJQ0ohyvCLhuKxKS0pVDWrdfsQFwBPoevZs27QupRcqhwyw/rNuVvBNqRompcKTuX858BSW2qvBIMiX0NCnnKT2M+4C8GCYVQFBvOTTQUoMLhQuxzPsCE0KN0ApGxUr7oOS5Q/VQ7tRONn5r/ccGp3hFBKcBwORVnh+JGqFOKsZRzvXTbDvbY2XA5Y/GU49Ziih9tWR3tIjLpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/g+9IBVAJYOr57p/zYH4keERzeJjpyo/Fh3b6GOVPE=;
 b=rFbxZRp34h3TOEbovCwuQ+XwpmW0h3x7Yieli0RJeeDZJWUKt4Lm/imwZ79FWyhrtPRMf3HZMK+upe+3qskdfKtvRkdQnwa654Y+R+wXYuAtEdZ8uMlN38usVP2aiWOADnvSxYg7pES3IQXAWfnM3ybAEJGCMtkGMeereLj3KMM=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by BN7PPF3C1137D8A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Mon, 23 Feb
 2026 14:26:46 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::b5) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 14:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 14:26:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 08:26:44 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Feb 2026 08:26:43 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 2/3] cxl: export internal structs for external Type2 drivers
Date: Mon, 23 Feb 2026 14:26:32 +0000
Message-ID: <20260223142633.2994082-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|BN7PPF3C1137D8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 4499b2c5-c7c3-47c2-3c2c-08de72e792e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SAyjXFMb0U9OP3sX8gIga7HkcdPqqe2SMfR30lNMj18jU0crjF42FEd0/cQA?=
 =?us-ascii?Q?/jHQU5uDIAgwi7H0/ZeTKG68dffazLyUPoxm2Ab6lGR2xzPt5C+kAkebmN3J?=
 =?us-ascii?Q?JoHBTV4JwkHV7PUTRT3Cv7UAG44hxIDYNwitVwjU083YlXnuFTudMJHqQNJS?=
 =?us-ascii?Q?LMi3yqx3eP2zwll69qlVV+n/M81piqIdBwdoqdMMXuxgUIZAeDCkW0Rodvlv?=
 =?us-ascii?Q?S+3DtM7hooXg0Q8kZVZYl9vizatBONGrsv5wsKThRR4IKR3hTlTuA8a+S2HG?=
 =?us-ascii?Q?1VapsM8VG4kC2srxVbqocFXEBW7jGLc3WrVvQm1oY8nfscqXxquOlghCitts?=
 =?us-ascii?Q?OAzKZkVwhOV1vs6TY1Ry7v+WuaBTzMkep6X9fR2CSg+p/oV2Locou2AtoVjj?=
 =?us-ascii?Q?T5fkFveJraQ7GMN0IalrBXau2GiWwuRkF61X7bbYLrCf+sxJyoPRowA1YfM+?=
 =?us-ascii?Q?PdY2o3nb4NS3GoA/DeCFb7+XDcHoocQR1kR+PH5eLHjBAeh42N5eGy0+vRo0?=
 =?us-ascii?Q?mItFyvDkz89NT0KGkI3y9Qlmc94k2MSKysRnsM7sPLBLE+a1vOPQCHyj/VEq?=
 =?us-ascii?Q?LVs9wpyw4aaCQFNElNTGtSDdO1nU22O18+K5kkgPgqzNp99xJ2k2NxbakP4F?=
 =?us-ascii?Q?vl0QwALge/03EEry8senXp8bbINGpZO4FAg+x+M8JGNzgNLf0A0Zu/a0CAno?=
 =?us-ascii?Q?PBwh9XH/iVVb0HTt9NFv9RcPBLyxng9Z2/yVtLTtljHeCOWoYC7RP/wvAhFq?=
 =?us-ascii?Q?2ABS6GM0KeHNZe5aja1QW6n+D6Ldc1GgVKY+jHSTSczI4jL2EY76iOlXjqPU?=
 =?us-ascii?Q?9nFpe/mELhx7xgJdUTjojWJiPMe+upPxUu7Y03PpdI6pWmmSIBgHHgaqFtAr?=
 =?us-ascii?Q?3jp2L/naEfv1zCCaTN2zr2/XIa7HYwnc6It8pIFGpodbVGuDJG546kvo+Oub?=
 =?us-ascii?Q?hifQKafPWm7TEEw8ojFFtTwrEwjP/+Xv9vvKR1EUpPaoLWkYzWhd5YwjUyyc?=
 =?us-ascii?Q?ze2Xme6fld3RXDFprE24uug82l4JImcLlvgnBX597tlLxNU+KVyhTfKUreg8?=
 =?us-ascii?Q?1ciB8bn+DRUVH+T8NBs4NUSL0gTqboCpRaQCCgZARJ2RtXlGz1wi97Tmjxaj?=
 =?us-ascii?Q?CG4G53nnz5xUyFZlPPkOthHTk8XpcpjdpcrtmC4RKUp9GkUXWUoeEARsef0q?=
 =?us-ascii?Q?kUginbCeEXe5/AENqDHC62pp5w04Bset5QSKjRqUv80yfN12pMooyD0o1LFw?=
 =?us-ascii?Q?CWc3OKFE3LUDVqaaYWHIkkGurU1BNeVZB7ot8TmyWGfioMS1C6wYl0f/AyHt?=
 =?us-ascii?Q?r0XRvK8PVMruSHllWsakRb6WhOUkFa9dMwVHVhgXKfGSHYEh/1OaaqcmTcRh?=
 =?us-ascii?Q?fO732OyzRwNKSW7+BQ8gin1nOg2+OzSRyrUIn8etuuuOL49bq5kKPE47Ze5g?=
 =?us-ascii?Q?m6HPU70Ik4MDD6wbtAIDLXmYdJK4R7btwYF+1QapGhRfwpdT5xIuoBh4NiES?=
 =?us-ascii?Q?/pnUbSmqnMvtoSvPxiBrFEF6u+mLqAPuWIAVutZqpJCQBLp8QWqAm2JxMwlD?=
 =?us-ascii?Q?YONHzbvrlHZc+F/R4NGCtjs8CGunCcfmYqabZoDs3iGTuGEsAqRzFMNBCuWY?=
 =?us-ascii?Q?39f/ei0xHP3zcr2oKqda0/fYUaHmAbQCJgbTgxBlzudsKE6jrrYUL2QVxMD+?=
 =?us-ascii?Q?khiYpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZpY1lOyzK7FabzX91qE6uJoLNlirXi6C5FWeyV+ZeDvB/RIFc/vqqs99amsuWYdsFLBmHiELmZcgpJ04I6iT58ayxETHXhJ8MJC/GaSpHpdZhsJKNbkOvwhgNztyarATqpxldDuMSP4NK8ozWC89Dfe6x9GvOXRuaAnnb0izvFpcWmD7YFe9YWlhavgGFluiXHh+ABPzc+9dCqsQqMEHp2QI6T+yX6Nq8ib8lDxo/P//X9FoUV6RXIFtGkEB04d0hwb1D8UQUKLF8w58wWCBrsH4Ak/z3aqiO4b7/ouAFe9g1LXM0macWFqSkuWRSnFmt8MuFeeGAlLBr89pWWeQhuO4VPa78djtq6jarvsLfUJ1KeUHvhTt+uPRL+WBxwzT8+HGnxn7ZE6P+RT18Lt2wsXvCnnCx867A7kaasXqPefZBwMTtc/ZkN1zFcM7w94r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:26:45.9289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4499b2c5-c7c3-47c2-3c2c-08de72e792e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF3C1137D8A

From: Alejandro Lucero <alucerop@amd.com>

In preparation for type2 support, move structs and functions needed by
external type2 drivers. Differentiate between public and private data to
be preserved by type2 drivers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/cxl.h    |  97 +------------------
 drivers/cxl/cxlmem.h | 114 ----------------------
 include/cxl/cxl.h    | 226 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+), 210 deletions(-)
 create mode 100644 include/cxl/cxl.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 04c673e7cdb0..0d350b69f1c8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -12,6 +12,7 @@
 #include <linux/node.h>
 #include <linux/io.h>
 #include <linux/range.h>
+#include <cxl/cxl.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -201,97 +202,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
-/*
- * Using struct_group() allows for per register-block-type helper routines,
- * without requiring block-type agnostic code to include the prefix.
- */
-struct cxl_regs {
-	/*
-	 * Common set of CXL Component register block base pointers
-	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
-	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
-	 */
-	struct_group_tagged(cxl_component_regs, component,
-		void __iomem *hdm_decoder;
-		void __iomem *ras;
-	);
-	/*
-	 * Common set of CXL Device register block base pointers
-	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
-	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
-	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
-	 */
-	struct_group_tagged(cxl_device_regs, device_regs,
-		void __iomem *status, *mbox, *memdev;
-	);
-
-	struct_group_tagged(cxl_pmu_regs, pmu_regs,
-		void __iomem *pmu;
-	);
-
-	/*
-	 * RCH downstream port specific RAS register
-	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
-	 */
-	struct_group_tagged(cxl_rch_regs, rch_regs,
-		void __iomem *dport_aer;
-	);
-
-	/*
-	 * RCD upstream port specific PCIe cap register
-	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
-	 */
-	struct_group_tagged(cxl_rcd_regs, rcd_regs,
-		void __iomem *rcd_pcie_cap;
-	);
-};
-
-struct cxl_reg_map {
-	bool valid;
-	int id;
-	unsigned long offset;
-	unsigned long size;
-};
-
-struct cxl_component_reg_map {
-	struct cxl_reg_map hdm_decoder;
-	struct cxl_reg_map ras;
-};
-
-struct cxl_device_reg_map {
-	struct cxl_reg_map status;
-	struct cxl_reg_map mbox;
-	struct cxl_reg_map memdev;
-};
-
-struct cxl_pmu_reg_map {
-	struct cxl_reg_map pmu;
-};
-
-/**
- * struct cxl_register_map - DVSEC harvested register block mapping parameters
- * @host: device for devm operations and logging
- * @base: virtual base of the register-block-BAR + @block_offset
- * @resource: physical resource base of the register block
- * @max_size: maximum mapping size to perform register search
- * @reg_type: see enum cxl_regloc_type
- * @component_map: cxl_reg_map for component registers
- * @device_map: cxl_reg_maps for device registers
- * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
- */
-struct cxl_register_map {
-	struct device *host;
-	void __iomem *base;
-	resource_size_t resource;
-	resource_size_t max_size;
-	u8 reg_type;
-	union {
-		struct cxl_component_reg_map component_map;
-		struct cxl_device_reg_map device_map;
-		struct cxl_pmu_reg_map pmu_map;
-	};
-};
-
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
@@ -497,11 +407,6 @@ struct cxl_region_params {
 	resource_size_t cache_size;
 };
 
-enum cxl_partition_mode {
-	CXL_PARTMODE_RAM,
-	CXL_PARTMODE_PMEM,
-};
-
 /*
  * Indicate whether this region has been assembled by autodetection or
  * userspace assembly. Prevent endpoint decoders outside of automatic
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9daf4bc42692..281546de426e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -113,8 +113,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
 
-#define CXL_NR_PARTITIONS_MAX 2
-
 struct cxl_dpa_info {
 	u64 size;
 	struct cxl_dpa_part_info {
@@ -373,87 +371,6 @@ struct cxl_security_state {
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
- * @regs: Class device "Device" registers
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
-	struct cxl_device_regs regs;
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
 static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
 {
 	/*
@@ -523,37 +440,6 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
 
-struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
-						 enum cxl_devtype type,
-						 u64 serial, u16 dvsec,
-						 size_t size, bool has_mbox);
-
-/**
- * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
- * driver specific struct.
- *
- * @parent: device behind the request
- * @type: CXL device type
- * @serial: device identification
- * @dvsec: dvsec capability offset
- * @drv_struct: driver struct embedding a cxl_dev_state struct
- * @member: drv_struct member as cxl_dev_state
- * @mbox: true if mailbox supported
- *
- * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
- * struct initialized.
- *
- * Introduced for Type2 driver support.
- */
-#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
-	({										\
-		static_assert(__same_type(struct cxl_dev_state,				\
-			      ((drv_struct *)NULL)->member));				\
-		static_assert(offsetof(drv_struct, member) == 0);			\
-		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
-						      sizeof(drv_struct), mbox);	\
-	})
-
 enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
new file mode 100644
index 000000000000..11f76d61c9f1
--- /dev/null
+++ b/include/cxl/cxl.h
@@ -0,0 +1,226 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 Intel Corporation. */
+/* Copyright(c) 2026 Advanced Micro Devices, Inc. */
+
+#ifndef __CXL_CXL_H__
+#define __CXL_CXL_H__
+
+#include <linux/node.h>
+#include <linux/ioport.h>
+#include <cxl/mailbox.h>
+
+/**
+ * enum cxl_devtype - delineate type-2 from a generic type-3 device
+ * @CXL_DEVTYPE_DEVMEM: Vendor specific CXL Type-2 device implementing HDM-D or
+ *			 HDM-DB, no requirement that this device implements a
+ *			 mailbox, or other memory-device-standard manageability
+ *			 flows.
+ * @CXL_DEVTYPE_CLASSMEM: Common class definition of a CXL Type-3 device with
+ *			   HDM-H and class-mandatory memory device registers
+ */
+enum cxl_devtype {
+	CXL_DEVTYPE_DEVMEM,
+	CXL_DEVTYPE_CLASSMEM,
+};
+
+struct device;
+
+/*
+ * Using struct_group() allows for per register-block-type helper routines,
+ * without requiring block-type agnostic code to include the prefix.
+ */
+struct cxl_regs {
+	/*
+	 * Common set of CXL Component register block base pointers
+	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
+	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
+	 */
+	struct_group_tagged(cxl_component_regs, component,
+		void __iomem *hdm_decoder;
+		void __iomem *ras;
+	);
+	/*
+	 * Common set of CXL Device register block base pointers
+	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
+	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
+	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
+	 */
+	struct_group_tagged(cxl_device_regs, device_regs,
+		void __iomem *status, *mbox, *memdev;
+	);
+
+	struct_group_tagged(cxl_pmu_regs, pmu_regs,
+		void __iomem *pmu;
+	);
+
+	/*
+	 * RCH downstream port specific RAS register
+	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rch_regs, rch_regs,
+		void __iomem *dport_aer;
+	);
+
+	/*
+	 * RCD upstream port specific PCIe cap register
+	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
+	 */
+	struct_group_tagged(cxl_rcd_regs, rcd_regs,
+		void __iomem *rcd_pcie_cap;
+	);
+};
+
+struct cxl_reg_map {
+	bool valid;
+	int id;
+	unsigned long offset;
+	unsigned long size;
+};
+
+struct cxl_component_reg_map {
+	struct cxl_reg_map hdm_decoder;
+	struct cxl_reg_map ras;
+};
+
+struct cxl_device_reg_map {
+	struct cxl_reg_map status;
+	struct cxl_reg_map mbox;
+	struct cxl_reg_map memdev;
+};
+
+struct cxl_pmu_reg_map {
+	struct cxl_reg_map pmu;
+};
+
+/**
+ * struct cxl_register_map - DVSEC harvested register block mapping parameters
+ * @host: device for devm operations and logging
+ * @base: virtual base of the register-block-BAR + @block_offset
+ * @resource: physical resource base of the register block
+ * @max_size: maximum mapping size to perform register search
+ * @reg_type: see enum cxl_regloc_type
+ * @component_map: cxl_reg_map for component registers
+ * @device_map: cxl_reg_maps for device registers
+ * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
+ */
+struct cxl_register_map {
+	struct device *host;
+	void __iomem *base;
+	resource_size_t resource;
+	resource_size_t max_size;
+	u8 reg_type;
+	union {
+		struct cxl_component_reg_map component_map;
+		struct cxl_device_reg_map device_map;
+		struct cxl_pmu_reg_map pmu_map;
+	};
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
+enum cxl_partition_mode {
+	CXL_PARTMODE_RAM,
+	CXL_PARTMODE_PMEM,
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
+	/* public for Type2 drivers */
+	struct device *dev;
+	struct cxl_memdev *cxlmd;
+
+	/* private for Type2 drivers */
+	struct cxl_register_map reg_map;
+	struct cxl_device_regs regs;
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
+struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
+						 enum cxl_devtype type,
+						 u64 serial, u16 dvsec,
+						 size_t size, bool has_mbox);
+
+/**
+ * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
+ * driver specific struct.
+ *
+ * @parent: device behind the request
+ * @type: CXL device type
+ * @serial: device identification
+ * @dvsec: dvsec capability offset
+ * @drv_struct: driver struct embedding a cxl_dev_state struct
+ * @member: drv_struct member as cxl_dev_state
+ * @mbox: true if mailbox supported
+ *
+ * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
+ * struct initialized.
+ *
+ * Introduced for Type2 driver support.
+ */
+#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
+	({										\
+		static_assert(__same_type(struct cxl_dev_state,				\
+			      ((drv_struct *)NULL)->member));				\
+		static_assert(offsetof(drv_struct, member) == 0);			\
+		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
+						      sizeof(drv_struct), mbox);	\
+	})
+#endif /* __CXL_CXL_H__ */
-- 
2.34.1

