Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3053EA979
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184846; cv=fail; b=Lw21hKpG1gyOBOt9vRjt+vJAD+CpnEDIx0TReLHytmw1COICIC2rRbPurcXxYeuYoOfnIiKdfLKHYQoPhAWiEoKtP0z/Jh8OMyVIjD9e/sM99xT37YNsT2fGxMY2YCfP7FoCyKKZnChri6vYcC1nSy8wWJWQvSlmd1+m24HZlTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184846; c=relaxed/simple;
	bh=JVjs1JQ2jZ8H8queqKQr/G2r9g1Hy8cn40hhOLJbn7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkRHjFj6ys5QrNd8+IIvsvDTBbeg9rC8Gz+hAI9Z7rOeI33B6WxeheUqR9LPFslX3hZgr07VHE6jDpfN2y97cDYUR3RjOOGk/UsW0bdv+CFRakrHeB/LGw7fXyV6nDSSmGY8E059QziMb2hX51q3Ms7IcuSKgvLE7CBPQNwQ8D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zKgDQIuP; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zKgDQIuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8sBRh8CTChjKedFjmLyb487l6c/vNN6YUCT3EvirM30OWGYJW53ungrMLLok8ygtboW+TGM8AtEWAj4l/jSdtQ7kyhfX9dqDUDObXCu1AuqAkTGbK3HuxptUYzotrg4ev0i6w68tL88BEfllZr/kJsA0Himc1ZbNT/Ol0f9OKZtAcQobqv0V89ZzNyptwU/F1Y4rBTByEIjRzFG8vV0b9noLndePs4hds8/3i6OV5jUjsTpT3EbOrkbjBsGi28CLeYOufXoa3uvGZHNeU9h8SJwDAVRzLfg+/LA2qRcJNfNqIKV+VauA62rll1oZTKVOLoGTbz4KqVipveFj/EW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xif5/w7LTIH+ivyp2LpPSle1p6kMKPUmzCejz+UJdg=;
 b=vFcND3+blkBp9qWEs1UnIyIKYfrn8i1D/NY4FhFQKK4KYNUOxXbS9nysXfBIvqgRMRmWZf1DLZ7Qn+EuvFpVystx5jXXCj5MxdPiXMt40yTVj0fYS/VOlELDb5SuFEjg1KLC/sML+PCj/96Py/qPf/EKFyYYovWBnbzXoaM5kb5uOvLJJsHfLUsXoxMxr1AnhXg+YP4OtIAmyoagnU7uvNO/0sk9EzQrCNhTMmj3ex7tkyk9yrX9zVTtgak3szauVSTXRyEllDbZi4zmSnhx+UCkjGZJHIeripsiDou1OURycW1dEaDM8BikYKbjrtQAtkh2JNk6YNGGSIo3lSahgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Xif5/w7LTIH+ivyp2LpPSle1p6kMKPUmzCejz+UJdg=;
 b=zKgDQIuPOe07oLvkzIJ8vrw9GMcf02Q4wyXpqJSWffS/mOz+IrefIGyhkyCmCkoNBCI7CGterQk8LiO+k7ctgzjh8r8CUGuyzDgdr3J8cuMs3oc54nKyzP9vNGInrnABeg9pEtQG4YvwcJ+LP7HvvL3aImbh0A1pvPbpGLmAxo4=
Received: from CH2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:610:4d::36)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:33:57 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::36) by CH2PR19CA0026.outlook.office365.com
 (2603:10b6:610:4d::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 17:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:57 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:56 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 10/15] cxl/core: Add Cache ID allocation
Date: Wed, 23 Sep 2026 12:33:37 -0500
Message-ID: <20260923173342.5584-11-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: af3e518d-3b83-4372-d1ce-08df1998d916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	BNve8iBY7fui5vKv8dKDBySI9TVtAY+sNfKBNx3SVJq4KqIpcgBzcyCEmu0QikXh2Q+NLcOUg+fYdsAYYfX/iQh0phjq6rWuoQgqLbu8kCH2YHilj1krfAR7bgDAIf4OTWJF/fnzclUsGdXgRoKWCoNpcDYInzBcrcPEzKpbS3MAsHskwvUTYGOVnJFCV8eaEjajv8X7F3an1gmSn3el9JeVL3CgGQEd+QJrK84r0ZgFgq28Cp9lSnnZ9CTSX8h0T00KzklNExocv5vp9F7gjgJAxvHtFDClaaBz2IidJHShFX00Kj/OJWx6WmY6u7PdwSZFX6AxrHFoc4YQ1ougVM1PN+BHLAIvVa7Skc4Wve8ovsWf8wBX70UH/vtb1nJiZXZJfzmVFbC6aDjDoNzOU2uuwTsonpSWEjZDExx91Ym/kyqHI71q/pUXQXYJHttMT0eZ6D/EbLxv4opkAGHrb4t4rh4/PjLeK/u2c3I3+AZg05h4zXQqnl3FXvCsI0pZoNdAkF4MvZ24gqQGkz7aWwdUi3Mux0jgmIw6/OsoOtaYfqYB5N5fsvZhCSAFji5qXsH3037Gsf+6BbxdImT8ncaBlQrGcvmYLY1UPU5c6dVmiOMDXJwcoCmYvLC2ZFvhVi2hACAJv6+jAfp6xsge2XaV81JbO+qMs8BzGIR0O9FY22z0RRUS0Q/qmBXGYO2Ih79qYDx6W5j1CSoLZHJsxQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vsXU1opfHs+pc5JyY086xXrBSXm1nD4UUERSjrQ1cSYGSJwNrdNRcHMMBI3EhJXObdNAlzyx9eWgG9TKz6Z+ZptR/JSg0qOsTaaSfpn/l6JJrT8GdaG1A/y3/XpUTOHfWCzZLvHuUZTeMmPrX48hXR4MJW16AvJqEsVCyO1tMknRWdz/MYeZ712limUM+Z9FSF+nhu6kHBcpARqHHFfeB9cDKtyzCYx3G/6AlM/4A6wtx905gKkSsocN2v/xuMZnslef+vdJVGlOXSxtVl3ITWzj1pIDk5XtEcv3KEdEFgmFZ2yTLPjDxFyBOSRD8B2VEPLFxQcZYqv/ENINQXCBWoz82AShkD3aYCvNZCzfAbHqb8C/p30hkkokWe2RmZINylznfZukTWjmhyNXv0T00Rf1zoc0ZyFyNbk3XgWgzD8rqAakuy0VheC2sNGQKvKu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:57.6974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3e518d-3b83-4372-d1ce-08df1998d916
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

Add allocation and programming of CXL cache ids for struct
cxl_cachedevs as part of cxl_cache::probe(). Programming only occurs
when system firmware has not already programmed an id and the device is
*not* using HDM-D flows. Cache id allocation for HDM-D devices will be
added in a later commit ("cxl/core": Add support for HDM-D cache id
programming").

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c      |  21 ++-
 drivers/cxl/core/cache.c | 337 ++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h        |  10 ++
 drivers/cxl/cxlcache.h   |   2 +
 4 files changed, 359 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 6c098010149a..0fc8f413c638 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -124,6 +124,7 @@ static void deprogram_cache_id(void *_cxlcd)
 		return;
 
 	guard(device)(&hb->dev);
+	cxl_cachedev_deprogram_cache_id(cxlcd);
 	cxl_free_cache_id(cxlcd);
 }
 
@@ -152,20 +153,26 @@ static int program_cache_id(struct cxl_cachedev *cxlcd)
 		return num_cachedevs > 1 ? -ENXIO : 0;
 
 	rc = cxl_cachedev_validate_cache_id(cxlcd);
-	if (rc && num_cachedevs > 1) {
+	if (!rc)
+		return cxl_allocate_cache_id(cxlcd);
+
+	if (cxlcd->cxlds->hdmd) {
 		dev_err(dev,
-			"Cache id not programmed with other CXL.cache devices present: %d\n",
-			rc);
-		return rc;
-	} else if (rc) {
-		cxlcd->cache_id = 0;
+			"Cache id programming not supported for HDM-D devices\n");
+		return -ENXIO;
 	}
 
 	rc = cxl_allocate_cache_id(cxlcd);
 	if (rc)
 		return rc;
 
-	return 0;
+	rc = cxl_cachedev_program_cache_id(cxlcd);
+	if (rc) {
+		dev_err(dev, "Failed to program cache id: %d\n", rc);
+		cxl_free_cache_id(cxlcd);
+	}
+
+	return rc;
 }
 
 /**
diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
index be570d3dc609..9c6c8ea713ef 100644
--- a/drivers/cxl/core/cache.c
+++ b/drivers/cxl/core/cache.c
@@ -1,11 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) Advanced Micro Device, Inc. */
 
+#include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <cxlcache.h>
 
 #include "cxlpci.h"
 
+#define CXL_CACHE_ID_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
+#define CACHE_DECODER_MAX_CACHE_ID (15)
+
 int cxl_port_map_cache_id_rt(struct cxl_port *port)
 {
 	struct cxl_register_map *map = &port->reg_map;
@@ -112,6 +116,260 @@ static int cache_idrt_entry_valid(struct cxl_port *port, int id)
 	return FIELD_GET(CXL_CACHE_ID_RT_TARGETN_VALID, entry);
 }
 
+static unsigned long __cxl_cid_get_timeout_us(struct device *dev,
+					      unsigned int scale,
+					      unsigned int base)
+{
+	static const unsigned long scale_tbl[] = {
+		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
+	};
+
+	if (scale >= ARRAY_SIZE(scale_tbl) || !base) {
+		dev_dbg(dev,
+			"Invalid Cache ID commit timeout: scale=%u base=%u\n",
+			scale, base);
+		return CXL_CACHE_ID_COMMIT_MAXTMO_US;
+	}
+
+	return scale_tbl[scale] * base;
+}
+
+static int __cxl_cid_wait_commit(struct device *dev, void __iomem *status_reg,
+				 u32 commit_bit, u32 err_bit,
+				 unsigned int scale, unsigned int base)
+{
+	unsigned long tmo_us, poll_us;
+	ktime_t start;
+	u32 status;
+	int rc;
+
+	tmo_us = min_t(unsigned long, CXL_CACHE_ID_COMMIT_MAXTMO_US,
+		       __cxl_cid_get_timeout_us(dev, scale, base));
+	poll_us = max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
+	start = ktime_get();
+
+	rc = readx_poll_timeout(readl, status_reg, status,
+				status & (commit_bit | err_bit), poll_us,
+				tmo_us);
+	if (rc) {
+		dev_err(dev, "Cache ID commit timed out\n");
+		return rc;
+	}
+
+	if (status & err_bit) {
+		dev_err(dev, "Cache ID commit rejected by hardware\n");
+		return -EIO;
+	}
+
+	dev_dbg(dev, "Cache ID commit took %lluus\n",
+		ktime_to_us(ktime_sub(ktime_get(), start)));
+	return 0;
+}
+
+static int cxl_cid_commit_decoder(struct cxl_dport *dport)
+{
+	void __iomem *ciddc = dport->regs.ciddc;
+	u32 cap, ctrl, status;
+	u8 scale, base;
+	int rc;
+
+	cap = readl(ciddc + CXL_CACHE_ID_DC_CAP_OFFSET);
+	if (!FIELD_GET(CXL_CACHE_ID_DC_CAP_COMMIT_REQ, cap))
+		return 0;
+
+	status = readl(ciddc + CXL_CACHE_ID_DC_STATUS_OFFSET);
+	scale = FIELD_GET(CXL_CACHE_ID_DC_STATUS_TM_SCALE, status);
+	base = FIELD_GET(CXL_CACHE_ID_DC_STATUS_TM_BASE, status);
+
+	ctrl = readl(ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
+	if (FIELD_GET(CXL_CACHE_ID_DC_CTRL_COMMIT, ctrl)) {
+		ctrl &= ~CXL_CACHE_ID_DC_CTRL_COMMIT;
+		writel(ctrl, ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
+	}
+
+	ctrl |= CXL_CACHE_ID_DC_CTRL_COMMIT;
+	writel(ctrl, ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
+
+	rc = __cxl_cid_wait_commit(dport->dport_dev,
+				   ciddc + CXL_CACHE_ID_DC_STATUS_OFFSET,
+				   CXL_CACHE_ID_DC_STATUS_COMMITTED,
+				   CXL_CACHE_ID_DC_STATUS_COMMIT_ERR, scale,
+				   base);
+	if (rc) {
+		ctrl &= ~CXL_CACHE_ID_DC_CTRL_COMMIT;
+		writel(ctrl, ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
+	}
+
+	return rc;
+}
+
+static int cxl_cid_program_decoder(struct cxl_dport *dport, int cid,
+				   bool endpoint)
+{
+	void __iomem *ciddc = dport->regs.ciddc;
+	u32 ctrl;
+
+	if (!ciddc)
+		return -EINVAL;
+
+	ctrl = readl(ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
+
+	/*
+	 * The decoder may have been programmed before, so we zero out
+	 * all the fields before writing to them
+	 */
+	ctrl &= ~(CXL_CACHE_ID_DC_CTRL_ASGN_ID | CXL_CACHE_ID_DC_CTRL_FWD_ID);
+	if (endpoint) {
+		ctrl |= CXL_CACHE_ID_DC_CTRL_ASGN_ID;
+	} else {
+		ctrl |= CXL_CACHE_ID_DC_CTRL_FWD_ID;
+	}
+
+	FIELD_MODIFY(CXL_CACHE_ID_DC_CTRL_LOCAL_ID, &ctrl, cid);
+	writel(ctrl, ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
+
+	return cxl_cid_commit_decoder(dport);
+}
+
+static int cxl_cid_commit_table(struct cxl_port *port)
+{
+	void __iomem *cidrt = port->regs.cidrt;
+	u32 cap, ctrl, status;
+	u8 scale, base;
+	int rc;
+
+	cap = readl(cidrt + CXL_CACHE_ID_RT_CAP_OFFSET);
+	if (!FIELD_GET(CXL_CACHE_ID_RT_CAP_COMMIT_REQ, cap))
+		return 0;
+
+	status = readl(cidrt + CXL_CACHE_ID_RT_STATUS_OFFSET);
+	scale = FIELD_GET(CXL_CACHE_ID_RT_STATUS_TM_SCALE, status);
+	base = FIELD_GET(CXL_CACHE_ID_RT_STATUS_TM_BASE, status);
+
+	ctrl = readl(cidrt + CXL_CACHE_ID_RT_CTRL_OFFSET);
+	if (FIELD_GET(CXL_CACHE_ID_RT_CTRL_COMMIT, ctrl)) {
+		ctrl &= ~CXL_CACHE_ID_RT_CTRL_COMMIT;
+		writel(ctrl, cidrt + CXL_CACHE_ID_RT_CTRL_OFFSET);
+	}
+
+	ctrl |= CXL_CACHE_ID_RT_CTRL_COMMIT;
+	writel(ctrl, cidrt + CXL_CACHE_ID_RT_CTRL_OFFSET);
+
+	rc = __cxl_cid_wait_commit(&port->dev,
+				   cidrt + CXL_CACHE_ID_RT_STATUS_OFFSET,
+				   CXL_CACHE_ID_RT_STATUS_COMMITTED,
+				   CXL_CACHE_ID_RT_STATUS_COMMIT_ERR, scale,
+				   base);
+	if (rc) {
+		ctrl &= ~CXL_CACHE_ID_RT_CTRL_COMMIT;
+		writel(ctrl, cidrt + CXL_CACHE_ID_RT_CTRL_OFFSET);
+	}
+
+	return rc;
+}
+
+static int cxl_cid_program_table_entry(struct cxl_port *port, int cid,
+				       unsigned int dport_id)
+{
+	void __iomem *cidrt = port->regs.cidrt;
+	u8 target_cnt, portn;
+	u16 target_n;
+	u32 cap;
+
+	if (!cidrt)
+		return -EINVAL;
+
+	cap = readl(cidrt + CXL_CACHE_ID_RT_CAP_OFFSET);
+	target_cnt = FIELD_GET(CXL_CACHE_ID_RT_CAP_TARGET_CNT, cap);
+
+	/* Shouldn't be possible, but better to be safe */
+	if (cid >= target_cnt) {
+		dev_err(&port->dev,
+			"Tried to allocate cache ID (%d) larger than table size (%d)\n",
+			cid, target_cnt);
+		return -EINVAL;
+	}
+
+	target_n = readw(cidrt + CXL_CACHE_ID_RT_TARGETN_OFFSET(cid));
+	if (FIELD_GET(CXL_CACHE_ID_RT_TARGETN_VALID, target_n)) {
+		portn = FIELD_GET(CXL_CACHE_ID_RT_TARGETN_PORTN, target_n);
+		return dport_id == portn ? 0 : -EINVAL;
+	}
+
+	target_n = CXL_CACHE_ID_RT_TARGETN_VALID;
+	target_n |= FIELD_PREP(CXL_CACHE_ID_RT_TARGETN_PORTN, dport_id);
+	writew(target_n, cidrt + CXL_CACHE_ID_RT_TARGETN_OFFSET(cid));
+
+	return cxl_cid_commit_table(port);
+}
+
+static void cxl_cid_invalidate_table_entry(struct cxl_port *port, int cid)
+{
+	void __iomem *cidrt = port->regs.cidrt;
+	u8 target_cnt;
+	u16 target_n;
+	u32 cap;
+	int rc;
+
+	if (!cidrt)
+		return;
+
+	cap = readl(cidrt + CXL_CACHE_ID_RT_CAP_OFFSET);
+	target_cnt = FIELD_GET(CXL_CACHE_ID_RT_CAP_TARGET_CNT, cap);
+
+	/* Shouldn't be possible, but better to be safe */
+	if (cid >= target_cnt) {
+		dev_err(&port->dev,
+			"Tried to free cache ID (%d) larger than table size (%d)\n",
+			cid, target_cnt);
+		return;
+	}
+
+	target_n = readw(cidrt + CXL_CACHE_ID_RT_TARGETN_OFFSET(cid));
+	if (!FIELD_GET(CXL_CACHE_ID_RT_TARGETN_VALID, target_n))
+		return;
+
+	target_n &= ~CXL_CACHE_ID_RT_TARGETN_VALID;
+	writew(target_n, cidrt + CXL_CACHE_ID_RT_TARGETN_OFFSET(cid));
+
+	rc = cxl_cid_commit_table(port);
+	if (rc)
+		dev_warn(
+			&port->dev,
+			"Failed to commit invalidation of cache id table entry %d: %d\n",
+			cid, rc);
+}
+
+static int get_max_cid(struct cxl_port *endpoint)
+{
+	struct cxl_port *port = parent_port_of(endpoint);
+	void __iomem *cidrt;
+	u32 cap;
+	u8 cnt;
+
+	if (!port)
+		return -EINVAL;
+
+	while (!is_cxl_root(port) && !is_cxl_root(parent_port_of(port)))
+		port = parent_port_of(port);
+
+	cidrt = port->regs.cidrt;
+	if (!cidrt)
+		return -EINVAL;
+
+	cap = readl(cidrt + CXL_CACHE_ID_RT_CAP_OFFSET);
+	cnt = FIELD_GET(CXL_CACHE_ID_RT_CAP_TARGET_CNT, cap);
+	if (cnt == 0)
+		return 0;
+
+	/*
+	 * Cache id decoders have 4 bits for the cache id, while target count
+	 * is a 5 bit long field. Limit cache ids to the maximum value allowed
+	 * by cache id decoders.
+	 */
+	return min(CACHE_DECODER_MAX_CACHE_ID, cnt - 1);
+}
+
 static struct ida *find_cache_id_ida(struct cxl_port *port)
 {
 	struct cxl_port *parent = parent_port_of(port);
@@ -130,15 +388,26 @@ static struct ida *find_cache_id_ida(struct cxl_port *port)
 int cxl_allocate_cache_id(struct cxl_cachedev *cxlcd)
 {
 	struct ida *ida = find_cache_id_ida(cxlcd->endpoint);
-	int id;
+	int min, max, id;
 
 	if (!ida)
 		return -ENOSPC;
 
-	id = ida_alloc_range(ida, cxlcd->cache_id, cxlcd->cache_id, GFP_KERNEL);
-	if (id != cxlcd->cache_id)
+	max = get_max_cid(cxlcd->endpoint);
+	if (max < 0 || cxlcd->cache_id > max)
 		return -EINVAL;
 
+	if (cxlcd->cache_id == CXL_CACHE_ID_NO_ID) {
+		min = 0;
+	} else {
+		min = max = cxlcd->cache_id;
+	}
+
+	id = ida_alloc_range(ida, min, max, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	cxlcd->cache_id = id;
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_allocate_cache_id, "cxl_cache");
@@ -196,4 +465,64 @@ int cxl_cachedev_validate_cache_id(struct cxl_cachedev *cxlcd)
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_cachedev_validate_cache_id, "cxl_cache");
->>>>>>> conflict 1 of 1 ends
+
+static void __deprogram_cache_id(struct cxl_cachedev *cxlcd,
+				 struct cxl_port *stop)
+{
+	struct cxl_port *iter = cxlcd->endpoint->parent_dport->port;
+
+	/*
+	 * Leave cache id decoders programmed; the table entry being invalidated
+	 * should be enough
+	 */
+	while (!is_cxl_root(iter)) {
+		cxl_cid_invalidate_table_entry(iter, cxlcd->cache_id);
+
+		if (iter == stop)
+			return;
+
+		iter = parent_port_of(iter);
+	}
+}
+
+int cxl_cachedev_program_cache_id(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_dport *dport = cxlcd->endpoint->parent_dport;
+	struct cxl_port *port = dport->port;
+	bool endpoint = true;
+	int rc;
+
+	while (!is_cxl_root(port)) {
+		rc = cxl_cid_program_decoder(dport, cxlcd->cache_id,
+					     endpoint);
+		if (rc)
+			goto err;
+
+		rc = cxl_cid_program_table_entry(port, cxlcd->cache_id,
+						 dport->port_id);
+		if (rc)
+			goto err;
+
+		endpoint = false;
+		dport = port->parent_dport;
+		port = dport->port;
+	}
+
+	return 0;
+
+err:
+	__deprogram_cache_id(cxlcd, port);
+	return rc;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_cachedev_program_cache_id, "cxl_cache");
+
+void cxl_cachedev_deprogram_cache_id(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_root *root = find_cxl_root(cxlcd->endpoint);
+
+	if (!root)
+		return;
+
+	__deprogram_cache_id(cxlcd, &root->port);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_cachedev_deprogram_cache_id, "cxl_cache");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ed6b56a269ee..4cdc26dbdb6a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -230,10 +230,16 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_CACHE_ID_RT_CAP_OFFSET 0x0
 #define   CXL_CACHE_ID_RT_CAP_TARGET_CNT GENMASK(4, 0)
 #define   CXL_CACHE_ID_RT_CAP_COMMIT_REQ BIT(16)
+#define CXL_CACHE_ID_RT_CTRL_OFFSET 0x4
+#define   CXL_CACHE_ID_RT_CTRL_COMMIT BIT(0)
 #define CXL_CACHE_ID_RT_STATUS_OFFSET 0x8
 #define   CXL_CACHE_ID_RT_STATUS_COMMITTED BIT(0)
+#define   CXL_CACHE_ID_RT_STATUS_COMMIT_ERR BIT(1)
+#define   CXL_CACHE_ID_RT_STATUS_TM_SCALE GENMASK(11, 8)
+#define   CXL_CACHE_ID_RT_STATUS_TM_BASE GENMASK(15, 12)
 #define CXL_CACHE_ID_RT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
 #define   CXL_CACHE_ID_RT_TARGETN_VALID BIT(0)
+#define   CXL_CACHE_ID_RT_TARGETN_PORTN GENMASK(15, 8)
 
 /* CXL 4.0 8.2.4.29.1 CXL Cache ID Decoder Capability Structure */
 #define CXL_CACHE_ID_DC_CAP_OFFSET 0x0
@@ -242,10 +248,14 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_CACHE_ID_DC_CTRL_FWD_ID BIT(0)
 #define   CXL_CACHE_ID_DC_CTRL_ASGN_ID BIT(1)
 #define   CXL_CACHE_ID_DC_CTRL_HDMD_PRESENT BIT(2)
+#define   CXL_CACHE_ID_DC_CTRL_COMMIT BIT(3)
 #define   CXL_CACHE_ID_DC_CTRL_HDMD_ID GENMASK(11, 8)
 #define   CXL_CACHE_ID_DC_CTRL_LOCAL_ID GENMASK(19, 16)
 #define CXL_CACHE_ID_DC_STATUS_OFFSET 0x8
 #define   CXL_CACHE_ID_DC_STATUS_COMMITTED BIT(0)
+#define   CXL_CACHE_ID_DC_STATUS_COMMIT_ERR BIT(1)
+#define   CXL_CACHE_ID_DC_STATUS_TM_SCALE GENMASK(11, 8)
+#define   CXL_CACHE_ID_DC_STATUS_TM_BASE GENMASK(15, 12)
 #define CXL_CACHE_ID_DC_CAPABILITY_LENGTH 0xC
 
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index 1e4a1e61ad7b..72d58eded292 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -45,4 +45,6 @@ bool cxl_cache_id_supported(struct cxl_cachedev *cxlcd);
 int cxl_allocate_cache_id(struct cxl_cachedev *cxlcd);
 void cxl_free_cache_id(struct cxl_cachedev *cxlcd);
 int cxl_cachedev_validate_cache_id(struct cxl_cachedev *cxlcd);
+int cxl_cachedev_program_cache_id(struct cxl_cachedev *cxlcd);
+void cxl_cachedev_deprogram_cache_id(struct cxl_cachedev *cxlcd);
 #endif
-- 
2.53.0

