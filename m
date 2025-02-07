Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971F2475FD;
	Fri,  7 Feb 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942749; cv=fail; b=SvZDh0314ov2o0kzY+JsILt657mEXZm9zjNNkGG8RO38jSnr+zy3L0f1b5DZaG60EsOQYIeiH9cqslwqj2p0D/HPJQe72pqDGGMhj87vCm4E4yNpHzS7rJML0wfk0Z2TWRoHTYBMtRW4agnrK8anvahVCvH8/LY5AnB7BMzm6yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942749; c=relaxed/simple;
	bh=bG8SKtpFLu+nIPLweQ19Zr9721yzZM7dUtsVLpVvMSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZysSN/UFb0A10cDjweTbQwFd+47ubleGOUTne3lNpGI87dnBSpBTtz69B2R+c7Osja5kyksZHgRiL6qnXNbluGVObl+p1JA86yAVUUQ3GMe9aSyjcYHe2E50J+SKPwPTkfOi56a2iS1REgVp/ELGR9MyX5Qz9pqe5URv5YL0bVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eRMB6agQ; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eRMB6agQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/NX7nyTRDdM2Sw39xlhA58X6w5KeuPv4Jp4Qd3sO1CJsg4dSuuwmQJbpppI9zLliwUYrV8432LNvL6KDN19UARD02MEVZz9upIG31x3wzd7JS4jss4eRdB5H7vERxATKa62O7jqBdczELfxKeayTTedQhOaCYEL/bcwn9wqskUTC5omkvgC4dJ5CAyGZE02NF7k8tGgBfBso2ESAp5soQuCaf15phzequvBdSfCyv+mL2laRQ7h/JgXqGCHWBmoHCcif7TcS9LeGDxSF96IlakoDNTk9TYKWZZeO3inIGgoODEjOcJjUpXkKm0s7L0LiV7eT/ezUhvFZPr9tQ/y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91Z7rypisvnzcI4Z9R2szRm5jF0ATGlCmQJ0TBdCjrE=;
 b=Jyut3w75703yHSCgDxHhsL8vKE4xjbS/J+UotloKCW5wgfC51hFswRPaPfZ/nT0J2X/gKt/00uDi7rCCEZ/91WDYtR7rH9y80e4qrMYuCyKol6BnHbzjOX5sMJN42QSRRWoyUE+X4yYee4W/OP8L0z3amm9+IfkZoxIzwGrZkYGZZEwhfgo5BPGutsOVO+zn9E1fXlLjBbwx9Jd228yHWXTUXZlUvJ03dDHOBDEVma1xgcRs0r9d0DfrDHlBr/NYJ8e8+2Qdn6DA5LicQOajrzkb/mU7d8KvZUOHRFPX5KFlM85SzoFpDdoneRyg19/DYiqiCczRvGgFTWsjP330VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91Z7rypisvnzcI4Z9R2szRm5jF0ATGlCmQJ0TBdCjrE=;
 b=eRMB6agQIDQuP4DuAJwBtB40NnjJIJKwAvDdCxdOw2/v3YZROnpa8dhjv8b+uSoJZb9Ct7wFi2BkikF78Ah3riQHdwCTG4RnMia4pkkdr/kf2AhEL9JQRNLPQruBMk90qhiK7ySglzQGKwx+dB6OaV1RUMuu12lgdIR1/Q4TAuQ=
Received: from SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:39:04 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::c1) by SJ0PR13CA0044.outlook.office365.com
 (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.7 via Frontend Transport; Fri, 7
 Feb 2025 15:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:39:03 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:39:00 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 13/18] cxl/region: Add function to find a port's switch decoder by range
Date: Fri, 7 Feb 2025 16:37:48 +0100
Message-ID: <20250207153753.418849-14-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5c35b8-7f45-47e1-32a0-08dd478d8d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7MXYbF0p707QBNCyZEEfUvdGgUvUaqRka6juuY3MKqd2decWxaik78bV7qkx?=
 =?us-ascii?Q?3Qg0rav61gbHdZV6iLSOk76+VJ/1pD+RpUXkOgzj+D59HOoX9NvpG+U1HqCu?=
 =?us-ascii?Q?5uYDb2q9Uqxfheqg6rilIZynQPn9Msato81tVlIDEDLdG+T97YpSphtys8ld?=
 =?us-ascii?Q?NEkZD0dcljsNn+HMr7/IysWR/+BTIue25aEfnbEG5fCb4OHQ8m+CufZteRSM?=
 =?us-ascii?Q?5NJCtSQtd+ApKlEhAkAol1RrPC9lQuWTUqtNo29sq16/prvL8CbJfdioUGko?=
 =?us-ascii?Q?q6Yb6z8H+Z0zVbUVTLuSlnmUC8CyZkr2Ek8ul/p4XYdsDMJtf4vzsEcENqYM?=
 =?us-ascii?Q?Cmzzo4Futror9K/f+42SeToDZItj/g0/E3oYsUCr2A7D2i2bFF5up74KiHqV?=
 =?us-ascii?Q?rra4zHdbvpCuWtOq5HPipQeEnYN8e18OqoD2T28lh2WLhi9venhi97vIC9VD?=
 =?us-ascii?Q?bbWCK+XNOK9oy7diKDV+sOkWHrur2exvNoOoQacBri1pBKqAD9K2qXI2TsG+?=
 =?us-ascii?Q?9FLdCEbUWoMKt4ym0cxK+nnupE2mMA9s4igepXMWLXMFBm7SO27AtHK4IuI8?=
 =?us-ascii?Q?s+uX8muqI1YgGGgKVm9TNK36OI2LXVLHpnDnc/YgWVppAKbiuss3saSHAO8P?=
 =?us-ascii?Q?y5+0/c8Cz+kqvzr5pMqneoe27Zys0BGjZIhlwd4V1dc+mNEphnKP9GOhG72U?=
 =?us-ascii?Q?3yixemYM/7tRCobcvgVvKIJ7YwuxjKQVqzMJSbMPQo/1BDe+IoJ4Z8+AXkk7?=
 =?us-ascii?Q?JWA4O25QO2EgmIc3p8Ab3izS4IxIe42lSH2eUh7itLeAtWrKY3fQBKskdjZ2?=
 =?us-ascii?Q?Jx7DupOUiLZofQQ1WZEtRxtbmL+ENCWUIoZcKgQvpgAWQAiS9A18MFYptbIv?=
 =?us-ascii?Q?PYO58AxTUSdMIEKDbf5WRwdRZNgS5fdeF7CDZEHOfSFswiprgi5AqPN5pgd7?=
 =?us-ascii?Q?3SKNRA5viKWctkzCf+Z3UTkKqSoPLXc6s1nTy++5hPwkBT/bIp1roCR83oUI?=
 =?us-ascii?Q?vPtiYnnIDXi9jlO4CSV4KHsh84X/Me8iY6NBUB01maPdnGhrC6FhWsqpkIEu?=
 =?us-ascii?Q?rxS/lRDcQGpIy7A9CeEtmLX7zQV+KpvwZ2dpgplV1PAi9ulLJ+TLWwmeInCE?=
 =?us-ascii?Q?Kek8Z68TdnWTlsQ26dMrYNsdW3Ypf1Id2gWeZy3QD2HQl+WCtaDTNvbkg3e+?=
 =?us-ascii?Q?74d3rzPTFHYkwJIMlll8qcro9AH28do3YVNa5AINpYWY2ErgLvTNP3fDENoX?=
 =?us-ascii?Q?xirfM7aGDVIfkRNCtyLnWVdx/ahbmrygd/XY/qp4SkyUpOGc8oP6p6G/ITik?=
 =?us-ascii?Q?hmH59BvCNyhqAZRmFiZR8xuEtgh3t3l18r+4Qlub/ChE56Jo1o4QjzIiNjQ/?=
 =?us-ascii?Q?2BknXBVLSoq8adP/uril+I82ZTAbM/oK7SHFxbA4x+W7sIQMLlu52d5oyYIz?=
 =?us-ascii?Q?MAGbH1rwspyp34omPaklvzuA7TM5bwsfe9yCSqew0bxNk7akEO4AQ9sg/1Zb?=
 =?us-ascii?Q?yxysF0YImJ/vfsA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:39:03.7787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5c35b8-7f45-47e1-32a0-08dd478d8d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024

Factor out code to find the switch decoder of a port for a specific
address range. Reuse the code to search a root decoder, create the
function cxl_port_find_switch_decoder() and rework
match_root_decoder_by_range() to be usable for switch decoders too.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cfcd235f311e..15286acdf6d1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3189,20 +3189,37 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_root_decoder_by_range(struct device *dev,
-				       const void *data)
+static int match_decoder_by_range(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-	struct cxl_root_decoder *cxlrd;
+	struct cxl_decoder *cxld;
 
-	if (!is_root_decoder(dev))
+	if (!is_switch_decoder(dev))
 		return 0;
 
-	cxlrd = to_cxl_root_decoder(dev);
-	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	cxld = to_cxl_decoder(dev);
+	r1 = &cxld->hpa_range;
 	return range_contains(r1, r2);
 }
 
+static struct cxl_decoder *
+cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+{
+	/*
+	 * device_find_child() increments the reference count of the
+	 * the switch decoder's parent port to protect the reference
+	 * to its child. The port is already a parent of the endpoint
+	 * decoder's port, at least indirectly in the port hierarchy.
+	 * Thus, the endpoint already holds a reference for the parent
+	 * port of the switch decoder. Free the unnecessary reference
+	 * here.
+	 */
+	struct device *cxld_dev __free(put_device) =
+		device_find_child(&port->dev, hpa, match_decoder_by_range);
+
+	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+}
+
 static struct cxl_root_decoder *
 cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 {
@@ -3210,7 +3227,6 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *iter = cxled_to_port(cxled);
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct range *hpa = &cxld->hpa_range;
-	struct device *cxlrd_dev;
 
 	while (iter && !is_cxl_root(iter))
 		iter = to_cxl_port(iter->dev.parent);
@@ -3218,9 +3234,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 	if (!iter)
 		return NULL;
 
-	cxlrd_dev = device_find_child(&iter->dev, hpa,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
+	cxld = cxl_port_find_switch_decoder(iter, hpa);
+	if (!cxld) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
 			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
@@ -3228,16 +3243,9 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
 		return NULL;
 	}
 
-	/*
-	 * device_find_child() created a reference to the root
-	 * decoder. Since the root decoder exists as long as the root
-	 * port exists and the endpoint already holds a reference to
-	 * the root port, this additional reference is not needed.
-	 * Free it here.
-	 */
-	put_device(cxlrd_dev);
 
-	return to_cxl_root_decoder(cxlrd_dev);
+
+	return to_cxl_root_decoder(&cxld->dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
-- 
2.39.5

