Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07669269AE5;
	Tue, 18 Feb 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885113; cv=fail; b=Es3DzGZaW7zxW7Cu+Xdyf40REcVSeQviQGTja0DRjNRbGoPxbKCHGPal/8BgQ6AEFiSc2ccKAfE+vzoed+1y69ri57XXGiWqJE7xumRbeEw9ORarXDAiWEZkg1B5nINL3NIJGz9IC+Bhsj268qUyHeCSg6mOhdTUHljsOxLGQ4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885113; c=relaxed/simple;
	bh=ok2cuMGBEC/QhbJb7/0tOIctVxfWuLNz1LJyGV5kUyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ir3+bNcg87Yeh4GNDIqlxW5x0GRFMNRYaupQg4epH/lTRYBXk6WcSRLQEzNOccpV81pJmQSysKCa5OX0rPBD+5D91F2BRhrBeXz27aqiB1/Ft00FyHgwcLeaUOGEQoh2WAdeZ7/UGZ1djhsPOIaUnL5UyNcOLyhMKuJdCA2rFi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5bHxbJuP; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5bHxbJuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvcyeC4OVUISok7ENW6X2NQnm7CFzvq/bS9UXwc0cNORItweke9y43URQfnIHlBDlBicrjFXcPvk+/FyZ8Sd5onREd2zTdTpchBqYGdGiX2L5/PfJPD5YgdO+mqYQMbk78FDRv/j9LtD+tDtVVW+/Fv3m6mXNeYbj44M3nwlpm4mbbTUZPFPwPO7kByUxuMgHgDspiYZ5cV2ilNhktaDqTrKkr2IHiX+7ZPh4ejcdUAHZCdBHF4U8piDjZb1mQuTG7y6+YM2Ti33RL4ZZvBzHs2mkY/K+WCSPSYvxvfpfu99LF5RoZ/+oWBb1T++RgSw9IBtlx2XJtl0aPrV4OBODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJEacDxdfnPhaakE52v4IMjph04nIaYEpH10KSsoOjs=;
 b=CgErhE2KvxmawUTbuji7kZ8vandwE8hvvHNsgXyCaRwciNUGozV/4JRa1jlx23QZTBh58SfwdBv34szEQ/xDlM4Dpepf3E2/HwTxvT+jB+ZmKeR7Ib3q09YCKrjsCxL6URmY9jNJTzMXGr4Xp/uURvinUJxrvX1/uewh7katKmzcTMuRz8kqIIwZGp1FA0bC1mDJCaCjl7Ov1UlF0GUDlCjwQ4zwDqtnIMEzELwiIZLbORhESPI5EYjw2MpQ2rgzagwaQV1WBeO3XId5pdCqZOediX7m7zYq0+0HYyqRhN2BhyhXAcExISxBKhmcoZoisUvf7vr7X61jyRO9cvTGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJEacDxdfnPhaakE52v4IMjph04nIaYEpH10KSsoOjs=;
 b=5bHxbJuPLF0/aVqcCnJjhy+ZRLo50sFVUELLxZcpulcsqODBI0lzfPWhTgctHjzuoVEDJUhEmAcYNHuS1jGKEFFK63TMp2O5oyOlfl42LsuNezGQwIDvpuiqiuX1gJRDp3YPgQ+/raq74hLoXOfXLrwMHnMn1NXqDqDYGwR5b50=
Received: from BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::24)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 13:25:08 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::6d) by BL1P221CA0009.outlook.office365.com
 (2603:10b6:208:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 13:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:25:08 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:25:05 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 10/15] cxl/region: Use root decoders interleaving parameters to create a region
Date: Tue, 18 Feb 2025 14:23:51 +0100
Message-ID: <20250218132356.1809075-11-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: f78bab60-0709-4954-fa3f-08dd501faa0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4EsrNdpZsEH3rJCf8A1PMwPMrWtokBN+V9T6c0y+7oge7CTN30Y0HdQuZw2p?=
 =?us-ascii?Q?K2uEe3jqwfLVy99pbhYrjZLxnZarDchtUERi1NWHkUeiCRhsCbsBlel1rrD/?=
 =?us-ascii?Q?oyLKmmVFXzeIIzvlEDD4TbAcjm+bIg7PgP1a+NDR7BdwKOT/bHU1ayXMpSRc?=
 =?us-ascii?Q?1HpUIWVm8VDJm6YjZP2A7zQ9lHdrZZCSm41ndv+MDe07reqTeqUmCMIpAOHe?=
 =?us-ascii?Q?LppQTIo6wXKlzYFEpHmiBxH7PKFKQTButCY3dh7bslAddBS/f7ihbOi49TMl?=
 =?us-ascii?Q?p43MR2sJ3BR+ARcILppWL9IlxBEkBtsA8i09ki3yO8OcomYeaAfZdWDvoRsY?=
 =?us-ascii?Q?HGzK8pPnCMSHz+2r7dhJle38ZsdeYEqdMWRZtwDcuq3so6HwPdXzQkEglkkW?=
 =?us-ascii?Q?zE8B+5EHx2FlVkxnEGWH4tvwzTFzlktvwIq2p6L6pE7Fp9qpNUHfAguaZRN/?=
 =?us-ascii?Q?nbVVeOHrlNm8Vb0twJ+gbsTNc5k50Fjzbm1t7/zF2+fd8DWr/yPYgHmXJuZZ?=
 =?us-ascii?Q?TpPF+i702fkFzR5sga6zXDof9va74BWak4o/cfGFScWUio8xngkEZ4hnDBTW?=
 =?us-ascii?Q?lU7Lu41mX4AVlqdMpqNvAhK4XvJIDSwwwLeZKDq5WpssIyIlLpZ1mRQsn3sd?=
 =?us-ascii?Q?lDryOLInNePnz5ccfeyr84oDk+oWBqyu6MOlK9ZwOzs/rQMG/tixr1rYtKZC?=
 =?us-ascii?Q?bIO1w+TNIwHyZ2f7j5ZB5ElcHg4uFcbA2Xa3JzEnHhtPVYdnsBch5Hwy90YC?=
 =?us-ascii?Q?SrFF+1lSdwfmkLTSQGlKMBuwkoD1net3UZ5nWX1DWE98b/+c0oe6YPaKjxUb?=
 =?us-ascii?Q?FHrUxwbOR7ln4mU4+58z0lDsgIPEcHBRaXoC582ajEXKojoaJqLkHDQCKvlH?=
 =?us-ascii?Q?LfS9f/q0gygCE58vCeLqR4OsweHJOA0daJBqO0OBP8IGafJOmrj4bvuXeLAJ?=
 =?us-ascii?Q?BE8I45tyMJ2rIC/h5x5EDUPqT7AbHhnA30KLcjGAcA4Fy5Ltq7LV44Esg+v7?=
 =?us-ascii?Q?eXoE/qHuaBhFbHcuV89AYR3Ews9hwVc+s76C6dllIi0QPkSVccFFwyWhX/H+?=
 =?us-ascii?Q?Puottco9U0Vp/MTEMmrPPBwBm9ifkKWVTgN86VbiQNlP6WWqnc4sn4ItIlGp?=
 =?us-ascii?Q?DreuG88IkKp3zdQHAsScpnmLAJy3aQX+zxlj1IixtZOlyNCdI78cwBNiK/LE?=
 =?us-ascii?Q?/RZNlDj4a3c3nsfxPGjEu4GohGPZqagJXitszCU1quzD7Z2eGH3X/szV8tGW?=
 =?us-ascii?Q?qloS7nlvTv27LriZYPI6jqasYlEigFEI6/Naxg+27vrxjrTT+jsnaKUcSgor?=
 =?us-ascii?Q?Hj2j6PepCWNlr6ireLvqRoeYBRNO0XDkmPdWbdAS07dyYjL2fOLJjHeyzTva?=
 =?us-ascii?Q?OwMfZ0LzJOx6FwZW3OmBF6Te05VepWjeOi7H5FvRPEcYcJ3gPM+OjjDtQnEe?=
 =?us-ascii?Q?isNHpdWkFqUsXS9s2m5+TYdvuEzfgy/8HJl1QDcdDuUeorgLhBQllyos6oGX?=
 =?us-ascii?Q?dKhAZS7O2w//apc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:25:08.3260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78bab60-0709-4954-fa3f-08dd501faa0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741

Endpoints requiring address translation might not be aware of the
system's interleaving configuration. Instead, interleaving can be
configured on an upper memory domain (from an endpoint view) and thus
is not visible to the endpoint. For region creation this might cause
an invalid interleaving config that does not match the CFMWS entries.

Use the interleaving configuration of the root decoders to create a
region which bases on CFMWS entries. This always matches the system's
interleaving configuration and is independent of the underlying memory
topology.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 39 ++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e0434eee6df..3afcc9ca06ae 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1749,6 +1749,15 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 		}
 	}
 
+	if (p->interleave_ways != cxled->interleave_ways ||
+	    p->interleave_granularity != cxled->interleave_granularity ) {
+		dev_dbg(&cxlr->dev, "interleaving config mismatch with %s: ways: %d:%d granularity: %d:%d\n",
+			dev_name(&cxled->cxld.dev), p->interleave_ways,
+			cxled->interleave_ways, p->interleave_granularity,
+			cxled->interleave_granularity);
+		return -ENXIO;
+	}
+
 	return 0;
 }
 
@@ -1852,7 +1861,7 @@ static int match_switch_decoder_by_range(struct device *dev,
 }
 
 static int find_pos_and_ways(struct cxl_port *port, struct range *range,
-			     int *pos, int *ways)
+			     int *pos, int *ways, int *granularity)
 {
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
@@ -1873,6 +1882,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	}
 	cxlsd = to_cxl_switch_decoder(dev);
 	*ways = cxlsd->cxld.interleave_ways;
+	*granularity = cxlsd->cxld.interleave_granularity;
 
 	for (int i = 0; i < *ways; i++) {
 		if (cxlsd->target[i] == port->parent_dport) {
@@ -1896,6 +1906,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 struct cxl_interleave_context {
 	struct range *hpa_range;
 	int pos;
+	int interleave_ways;
+	int interleave_granularity;
 };
 
 /**
@@ -1914,13 +1926,17 @@ struct cxl_interleave_context {
  * the topology from the endpoint to the root decoder and iteratively
  * applying the function for each port.
  *
+ * Calculation of interleaving ways:
+ *
+ *    interleave_ways = interleave_ways * parent_ways;
+ *
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
 static int cxl_port_calc_interleave(struct cxl_port *port,
 				    struct cxl_interleave_context *ctx)
 {
-	int parent_ways = 0, parent_pos = 0;
+	int parent_ways = 0, parent_pos = 0, parent_granularity = 0;
 	int rc;
 
 	/*
@@ -1955,12 +1971,23 @@ static int cxl_port_calc_interleave(struct cxl_port *port,
 	if (is_cxl_root(port))
 		return 0;
 
-	rc = find_pos_and_ways(port, ctx->hpa_range, &parent_pos, &parent_ways);
+	rc = find_pos_and_ways(port, ctx->hpa_range, &parent_pos, &parent_ways,
+			&parent_granularity);
 	if (rc)
 		return rc;
 
 	ctx->pos = ctx->pos * parent_ways + parent_pos;
 
+	if (ctx->interleave_ways)
+		ctx->interleave_ways *= parent_ways;
+	else
+		ctx->interleave_ways = parent_ways;
+
+	if (ctx->interleave_granularity)
+		ctx->interleave_granularity *= ctx->interleave_ways;
+	else
+		ctx->interleave_granularity = parent_granularity;
+
 	return ctx->pos;
 }
 
@@ -3407,6 +3434,8 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
 	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
 	cxled->spa_range = hpa;
 	cxled->pos = ctx.pos;
+	cxled->interleave_ways = ctx.interleave_ways;
+	cxled->interleave_granularity = ctx.interleave_granularity;
 
 	return 0;
 }
@@ -3508,8 +3537,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = cxled->interleave_ways;
+	p->interleave_granularity = cxled->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7303aec1c31c..31afd71c3c8e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -399,6 +399,8 @@ struct cxl_endpoint_decoder {
 	enum cxl_decoder_state state;
 	int part;
 	int pos;
+	int interleave_ways;
+	int interleave_granularity;
 };
 
 /**
-- 
2.39.5

