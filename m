Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47220E6EC;
	Mon, 28 Apr 2025 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876627; cv=fail; b=NjxIlzrEovOX93FqKv3tbOZwjT69GZYRNNM34qkQhzLnAmLS62i53F4tQBhtscFmTWUavqXK5p+MnrhnhIFWh5ye0bJ2EY4ldqhTKh5rmzuEbbQ4LJJFprDUjBd5qhMdZEJJGjvAyjZE3Zn7fQrYy1mA/9/f3gsZvmvzDSZtGFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876627; c=relaxed/simple;
	bh=mDFpznVzBzDQzNqPWSgOcNvLpjxeBaRJ4TfUZO1RjWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sW77NxtLx4Qy9CxUJz6F9+ru/7zz/d3+A2x0MpkehqiuDQ0hpWl3u2wHG/gs7iqtrnieCFEgy/NIOQ5K8JzhE1Ua8G0lsyBuww6Ne3tY9PClWimGzqGcpnP3QMAcP/4ezkSDSz7UJ1N4A7hLmz+JSq6r/wwfpszbt+fT53o3SvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5B9/Zv3x; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5B9/Zv3x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAgVsh5CSoK6W66sVyj70idrYlPQl/s709f2NZf5N9Qvs09b4Emg6euji77QubIf7Q8N6YCRMIygMpP2CcHfwdbxKB1FrelNvCLvoj4qcIG58qB+nD3yP7n2xp/IJF2EyYXZ5fYrQkR3exQk12NwliVz2pSR5c8WGd4j6+idwyUbbkY7OyEdhk46z+rvyn6E7ETzETejD3AJK0BiDdnAhWljTkvq1pe+CcNI9iuSpZL6yEZqBR/TA1MlJWP+Y60Z6K/Oz1YdQlmmidpVIO79hvgA1XDGBC9SMuV/pugbEGpEK48CMxKQ+Yi+wwCtO5A5mG34rMjn9uS+tU/RbdVTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9HFHJdXdCK48NlV9Ve8ZdukWSk5cjystT5AHZY50zc=;
 b=xYdbOVXIi/SJLdOroJ4i6uCh4RKp03HJoAI/o+uLZuO+9nllcqLoa7cDex3wc4Y/ptibA4V3egBzY4vn5TcioZkADmxx+PQw4BcLKBPklzqlfA3xSLRwNHKVd+cEWF9z8CsgmEC0DCfY9h7Sg9mU63vOKBVpbpjMDGdzZDJwQUOI79xIkAanXI4x37wdI8F3MJP7FXOGhxRFqHdq34WFtwI12wSoxqm0DXfPbU2Y/gI7uumEI9vcb5ZK+Ewty5AVAfE2sqN6H6QmL86ynGEAlvGsJFkmLaqSDDYYC23iPM8ow2tVh3bYyxxUK8tIMT/KlTGTi22LHOkkY0UvrhKG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9HFHJdXdCK48NlV9Ve8ZdukWSk5cjystT5AHZY50zc=;
 b=5B9/Zv3xCaNaRsH0rWX1+zx8+TtTJdreysfCYOs9inCbUHKDCWJlnO5W9iR7yHcfNUk69I5fwXNGFcVjJJw5PVg7n/iXRsm/vze/Yw2FGnv4BgvByXLJx8KEHa++3ssMeyZcKWy2ouBf2DUmoXttYzh9OdSMHpKyJBHPGfHT8oM=
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by IA1PR12MB9530.namprd12.prod.outlook.com (2603:10b6:208:593::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 21:43:39 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::5) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:43:38 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:43:35 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 01/14] cxl: Remove else after return
Date: Mon, 28 Apr 2025 23:43:04 +0200
Message-ID: <20250428214318.1682212-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428214318.1682212-1-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA1PR12MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc846e9-776e-47b1-6d37-08dd869dbca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mdHh5pDk7s+eErSAp4NrBOR4naPiPiWFSILbPPtJ3jyZ3XV/zfTgXqpD4Lmb?=
 =?us-ascii?Q?ijEg4haweDQUaqtcNoB+kJAWGAAPmO9n3fPh02DB3eNZotbHvw1FlcdvtCHy?=
 =?us-ascii?Q?O9bAG3u6Bq/NiqR4JiL/vwLphtPjqJ5PxHoyw/Onlm9AcVLMJ2b4Y99wu9yO?=
 =?us-ascii?Q?LtBIGyVNbFluRKHpdlQEbvJTbCahTfrIn3ATkV6ziOS4mTePCLV6RZUy9o2h?=
 =?us-ascii?Q?q2DmUTMfyEOcK1e7/p1o5FHXyX67GL61DH5dhgYhcPTxE3N5jIpVURjeyU1p?=
 =?us-ascii?Q?w1GWAq2/uePEP5sl3FCmFodupr0DbzNl74VfPkL46lBpWe1kTUEJQ98VsreO?=
 =?us-ascii?Q?CE591efrrl67oAk1CIyTrk1V4CDzREnd4sz734yiObCD96Gh4W+OWho15UeL?=
 =?us-ascii?Q?Vfa+ylP8cAroCy/CqZXtIV64OutO9JM+zy53Dxj/zsh84b58WrtZd6WQeAEZ?=
 =?us-ascii?Q?GgDS5JNskt3Gw3H7oFDxLfH4R29XwJgr3hnR9XfJdKLoIsjVUA0ODxwpgZ9K?=
 =?us-ascii?Q?Sa1/BkCZgj3I7AIPNUFL3D/v9g9/cNZ8RcdCHTFWZhi759NTwcz/gu6EZADs?=
 =?us-ascii?Q?uzEwUL3VH5S2dShlRLRMvGq5OKF06b2UE0BCJx4Wi61cSpzi9DBakgfuQy3v?=
 =?us-ascii?Q?OaG1ON9amJ4a74c/o88vZL17RfPZLiRy3BxGgA27mb/aRPQXmkKUpFDWWjLl?=
 =?us-ascii?Q?4P2cDYOL4ZDEx+ArgtO+8ZBsZD+3O4O+fAopzC19FcMMmNSSrplIbrnV5gI9?=
 =?us-ascii?Q?QMpT1GPfVjLySzkAjRDFc3s0z1vIEsfqhOERjhy+al1PuixujxCAMTGmDDpj?=
 =?us-ascii?Q?FlUA0EWaYSdq0wMIkyU8tWFiObaeVzKvYrX7gbU+FWlQNC/eikTt6m+UDj8B?=
 =?us-ascii?Q?mAsjHjpBnAfLjJFzyowbazMJVlbm0phn/0TWsJSMqf6CusvEpvNSFaDUhhsK?=
 =?us-ascii?Q?TgTPDFx2+gn7Wdf8ss2sb0wHrWawCerjXDEV8oNtNG+3vNuT2RVZQyYAo6ls?=
 =?us-ascii?Q?lVZWky8QWcrFaXR/5QH8Kwf6BzI8BifdUSMXP4xNfj9JXjaS/cexIlAssLDk?=
 =?us-ascii?Q?Fmnlph7ORiaCbzezuCGpBKzemoWvAsGmEPiGQua40kP6EMgOspoSuh4NwL5q?=
 =?us-ascii?Q?/xjzpTaUN7Jv2QucJTJVAsJJmj2PGX5ttLhkEt1wbO+kQThcNT0nLhIkatx3?=
 =?us-ascii?Q?F+DNy89jNJMyMeiX+CGJfeehm9d25HQKeBZpUjh8xE2tqJRkEfUzdd32BCF6?=
 =?us-ascii?Q?DefRbblJDc6VTkNylqoiXH7PypKGVVmM1IOJOvir9Xuh9Xgklhl45n8E7wVH?=
 =?us-ascii?Q?L8N38Is1sKcEd42ImOYMBvhjtgPjiVJe21KbBcPKUi/+r83G8CFS2jl+V2Il?=
 =?us-ascii?Q?2WeebBnB5p9eW2qBxvoZKaxpZHj97p5J74kEi2jzpCqIwYJXqJVfhLvQuuwS?=
 =?us-ascii?Q?EWE+zWQmBnzYSSTfGrTVs1zTiziGZCVCd9zdzXOjkLOBk+yqqOroz+YiXKU4?=
 =?us-ascii?Q?4Ayuam37FPe4nQIQj2NmYM+gpq9PgEu2VXUb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:43:38.7819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc846e9-776e-47b1-6d37-08dd869dbca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9530

Remove unnecessary 'else' after return. Improves readability of code.
It is easier to place comments. Check and fix all occurrences under
drivers/cxl/.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/cdat.c   | 2 +-
 drivers/cxl/core/pci.c    | 3 ++-
 drivers/cxl/core/region.c | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index edb4f41eeacc..0ccef2f2a26a 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -28,7 +28,7 @@ static u32 cdat_normalize(u16 entry, u64 base, u8 type)
 	 */
 	if (entry == 0xffff || !entry)
 		return 0;
-	else if (base > (UINT_MAX / (entry)))
+	if (base > (UINT_MAX / (entry)))
 		return 0;
 
 	/*
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 96fecb799cbc..33c3bdd35b24 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -415,7 +415,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 */
 	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
-	else if (!hdm)
+
+	if (!hdm)
 		return -ENODEV;
 
 	root = to_cxl_port(port->dev.parent);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 80caaf14d08a..6bbe04a532e2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1940,7 +1940,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_dbg(&cxlr->dev, "region already active\n");
 		return -EBUSY;
-	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
+	}
+
+	if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_dbg(&cxlr->dev, "interleave config missing\n");
 		return -ENXIO;
 	}
-- 
2.39.5

