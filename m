Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E973A4F3E;
	Wed, 14 Jan 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409395; cv=fail; b=NGUBY4MHzvrFHkIN12aSnWLS5qzbHSYOxDg4x4c46EfKjZpjHh5jAWa2Gngk/eDzYZi27NH+GSqdSNyxS6wpJIUBUACwnaFlLNBN6qpSiNBV0+VWpR2d8HNfQ4ngJPN2Qm9ZWLPe6FLOBEUZsTSHVeZDH5RZ+29S6Q4kJK1qKH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409395; c=relaxed/simple;
	bh=rVm1FkgiqRxjxALgWdbQdDvlDRSLYmLzkrgDb0JJhX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+3bryoZGJx867WzYesWBI7rirQVC+YNj22gYjg25XqtyrYucijB7CqlKZXP8anFgis6ApZOP28mHWESlvXaom8GeP+ufNP0NX4HWYOdxhgly94lw7d0I/8ZGedFW6SqhqnKDh9gSw0LR+fp4K3VEUQ8fa1fNr53zOLwQfphenc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0YrXnZ6o; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0YrXnZ6o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAPaGe9LDrt/J/aMEW+xQ3h86xoMhpNw/aI8hPLdQVe9ej3mKihXI6EmAT6JtF7oKBbm49sMMid/K8oWORsYxZz2bQNyhkTofESG9L0WYcSqBu+8N73X8g+R49qpl7p8vY3XbzBtZj6GmIZDzKoseyk4CjXjxMYsrSLEaB7rf8Exm4ANKnKoRazlTxyq7JAYF4Wojx2pkA3Jjx8g6AsvBug0SmfijUhcFDh0hYKPyXRFUBTuC3Kc8X/+ad4UwuTM2V3Rb+c+6O4pVnMYiGGoeZsj0G5dUm/TiU9gWe3s+Fw68/OXe/vlXcKHep9WdHsBr8b0HJRlalPEnSZZ0YkGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whm/9TVz57nKr7U2yw4m8ZqDHTFTheoMGwd01tPe3qo=;
 b=e1JrXJUJRjx5QA7Y3TB0J7isKsw6hvxndEmbm1ufcjHOsDAQXjwkWFgHgoh59eHk3I2oOwPvobGX6l5F/G0f6kZNc9ecnkbSkuKsL97E7Ge031cQw0kTmYBcjRV+80bjiSulEEhdGNHS3hugTiI5QQDRgd8jAaf8DRGAWcyYYBC2unPajT1TiriSGzVxZOwPEUqAI4Rs6DZe9mBz4kEXG2ayGIKdzw1rCtdirwCkNFuGsW4QUYSLFx7a0XASTddmibdi067sUC/AECshSeBLprsHvSfN0nFxTwHsmf4leDNhSeKoLMn1X2LzJXrVm7leiOc6V4mi6nje0c8dRO+G/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whm/9TVz57nKr7U2yw4m8ZqDHTFTheoMGwd01tPe3qo=;
 b=0YrXnZ6oTETtFO1LokhlRNN/Sg5gK/QWJp19f8iVY1t2lWyqpyJeMnkumb55k6sv2Jhty0sm9geDaoU/Q3WaeYXO1EYBdqNR2xJp/dGTWzKgvobmrAz9tlb7f/fyZPlzgdESwPJic21acKW5yChdgJpc5K/QM0iOmEhwZmBVaz0=
Received: from DS7PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:3b5::27)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:49:48 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::df) by DS7PR03CA0052.outlook.office365.com
 (2603:10b6:5:3b5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 16:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:48 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:44 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 13/13] cxl: Disable HPA/SPA translation handlers for Normalized Addressing
Date: Wed, 14 Jan 2026 17:48:29 +0100
Message-ID: <20260114164837.1076338-14-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aedc4a3-65f3-42dc-02d8-08de538cedba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L8H/ZHIrgVZqaj7TlqieDbaBvTxf4E5hEcN5m+4uaBSLB2qR0LqhddmXgdBF?=
 =?us-ascii?Q?uJ1SWOWOcHijOr3s4MEcoHbOfJsDhthd3aS9wj1vxv082uDo26IXYCVib6VQ?=
 =?us-ascii?Q?0x+iCGG0baGychl5RNodaFbLGnQUIEPj1X+cDYZmk89w7RvF/hr7Rs04ZUC8?=
 =?us-ascii?Q?r4tGf9sVOJjNYxhxFdGDeghOrG0FLDi3UkwazpjU3V6lgm4lqYmpUlbPfD8t?=
 =?us-ascii?Q?C4xOBPVxo+UQuGJDnO19yQwaWB7Rgvdc08evkB0GNsHT8PluyUsQ/rERZeYY?=
 =?us-ascii?Q?O7u1hBnsDQuulhHrvR1KEKP5SDfLHEvBPh6tHm4EWN3eHknBUFPTiU8IeVSw?=
 =?us-ascii?Q?YHupFvf333CuSP84cImP2rS9oJNCMENWoSUiifC3qfQzBOa67BcsJkY1Yxph?=
 =?us-ascii?Q?kYH2fHWo4hBf4QxKTAkU+D8ZGo/KeVzYzjZaV86+EXajU2Leyju0bJSvUaho?=
 =?us-ascii?Q?B0kQ3bMim8+YakWKgmcYs1ggjsgiFRn+EB2HD+GyJyC36fCCAc3Cp1CeXqzW?=
 =?us-ascii?Q?tgkLxnxCsFm3iOxDKFNQJ/1VbLpO7LqWAMC9om8qJiRRrR0ayjGjS8nKWCfT?=
 =?us-ascii?Q?86VDtx8kMKYsXayHw5bAx/3t0Om4Bu5BPzdntrAs0b0g9q4sZGqefozhv5Zu?=
 =?us-ascii?Q?+1M82fH41rq3hPocp+GMRa6jHynVw9S88daITRuZdKLP885dd4bpvTKXgr52?=
 =?us-ascii?Q?29UEn/p5zd34bm+ufT+KA57JMHnRR0mlE97B8vjzf8Dssm8+8HnYTvYzcX5h?=
 =?us-ascii?Q?tZi7jhZg7iu95N1Xn5u7jTNvOFlvUcz1qItXV8WdKZ1t1D/WkWo/RAycWA58?=
 =?us-ascii?Q?9Z1FC5yFALYwPduKT5QHKZAUZiNngXObqLLrnP5MKy1R3CMYpza6S4krj6Cz?=
 =?us-ascii?Q?xH61kImIzZQ9VAQfqS+DJsejyag55xlV1tiHqrldF0qz+PcX3rbA/iNhmKGT?=
 =?us-ascii?Q?BdeyzMQfJ4Piw8MwgVYs//kj7mTCNqnRVUYv/Pf0QoSpuy4oCI4W6WSrsBXd?=
 =?us-ascii?Q?arlAI4qwDKB+wBn82ot+v0B/4S/89Ist5aINlwTRtxY60yfx3zQWeJVLqRmg?=
 =?us-ascii?Q?fpjUGIa03fL4WjYlZlKyuORAF+6WyZzXMBe8KlpNByAmVM6ZWPWdbIfldBcA?=
 =?us-ascii?Q?tjBudjPFf6aWb90+bwDPbwe4Vtj31WQXfbfNGX0WKHRp1ZCIZ8c0leuxxT3r?=
 =?us-ascii?Q?2eaq415zgE3Hd18KYDnDcCC8zWFnRhIiCRQnzA0ml9wgk0WAvZefRRgU1KdZ?=
 =?us-ascii?Q?I/h/oOulbhhi8yJzRF5G/uzASwbTlUSJxMCeJpEGO2292AY/u6nyGdN0LgZ8?=
 =?us-ascii?Q?Xf3vVJZqY52e6UeIqk+3W+8YawxSfSq8/hkFVoi73RReTL4aD3xQvCkmylYp?=
 =?us-ascii?Q?SPTFoMJo/UEwdXYvHMsJRaQ+4k0F74kXJdjJ6ke0qgzDStz6oXnw/akgijUE?=
 =?us-ascii?Q?zRzbthBdP0F+ZIRy17H6glqODvgkE2PiC02RdwGd88YP8yuPTm0NIVyc27b/?=
 =?us-ascii?Q?hXSdcFWkzIWmBCTCCr4TOWQUcOOaDAGNZcbx7i8Z16fMBWAPbn67sBK2juzJ?=
 =?us-ascii?Q?16dK77f0VoC2FVrN8Jzg8VmfKYfv8hLlIAVuSMUh7jOiKaKJ7A+cCMA6/MOU?=
 =?us-ascii?Q?ZhwXlrp3boFjVt4uFmI3rrZscCEDDAC1AZ+lRiRHvgd7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:48.1215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aedc4a3-65f3-42dc-02d8-08de538cedba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

The root decoder provides the callbacks hpa_to_spa and spa_to_hpa to
perform Host Physical Address (HPA) and System Physical Address
translations, respectively. The callbacks are required to convert
addresses when HPA != SPA. XOR interleaving depends on this mechanism,
and the necessary handlers are implemented.

The translation handlers are used for poison injection
(trace_cxl_poison, cxl_poison_inject_fops) and error handling
(cxl_event_trace_record).

In AMD Zen5 systems with Normalized Addressing, endpoint addresses are
not SPAs, and translation handlers are required for these features to
function correctly.

Now, as ACPI PRM translation could be expensive in tracing or error
handling code paths, do not yet enable translations to avoid its
intensive use. Instead, disable those features which are used only for
debugging and enhanced logging.

Introduce the flag CXL_REGION_F_NORM_ADDR that indicates Normalized
Addressing for a region and use it to disable poison injection and DPA
to HPA conversion.

Note: Dropped unused CXL_DECODER_F_MASK macro.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/atl.c    |  3 +++
 drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++--------
 drivers/cxl/cxl.h         |  9 ++++++++-
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index 09d0ea1792d9..310668786189 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -169,8 +169,11 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
 	 * decoders in the BIOS would prevent a capable kernel (or
 	 * other operating systems) from shutting down auto-generated
 	 * regions and managing resources dynamically.
+	 *
+	 * Indicate that Normalized Addressing is enabled.
 	 */
 	cxld->flags |= CXL_DECODER_F_LOCK;
+	cxld->flags |= CXL_DECODER_F_NORMALIZED_ADDRESSING;
 
 	ctx->hpa_range = hpa_range;
 	ctx->interleave_ways = ways;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 80cd77f0842e..8e92b491d686 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1097,14 +1097,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 	return 0;
 }
 
-static void cxl_region_set_lock(struct cxl_region *cxlr,
-				struct cxl_decoder *cxld)
+static void cxl_region_setup_flags(struct cxl_region *cxlr,
+				   struct cxl_decoder *cxld)
 {
-	if (!test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
-		return;
+	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
+		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
+		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
+	}
 
-	set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
-	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
+	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
+		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
 }
 
 /**
@@ -1218,7 +1220,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		}
 	}
 
-	cxl_region_set_lock(cxlr, cxld);
+	cxl_region_setup_flags(cxlr, cxld);
 
 	rc = cxl_rr_ep_add(cxl_rr, cxled);
 	if (rc) {
@@ -2493,7 +2495,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;
-	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
+	cxl_region_setup_flags(cxlr, &cxlrd->cxlsd.cxld);
 
 	return cxlr;
 }
@@ -3132,6 +3134,13 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	u8 eiw = 0;
 	int pos;
 
+	/*
+	 * Conversion between SPA and DPA is not supported in
+	 * Normalized Address mode.
+	 */
+	if (test_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags))
+		return ULLONG_MAX;
+
 	for (int i = 0; i < p->nr_targets; i++) {
 		if (cxlmd == cxled_to_memdev(p->targets[i])) {
 			cxled = p->targets[i];
@@ -3922,6 +3931,14 @@ static int cxl_region_setup_poison(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	struct dentry *dentry;
 
+	/*
+	 * Do not enable poison injection in Normalized Address mode.
+	 * Conversion between SPA and DPA is required for this, but it is
+	 * not supported in this mode.
+	 */
+	if (test_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags))
+		return 0;
+
 	/* Create poison attributes if all memdevs support the capabilities */
 	for (int i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 20b0fd43fa7b..de30a87600be 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -332,7 +332,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_TYPE3 BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
-#define CXL_DECODER_F_MASK  GENMASK(5, 0)
+#define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -525,6 +525,13 @@ enum cxl_partition_mode {
  */
 #define CXL_REGION_F_LOCK 2
 
+/*
+ * Indicate Normalized Addressing. Use it to disable SPA conversion if
+ * HPA != SPA and an address translation callback handler does not
+ * exist. Flag is needed by AMD Zen5 platforms.
+ */
+#define CXL_REGION_F_NORMALIZED_ADDRESSING 3
+
 /**
  * struct cxl_region - CXL region
  * @dev: This region's device
-- 
2.47.3

