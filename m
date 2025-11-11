Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F089326938
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897410; cv=fail; b=RqdTG7pbfiSh6ZSfue+X4cP9tULlU1onBUR4gOXbeg4+Uz1876S/LyYWbwTVkiSeMz5eEFrD0ZLnTsKfbJS1mCz/u8PvB3e7pIQQitRZ0JeSG3LHv0hlpSOvkw94R/A/lGQWY56xVkeWKxkOGBvddjKeLCWQmTyWzU3y/q4qpg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897410; c=relaxed/simple;
	bh=Eu1tYM/wPEBoCF+sJpK+fsrHEzL5ohCXpULjVFYnizk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYZyvwcNS0w8fUaE84dHk4QbJwo6pNqbBEmQ3Q8zQ3uzsHcM9jwRqlYxg9w4hYAGk97Kj9roPv7wVbi5kmRPw0YGyNbnMhCHVklk3Tm/Q8kJXXtw/HvGHmmHrvWeA9Iym9YKO05LwPR7oorwndPXm5WD9cE+FcUYBdXgUO4iGP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cGwBJNBF; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cGwBJNBF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbCRrc0XWRkISZ7a+rF6hxmW0HhGE+OktD0nkiiKTS/IExiWZcQwoUDHg2uCGa56pLgmrPt8u29LKnBn4VD/N4R8enmTK/g+apKZB/nq90UjJjtJR3j9u1I5UtAeqKtWI5sv0UJxHpOM692CgvyC3I0RCzYHPwrCgwkUz7gsXqAb0/ANngw8WNuAJDjEVie8cR9hWvzr3OjwaVVCKSCdNexJhYe7CztkoEFjkIuM6VLG/JCluu/PS5+xKd2NlmgwoGfHzKdKFdsTeM5h600B7ExAnMSk3oo0b0Kdklfduy2ojIDnCH7M1EwmFoyhWSVfYZCR/8WAH6OFcIMsWazaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B1Rmpf/9vHg80fbhqTt+dTb6jy1CWCj4TYKbBrgqqg=;
 b=MxbjBbi/mZgoMtOgqCl7GR6mWdJ+WRVhCNpcSrNMxvtjPkXZwDgOSSpGdzR5zkDyInWn83qm3zy21TazdbhhJacfnRma44TW5ZottWFzmCSz7doxy4gx2SYuVhT39pdzxcmQvAg29aEDtfgBBuziixLAHjVpy3l8bZaI5gDNQpa9OqyWC63aoAF3rgSEkGP//vvG3OGh2dldqwwsb+zfC1FZk89HyoJEdqgqAx0XkdbqM+AbRfcbONZoaS3gyEEb0gXiB4um7+cRpupzc7hqufPJddpvdUnQhvxK9g/cJPd7f5xCI3O6320B+tfvj2SoCF4P6iaPJwA+WUfMztyz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B1Rmpf/9vHg80fbhqTt+dTb6jy1CWCj4TYKbBrgqqg=;
 b=cGwBJNBF3dI7pUh23svXCbXk/kXV5MimrUrlLnRYND58XdD69UlQ4oTwwox3/+oWwsoKrOeAgI0SOzaqCloGkyggo03ygg7F7rAwTj3Uom6WYyTmkgl9oUI7Eu8mQNzH6aC21z/ShpnoqOBeK/LscxRZgeV3a24hBRltbKr28hE=
Received: from BLAPR03CA0060.namprd03.prod.outlook.com (2603:10b6:208:32d::35)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 11 Nov
 2025 21:43:23 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::3b) by BLAPR03CA0060.outlook.office365.com
 (2603:10b6:208:32d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 21:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:43:23 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:43:23 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 13/17] cxl/core: Add cache id verification
Date: Tue, 11 Nov 2025 15:40:28 -0600
Message-ID: <20251111214032.8188-14-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae03d4f-e855-479c-7d4d-08de216b56e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+qZ62AEMGdd6wuyUrXfubV9AyJxq5gURvApnztwzGzE0GF65CRUstoSar+q?=
 =?us-ascii?Q?YSbdJQ4Q6+Vt8WwyBmVrKLOAeAqfuQRTdiG4GztAk+BZKmr1m1fCUOnu+ZIr?=
 =?us-ascii?Q?LOf646QhNrN7VHVsGXbZqrvIrBP/BW6ybWKhxgBrvhbAL090Bmv7RPBnVAwJ?=
 =?us-ascii?Q?ONOtcgj90fCJlrdcwvxjSEe354dzQ9bPf4dbGv/Q1LuE2fEn3DOYjx7MsPON?=
 =?us-ascii?Q?PsykjDnAgqaiwp2IomjUIHkH4DZqXPmbKppUBK3IYDHazTQMbS1WXM+IN/TJ?=
 =?us-ascii?Q?eQy/Vjfaa9qAqVAtLH9YKqFF8zO9NYvNbsKFoRS9BMnv+7IlSJIvxl+4M4md?=
 =?us-ascii?Q?rBKv2SJuzM5mK16uXADSFiNa3lo2e7YknBMiSMWmHMh3PRVkDG8S4Pk1CUDt?=
 =?us-ascii?Q?IKVhY2oUZ119NwKi4LQI42aQVUiYNiYarNJldnC5oXcPOZBufkSvtV48U1zn?=
 =?us-ascii?Q?wqxNrD9VlHT81Nc3hjfPmgM/AOabH4zL35pQsoGYwTTLeOxt2Mg0SlHHS1qa?=
 =?us-ascii?Q?WZx8XvUkPdxhBcl2g/JPEqKzFiq6d3wVcmAu6y7wIcRx2kNXpSwDyHbnBOZ7?=
 =?us-ascii?Q?jZPB8SkHGCK8q20AtstaBL/nxDYQCGzR4rzAmDF+f9wmB0uJQehD15/MugCu?=
 =?us-ascii?Q?lCkuXHfYtRkdF8ihmXV0e38sgdDw/7wKBoUdmLBKClBe5Pn/K5aHMclpTpDV?=
 =?us-ascii?Q?dnrffCZMb1eU+s2GxuS8ZW0KX7LGZBNKVuP+jILIs1yXGxVbaMsiiWEMZzQj?=
 =?us-ascii?Q?D6p/iXR/LUYX54O/PxOH3hNtGw/gE52L+4Wy3Er3dP+quUrTDoWKDEMop+KB?=
 =?us-ascii?Q?dInl93p2FfxiuOysHc55+WShPzrR2ckvHClzre/WdoSzXmcZsu//DYU/olOJ?=
 =?us-ascii?Q?waXV7Fxdjlx1Opd6z/2sBa13Mb0MRvltst3SPPGBiqS9PwEAvPeuQB2hoYbM?=
 =?us-ascii?Q?vnaQj8toTx1P7Yn0c0M2PLgsCV4Yh/AdTlL/FJjRLLqBwBFzbiMYCf9tV9IO?=
 =?us-ascii?Q?9J8FwFC3X/sr02ria8P/1stgKxEQomNj/wPIA2KtkCQ5cbtyCAut6dLoe2UT?=
 =?us-ascii?Q?UfgD/j3o4inyiATls9CEY0ylRWzW1fFQGVm2ThnBoDIM+JwlgWmB8Ije6Bz2?=
 =?us-ascii?Q?+uxEHFrqiqMgedOnRqs06LTz7VM1rxJZ2EKKXmrgrNIXiC94kCxM/tVHLanx?=
 =?us-ascii?Q?b6pklln+xwUFo4OB0qL8Cc2c4urdL7gzIBQ+EfIaXoDIY+CZpb9PTJePQfOL?=
 =?us-ascii?Q?1+h40Dibz/EdCIRuLFlVJ8PfRtGI92Vp/vwdvqe/gsCAZJhAFgnrK1UPnh0a?=
 =?us-ascii?Q?lbBHjIaYcjOERV0JVmPrsooa49gJtHZZsXmRDABsvQZmlVS/Mb53fWHfuGJS?=
 =?us-ascii?Q?17M+ogHIA86g2GGAMIiIpF04+9XRTeXn1IeaS4+jOaBGz1XBUgzHoy64rl16?=
 =?us-ascii?Q?5Dn3WteE04UVv6RnXX0qbsTADrhUZLX+21cY9AnVsYUe98XZ30WmJ4HjRuHj?=
 =?us-ascii?Q?/ctTsxxqEzbsPxL5pjbtFqrbhmkhpUrPNZe6nZZwKRgt30WPJ+Z95wHReZQG?=
 =?us-ascii?Q?so+yx6T6ouG4JL8n68A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:43:23.5519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae03d4f-e855-479c-7d4d-08de216b56e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990

The CXL cache id capability (CXL 3.2 8.2.4.28/29) is an optional
capability that allows for multiple CXL.cache devices to be enabled
under a single virtual hierarchy (VH). The cache id capability is
required for having multiple CXL.cache devices in the same VH.

It's possible for the platform to enable and set up the cache id for a
CXL.cache device. Add code to cxl_cache to check whether the device's
cache id is programmed and correct. If it is programmed, allocate the
cache id to prevent reuse.

Checking the correctness of the id requires knowing if the endpoint
device is a type 2 device using HDM-D flows. Add a requirement for type
2 driver to specify if the device is using HDM-D flows before calling
devm_cxl_add_cachedev().

Programming of cache ids will come in a later commit.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/cachedev.c |  20 ++++
 drivers/cxl/core/pci.c      |   4 +-
 drivers/cxl/core/port.c     | 229 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c     |  20 ++++
 drivers/cxl/cxl.h           |  44 +++++++
 drivers/cxl/cxlcache.h      |   3 +-
 drivers/cxl/port.c          |  28 ++++-
 7 files changed, 344 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
index 5693a63baa9b..0b7430450b4e 100644
--- a/drivers/cxl/core/cachedev.c
+++ b/drivers/cxl/core/cachedev.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Advanced Micro Devices, Inc. */
 #include <linux/device.h>
 #include <linux/pci.h>
+#include "cxlpci.h"
 
 #include "../cxlcache.h"
 #include "private.h"
@@ -93,3 +94,22 @@ struct cxl_cachedev *devm_cxl_cachedev_add_or_reset(struct device *host,
 	return cxlcd;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_cachedev_add_or_reset, "CXL");
+
+bool cxl_cachedev_is_type2(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	int dvsec = cxlds->cxl_dvsec;
+	u32 cap;
+	int rc;
+
+	if (!dev_is_pci(cxlds->dev))
+		return false;
+
+	rc = pci_read_config_dword(to_pci_dev(cxlds->dev),
+				   dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	return (cap & CXL_DVSEC_MEM_CAPABLE) && (cap & CXL_DVSEC_CACHE_CAPABLE);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cachedev_is_type2, "CXL");
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b1cace8fc0f..27c74e90ade5 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1264,11 +1264,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_port_get_possible_dports, "CXL");
 /**
  * cxl_accel_read_cache_info - Get the CXL cache information of a CXL cache device
  * @cxlds: CXL device state associated with cache device
+ * @hdmd: Whether the device uses HDM-D flows
  *
  * Returns 0 and populates the struct cxl_cache_state member of @cxlds on
  * success, error otherwise.
  */
-int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds)
+int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds, bool hdmd)
 {
 	struct cxl_cache_state *cstate = &cxlds->cstate;
 	struct pci_dev *pdev;
@@ -1308,6 +1309,7 @@ int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds)
 	if (!cstate->size)
 		return -ENXIO;
 
+	cxlds->hdmd = hdmd;
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_accel_read_cache_info, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 70666a059d1f..1504631ae620 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -750,6 +750,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 		dev->parent = uport_dev;
 
 	ida_init(&port->decoder_ida);
+	ida_init(&port->cache_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
 	xa_init(&port->dports);
@@ -2414,6 +2415,234 @@ int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, "CXL");
 
+static bool cache_decoder_committed(struct cxl_dport *dport)
+{
+	u32 cap, stat;
+
+	cap = readl(dport->regs.cidd + CXL_CACHE_IDD_CAP_OFFSET);
+	if (!(cap & CXL_CACHE_IDD_CAP_COMMIT_REQUIRED))
+		return true;
+
+	stat = readl(dport->regs.cidd + CXL_CACHE_IDD_STAT_OFFSET);
+	return (stat & CXL_CACHE_IDD_STAT_COMMITTED);
+}
+
+static bool cache_decoder_valid(struct cxl_dport *dport, int id, bool endpoint)
+{
+	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
+	bool flit_256b = cxl_pci_flit_256(pdev);
+	u32 ctrl;
+
+	if (id && !flit_256b)
+		return false;
+
+	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	if ((endpoint || !flit_256b) &&
+	    !(ctrl & CXL_CACHE_IDD_CTRL_ASGN_ID))
+		return false;
+	else if (!(ctrl & CXL_CACHE_IDD_CTRL_FWD_ID))
+		return false;
+
+	return true;
+}
+
+static int cxl_dport_get_cache_id(struct cxl_dport *dport,
+				  struct cxl_port *endpoint)
+{
+	u32 ctrl;
+	int id;
+
+	if (!is_cxl_endpoint(endpoint))
+		return CXL_CACHE_ID_NO_ID;
+
+	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	if (ctrl & CXL_CACHE_IDD_CTRL_TYPE2)
+		id = FIELD_GET(CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK, ctrl);
+	else
+		id = FIELD_GET(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK, ctrl);
+
+	if (!cache_decoder_valid(dport, is_cxl_endpoint(endpoint), id) ||
+	    !cache_decoder_committed(dport))
+		return CXL_CACHE_ID_NO_ID;
+
+	return id;
+}
+
+static bool cache_idrt_committed(struct cxl_port *port)
+{
+	u32 cap, stat;
+
+	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
+	if (!(cap & CXL_CACHE_IDRT_CAP_COMMIT_REQUIRED))
+		return true;
+
+	stat = readl(port->regs.cidrt + CXL_CACHE_IDRT_STAT_OFFSET);
+	return (stat & CXL_CACHE_IDRT_STAT_COMMITTED);
+}
+
+static bool cache_idrt_entry_valid(struct cxl_port *port, int id)
+{
+	u16 target;
+	u32 cap;
+
+	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
+	if (FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap) <= id)
+		return false;
+
+	target = readw(port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
+	return (target & CXL_CACHE_IDRT_TARGETN_VALID);
+}
+
+int cxl_endpoint_map_cache_id_regs(struct cxl_port *port)
+{
+	struct cxl_dport *parent_dport = port->parent_dport;
+	int rc;
+
+	if (!is_cxl_cachedev(port->uport_dev))
+		return -EINVAL;
+
+	port = parent_port_of(port);
+	while (port) {
+		if (!port->reg_map.component_map.cidrt.valid)
+			return -ENXIO;
+
+		scoped_guard(device, &port->dev) {
+			if (!port->regs.cidrt) {
+				rc = cxl_map_component_regs(
+					&port->reg_map, &port->regs,
+					BIT(CXL_CM_CAP_CAP_ID_CIDRT));
+				if (rc)
+					return rc;
+			}
+		}
+
+		/*
+		 * Parent dports of host bridges are cxl root (ACPI0017) dports
+		 * and don't have cache id decoders.
+		 */
+		if (is_cxl_root(parent_dport->port))
+			break;
+
+		if (!parent_dport->reg_map.component_map.cidd.valid)
+			return -ENXIO;
+
+		scoped_guard(device, &parent_dport->port->dev) {
+			if (!parent_dport->regs.cidd) {
+				rc = cxl_map_component_regs(
+					&parent_dport->reg_map,
+					&parent_dport->regs.component,
+					BIT(CXL_CM_CAP_CAP_ID_CIDD));
+				if (rc)
+					return rc;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_map_cache_id_regs, "CXL");
+
+/**
+ * cxl_endpoint_allocate_cache_id - Allocate a cache id @id on the endpoint's
+ * host bridge.
+ * @endpoint: Endpoint port representing a CXL.cache device
+ * @id: Cache id to attempt to allocate
+ *
+ * Returns rc < 0 if id allocation fails. Returns allocated id otherwise.
+ */
+int cxl_endpoint_allocate_cache_id(struct cxl_port *endpoint, int id)
+{
+	struct cxl_cachedev *cxlcd;
+	struct cxl_port *hb;
+	int nr_hdmd;
+	u32 cap;
+
+	if (!is_cxl_cachedev(endpoint->uport_dev) || id < 0)
+		return -EINVAL;
+	cxlcd = to_cxl_cachedev(endpoint->uport_dev);
+
+	hb = parent_port_of(endpoint);
+	while (!is_cxl_host_bridge(&hb->dev))
+		hb = parent_port_of(hb);
+
+	if (cxl_cachedev_is_type2(cxlcd) && cxlcd->cxlds->hdmd) {
+		cap = readl(hb->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
+		nr_hdmd = FIELD_GET(CXL_CACHE_IDRT_CAP_TYPE2_CNT_MASK, cap);
+
+		guard(device)(&hb->dev);
+		if (hb->nr_hdmd + 1 >= nr_hdmd)
+			return -EINVAL;
+
+		hb->nr_hdmd++;
+	}
+
+	return ida_alloc_range(&hb->cache_ida, id, id, GFP_KERNEL);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_allocate_cache_id, "CXL");
+
+void cxl_endpoint_free_cache_id(struct cxl_port *endpoint, int id)
+{
+	struct cxl_cachedev *cxlcd;
+	struct cxl_port *hb;
+
+	if (!is_cxl_cachedev(endpoint->uport_dev))
+		return;
+	cxlcd = to_cxl_cachedev(endpoint->uport_dev);
+
+	hb = endpoint;
+	while (!is_cxl_host_bridge(&hb->dev))
+		hb = parent_port_of(hb);
+
+	if (cxl_cachedev_is_type2(cxlcd) && cxlcd->cxlds->hdmd) {
+		guard(device)(&hb->dev);
+		hb->nr_hdmd--;
+	}
+
+	ida_free(&hb->cache_ida, id);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_free_cache_id, "CXL");
+
+/**
+ * cxl_endpoint_get_cache_id - Get the cache id of a CXL.cache endpoint device
+ * @endpoint: Endpoint port representing cache device
+ * @cid: Pointer to store resulting cache id in
+ *
+ * Returns 0 and sets @cid to CXL_CACHE_ID_NO_ID if programmed cache id is
+ * invalid.
+ */
+int cxl_endpoint_get_cache_id(struct cxl_port *endpoint, int *cid)
+{
+	struct cxl_dport *dport = endpoint->parent_dport;
+	struct cxl_port *port = parent_port_of(endpoint);
+	bool ep = true;
+
+	if (!cid)
+		return -EINVAL;
+
+	*cid = cxl_dport_get_cache_id(dport, port);
+
+	while (!is_cxl_root(port)) {
+		if (!cache_idrt_entry_valid(port, *cid) ||
+		    !cache_idrt_committed(port)) {
+			*cid = CXL_CACHE_ID_NO_ID;
+			break;
+		}
+
+		if (!cache_decoder_valid(dport, ep, *cid) ||
+		    !cache_decoder_committed(dport)) {
+			*cid = CXL_CACHE_ID_NO_ID;
+			break;
+		}
+
+		dport = port->parent_dport;
+		port = dport->port;
+		ep = false;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_cache_id, "CXL");
+
 /**
  * __cxl_driver_register - register a driver for the cxl bus
  * @cxl_drv: cxl driver structure to attach
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 280978b34d2f..545a1b9e026c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -98,6 +98,24 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_SNOOP_CAPABILITY_LENGTH;
 			rmap = &map->snoop;
 			break;
+		case CXL_CM_CAP_CAP_ID_CIDRT: {
+			int entry_cnt;
+
+			dev_dbg(dev,
+				"found Cache ID Route Table capability (0x%x)\n",
+				offset);
+			entry_cnt = FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, hdr);
+			length = 2 * entry_cnt + 0x10;
+			rmap = &map->cidrt;
+			break;
+		}
+		case CXL_CM_CAP_CAP_ID_CIDD:
+			dev_dbg(dev,
+				"found Cache ID Decoder capability (0x%x\n",
+				offset);
+			length = CXL_CACHE_IDD_CAPABILITY_LENGTH;
+			rmap = &map->cidd;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -218,6 +236,8 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
 		{ &map->component_map.snoop, &regs->snoop },
+		{ &map->component_map.cidrt, &regs->cidrt },
+		{ &map->component_map.cidd, &regs->cidd },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index de29ffc3d74f..f4dc912d67ed 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -42,6 +42,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_ID_SNOOP 0x8
+#define   CXL_CM_CAP_CAP_ID_CIDRT 0xD
+#define   CXL_CM_CAP_CAP_ID_CIDD 0xE
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
@@ -159,6 +161,30 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_SNOOP_FILTER_SIZE_OFFSET 0x4
 #define CXL_SNOOP_CAPABILITY_LENGTH 0x8
 
+/* CXL 3.2 8.2.4.28 CXL Cache ID Route Table Capability Structure */
+#define CXL_CACHE_IDRT_CAP_OFFSET 0x0
+#define   CXL_CACHE_IDRT_CAP_CNT_MASK GENMASK(4, 0)
+#define   CXL_CACHE_IDRT_CAP_TYPE2_CNT_MASK GENMASK(11, 8)
+#define   CXL_CACHE_IDRT_CAP_COMMIT_REQUIRED BIT(16)
+#define CXL_CACHE_IDRT_STAT_OFFSET 0x8
+#define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
+#define CXL_CACHE_IDRT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
+#define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
+#define   CXL_CACHE_IDRT_TARGETN_PORTN GENMASK(15, 8)
+
+/* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
+#define CXL_CACHE_IDD_CAP_OFFSET 0x0
+#define   CXL_CACHE_IDD_CAP_COMMIT_REQUIRED BIT(0)
+#define CXL_CACHE_IDD_CTRL_OFFSET 0x4
+#define   CXL_CACHE_IDD_CTRL_FWD_ID BIT(0)
+#define   CXL_CACHE_IDD_CTRL_ASGN_ID BIT(1)
+#define   CXL_CACHE_IDD_CTRL_TYPE2 BIT(2)
+#define   CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK GENMASK(11, 8)
+#define   CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK GENMASK(19, 16)
+#define CXL_CACHE_IDD_STAT_OFFSET 0x8
+#define   CXL_CACHE_IDD_STAT_COMMITTED BIT(0)
+#define CXL_CACHE_IDD_CAPABILITY_LENGTH 0xC
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -223,6 +249,8 @@ struct cxl_regs {
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
 		void __iomem *snoop;
+		void __iomem *cidrt;
+		void __iomem *cidd;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -266,6 +294,8 @@ struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
 	struct cxl_reg_map snoop;
+	struct cxl_reg_map cidrt;
+	struct cxl_reg_map cidd;
 };
 
 struct cxl_device_reg_map {
@@ -609,7 +639,9 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @regs: component register mappings
  * @nr_dports: number of entries in @dports
+ * @nr_hdmd: number of type 2 devices using hdm-d flows below this port
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
  * @dead: last ep has been removed, force port re-creation
@@ -618,6 +650,7 @@ struct cxl_dax_region {
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
  * @component_reg_phys: Physical address of component register
+ * @cache_ida: cache id allocator
  */
 struct cxl_port {
 	struct device dev;
@@ -630,7 +663,9 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs regs;
 	int nr_dports;
+	int nr_hdmd;
 	int hdm_end;
 	int commit_end;
 	bool dead;
@@ -642,6 +677,7 @@ struct cxl_port {
 	bool cdat_available;
 	long pci_latency;
 	resource_size_t component_reg_phys;
+	struct ida cache_ida;
 };
 
 /**
@@ -769,6 +805,7 @@ struct cxl_dpa_info {
 	int nr_partitions;
 };
 
+#define CXL_CACHE_ID_NO_ID (-1)
 #define CXL_SNOOP_ID_NO_ID (-1)
 
 /**
@@ -780,6 +817,7 @@ struct cxl_cache_state {
 	u64 size;
 	u32 unit;
 	int snoop_id;
+	int cache_id;
 };
 
 /**
@@ -797,6 +835,7 @@ struct cxl_cache_state {
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
  * @media_ready: Indicate whether the device media is usable
+ * @hdmd: Whether this device is using HDM-D flows
  * @dpa_res: Overall DPA resource tree for the device
  * @part: DPA partition array
  * @nr_partitions: Number of DPA partitions
@@ -815,6 +854,7 @@ struct cxl_dev_state {
 	int cxl_dvsec;
 	bool rcd;
 	bool media_ready;
+	bool hdmd;
 	struct resource dpa_res;
 	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
 	unsigned int nr_partitions;
@@ -946,6 +986,10 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
 }
 int cxl_endpoint_autoremove(struct device *ep_dev, struct cxl_port *endpoint);
+int cxl_endpoint_map_cache_id_regs(struct cxl_port *endpoint);
+int cxl_endpoint_get_cache_id(struct cxl_port *endpoint, int *cid);
+int cxl_endpoint_allocate_cache_id(struct cxl_port *endpoint, int id);
+void cxl_endpoint_free_cache_id(struct cxl_port *endpoint, int id);
 
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index 6409e25dd1b4..fe9e44fda641 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -28,7 +28,8 @@ static inline struct cxl_cachedev *to_cxl_cachedev(struct device *dev)
 
 bool is_cxl_cachedev(const struct device *dev);
 
-int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds);
+int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds, bool hdmd);
 struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
 					   struct cxl_dev_state *cxlds);
+bool cxl_cachedev_is_type2(struct cxl_cachedev *cxlcd);
 #endif
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ae38b9965a84..c1d1d28bee5c 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -7,6 +7,7 @@
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "private.h"
+#include "cxlcache.h"
 
 /**
  * DOC: cxl port
@@ -95,10 +96,33 @@ static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
 	return 0;
 }
 
+static void free_cache_id(void *data)
+{
+	struct cxl_cachedev *cxlcd = data;
+	int id = cxlcd->cxlds->cstate.cache_id;
+
+	cxl_endpoint_free_cache_id(cxlcd->endpoint, id);
+}
+
 static int cxl_cache_endpoint_port_probe(struct cxl_port *port)
 {
-	/* No further set up required for CXL.cache devices */
-	return 0;
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(port->uport_dev);
+	int rc, id;
+
+	rc = cxl_endpoint_map_cache_id_regs(port);
+	if (rc)
+		return rc;
+
+	rc = cxl_endpoint_get_cache_id(port, &id);
+	if (rc)
+		return rc;
+
+	rc = cxl_endpoint_allocate_cache_id(port, id);
+	if (rc < 0)
+		return rc;
+
+	cxlcd->cxlds->cstate.cache_id = id;
+	return devm_add_action_or_reset(&cxlcd->dev, free_cache_id, cxlcd);
 }
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
-- 
2.51.1

