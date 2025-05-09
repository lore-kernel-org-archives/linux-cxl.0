Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A9235041;
	Fri,  9 May 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803264; cv=fail; b=gT/zbZt3wSC49AcsavEdiCNQx+CciF682RLppBWoMFyMrng244UeuFtb/fY2JdNmfFPCBIEgm1SH1alk+3JRo5DpwwWgxHkq3F9Vfg8gnT2EaENpIxMx2unexnbLFjyaqdS/eyl+/NBejp6djkKlnzg91RTSr+/A/dTjKdNtgzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803264; c=relaxed/simple;
	bh=zxL9PhfYkd49rnh4aDzJTPzut6C7EoWZclKDeK15NwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEiTCMdQCt6MmUjklTgDhvhh6gtXvTx2GTogX8uR6T8wC/4B/EpiUzrO8+TCORpsHaUsNrPLaspLpsmk6Ytp0B0V3WECIbpTMyPnjNZ/Lg9+j7vBR41F8hDrLkoWDeFOMt5dHORoqtmKkcPJQ10hQ9OgC8muKDMmDobECFtv/us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xbuqiI8Y; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xbuqiI8Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mf66HY9NI5LcfIwy43KQkliFcq0esY1gnx/v1hU6AV0TrAQ+9qs5FErhcte5fBsg9NR/oGb5hQ7bqU6foM56wJDqYE6qpGy3om6Ob2Zr/BeN2x1+/EHKXRF0BSGAOA06pKgeugWC0fVll6yRwCo+/S25VHYDZDFQiFuxo9lkLzFskjQ2Qk6TH7G9i96orFysbIUoktUZduZEpuiZnrdFsOsarjIwzifKsfkIq/s/fL+EWS4wsF2WviSWlmm4py2KdMb5OOtFYTX9H7FYNPtRmmS6+zPfYwODEdQY5YV5j/bBRvye2JEiQanHgr7++LN36n54kL/SjQPwaUoFldLZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+SyfjaiUQIBFXtual+BSjo53IE6yLKZbsRbvsuqp20=;
 b=gK0C6hfU5NvgslvHVg+pH7rXYf4QawYe9gtNPEhtjvWpLYqxfOb7HyX6O3YR8m9pZKT4kwE0w5WMioJxdQyuIm1xsAGIQkOLyjYarNQ5YoyVl8u1i9n+/I9KbrkpY4Sgsat61+qrCAkZlo34sEdeZHkVmbQi9nCBCG1T+hyR4vI+HvWApIIcn5ZyyA7rIetiTVNbLuWTnbw9GH1g9xt9kSOlxUVpPjd6oFRLMOMujaEI8syNCjnWXkkNSgeL8Va5jcE7N7ePCXnro8fwLKi2qewP7xZwNxztogdJOGhc0Qvoi02+yfGVLvNqXFc6YbXF/+9YovGtYhapAuv7k790Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+SyfjaiUQIBFXtual+BSjo53IE6yLKZbsRbvsuqp20=;
 b=xbuqiI8Y3c9ylPDWA6m2PNLcfyYZscs5jdrwY8VGlYapZA8e+LecnlpX/vP9Lhu/OvWXWE6vZsarUlqOvMxY+MoJFiFq5BhxhE8I03cTAepzHTLwfWhfqR/ewqmXQoIEMs6p3LFkhFDVVHZT1tYhoQdtjnRLW7TXaQ6DSKnL00s=
Received: from BN0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:408:142::17)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 9 May
 2025 15:07:39 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::dc) by BN0PR08CA0023.outlook.office365.com
 (2603:10b6:408:142::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 9 May 2025 15:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:07:39 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:07:35 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 01/14] cxl: Remove else after return
Date: Fri, 9 May 2025 17:06:46 +0200
Message-ID: <20250509150700.2817697-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509150700.2817697-1-rrichter@amd.com>
References: <20250509150700.2817697-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb2e8a5-697e-4d60-f3c9-08dd8f0b3d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7dazQU3wCyDjg8OFnYasIB8FAum4rAZo2Ol3Eb8UHSnkBFNR6Zx1JmdWCTeQ?=
 =?us-ascii?Q?72vF+ThXPQ8KK2VneHDA45i8+RzkTDqziPFMQUNMmCJ1fY2llhDH7qaKYvOe?=
 =?us-ascii?Q?IixosC+AjshNPcRwWYe0uT360KcIqQhTy2hIYZ1zsJubna48X19gOlbA8AEM?=
 =?us-ascii?Q?5IRPONMLS+MJqLI74xlfXsPMRph+5UVnA67Kv9vj48xCEJlrwdJCBu+YK1aA?=
 =?us-ascii?Q?jzI/iphnUnqD3Uw2ioBtylu2K6PnjlaWNrbild1u+1mvhShVXsTp/Mf9voRh?=
 =?us-ascii?Q?IpJW74V7rRGeXRTpDXvwz/QB5qRC4yQRf7zZZMx+IkNnWLaaWjr8HRp9C5Z1?=
 =?us-ascii?Q?b8AbPD+z1h6txpmqsfBm/y2q0wEA5PiaL9OM6WWDdoMWE6JOEBn6bIntnEmK?=
 =?us-ascii?Q?nQNFPCbAuIkV6FwSV3rvpX1V+EFilatiQQJBUKI8jkfn6spXO3WjbQy5UWVa?=
 =?us-ascii?Q?VMd8sT3h/g+sjTFHtOuOZcR8fnAm3JJbVumsf0s1bVgiIUo3BinBH22V49tP?=
 =?us-ascii?Q?pvvXSEF6zEftfq4vZ+P8nNZymHpQyAIbq4VQf52BzYPJhmT+v6YRJHAJ1nkQ?=
 =?us-ascii?Q?Ivg0SQuclHsuk7BgvO3Y2Wuzc1LUAPzTzdn/pUHmYhtHpjVklZY4GvWfDvpT?=
 =?us-ascii?Q?f1h6fltkn6TpgBrTiCPKN69+5fZnLJzhSdgL6eWw1NxaYvLO2bmoM47sZMBY?=
 =?us-ascii?Q?/RpFo+VuBtbxGUG99JAgEboyOrmuzGrFuRvE/nP3TOzCUZjyWY9C2j+yWHE0?=
 =?us-ascii?Q?SROfFSpz0tmm33dP9B+7okFJoFTbiwoyrSG3DduDprK9ziFPXSpng/gmXzWr?=
 =?us-ascii?Q?3oo5Bsn3JmwL0mjhriwwSo+CTYdHF6SGN3kfaiQPYhg/BM1md7COv7aP7E0v?=
 =?us-ascii?Q?WADP+tGYj/ElTuIcaq7+/CMpqcvixtFF3RHeENMGg6OYrtlfVSfJZ/o8J52n?=
 =?us-ascii?Q?In2WNc9aoNu+gRETHUxxGxmrk/NbFx8hanJ1h/xqzDWMwgp6cVxzrXH0+yII?=
 =?us-ascii?Q?HmFNSEJtNlcpd6wLwmcKukrZNB5nxPfjjFypHa54h+SxsQSlaTNOeeusm0YT?=
 =?us-ascii?Q?DjTLb+wlz1UVHYoavulzJFQW2MUdX0Tic/xmFVjEL2NOMcHn6ovcKwi6xAcj?=
 =?us-ascii?Q?rpDiUFUoFPpFdPave8XEXdSECULkLLSw2iYItN3PZI4b6Co+wjWTkmZkUW5N?=
 =?us-ascii?Q?ZW6pLxIHNn0O+avOQbs6ySA8qOTeBfZJs9/NBWzVyk9tleI8lOV2wIMkZOBy?=
 =?us-ascii?Q?aUg5Z3zr7PtJuKEyvDJkOuW6dsoHGUhorjL9Gc1VVt0whr6SC/cAwMYOX0HQ?=
 =?us-ascii?Q?bRziVrm6Jwny1A5Zrb52QrEoK1fZH7ww0bw+7zetSgvifp+e/sM60+WYXCTE?=
 =?us-ascii?Q?QZ8WTEwOpScLSjduHiKUgMRSnFDHwogjVScaY/uC/CxxssKH6bLtYDzIcVwr?=
 =?us-ascii?Q?FKHvTAkBVEUON6dCqJsK0qkEIIwF/+t3eSEe3qWfeHJKwh+q2OC367qhOObP?=
 =?us-ascii?Q?cdH3HFFy8rYIHkuNb/f9YONCUUd2PwVZwKQL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:07:39.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb2e8a5-697e-4d60-f3c9-08dd8f0b3d79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780

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
 drivers/cxl/core/cdat.c   |  2 +-
 drivers/cxl/core/memdev.c |  4 ++--
 drivers/cxl/core/pci.c    |  3 ++-
 drivers/cxl/core/region.c | 11 ++++++-----
 4 files changed, 11 insertions(+), 9 deletions(-)

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
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a16a5886d40a..ca9e38b222c8 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -153,8 +153,8 @@ static ssize_t security_state_show(struct device *dev,
 		return sysfs_emit(buf, "frozen\n");
 	if (state & CXL_PMEM_SEC_STATE_LOCKED)
 		return sysfs_emit(buf, "locked\n");
-	else
-		return sysfs_emit(buf, "unlocked\n");
+
+	return sysfs_emit(buf, "unlocked\n");
 }
 static struct device_attribute dev_attr_security_state =
 	__ATTR(state, 0444, security_state_show, NULL);
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3b80e9a76ba8..71bfa3bbe436 100644
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
index 80caaf14d08a..25d2419179e0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -231,11 +231,10 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 				&cxlr->dev,
 				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			return 0;
-		} else {
-			dev_WARN(&cxlr->dev,
-				 "Failed to synchronize CPU cache state\n");
-			return -ENXIO;
 		}
+		dev_WARN(&cxlr->dev,
+			"Failed to synchronize CPU cache state\n");
+		return -ENXIO;
 	}
 
 	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
@@ -1940,7 +1939,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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

