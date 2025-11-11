Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1C35C185
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897431; cv=fail; b=SKHRrXkQ3wlUZH6kMlFbRX10eaRTvDLp7GIYFDxfHN2ejhYsNJvi6CJewgWCZLwFkZIX4kjpb/CSW7ayGo186jtmQINSamxcmIwLNoeUNBIDHiYk19kYInb/dFnrmjA3lJWDeKRp7fd55cGtc7z3svSLmZCLCgxiHU5wGJ3EM1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897431; c=relaxed/simple;
	bh=m8IGTIhMUnks6keLr73OPlLrunMEiW5aGlaf45iJ5/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRglw5rrZcnPEChY5vy9/V9TXwVi/WuZbT/uCzKHTELpJ6J5Q1FeqlbddMhPCqv11etsuEugwCymv+mBi7YQi1AtjoKB7ZixMXO6dZzemV7wjalM0VVqQPLO3c0W7s2cgrV+ljlVMfDiRFvRvg86tymeBJs6t42OaLd9GCNjgHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cmqqj0ef; arc=fail smtp.client-ip=40.93.194.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cmqqj0ef"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ36aF/oWtNNLGyUTUrUiCVtbQqTXg1XGuUxgUjTl2PTwLniIIRphI0SwWYVmE1G3Q+c82dEAZ6kgSEZWHeQvhI+dPQwQH2AQ/jc6bzkqJF5R1gefURYY2IPbmWtB1XnhpCe3pFWWL47kEReujy7WSZPeTv3mIZnqDlcYlDzwexXv1ARN8PwLdWSu0KWL2XfEq685X1OPlLrxYZp0OfQQfy/Bj6RH7/bwz0AGXwg38bWx2xKoqJzFjWbK7aPgzCevYaXmI1jjO3cacoUArYhEVxTamonUKEqP1SRuAnqPmf4ttIgVMgsdLozbwshb1Ub1dte4dpJxA3Ssh1kAbNTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzPlpa7lfn/26OXhsrJ1HXCVJGXGJHEUx3YliAliSLs=;
 b=vUp6Y7fNdSpIp9vHGunSxmvj4eTc48e4oiTK75X6u8FMcEl9Bghsm0eIhUTVXDMDY6k3DfuT83rJGofmS77hcjCbtG5dP1UXWaGNuAu26mfxxT+zWlCQICY+EUyJXDUHeOGwKvhUecNEcGyK3FAOkp8K5Zo2l0qXczn2jN2ocMoUwDAJyhfxDOlAvZMjPGNOta0XZjTCI3km36t2uv/FTk5otrevCwsXVFypX8ciPCSsT+Wqr/5Jkeri9ULvgyfk14citD7KDCbF/Uq5MxULOOWG3Jv/rBLxZZVBPiK+iF8WD4vAptBfTSZVCYWEFwVJCuimtDjr+awLjOSpDEBZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzPlpa7lfn/26OXhsrJ1HXCVJGXGJHEUx3YliAliSLs=;
 b=Cmqqj0efK9P88IV0Jxkz09pRZ0uWPoW6syKrHoV6nu70KqY7I3CQj/+srTEXCfT98GNAHeqMR/f47vCje0oFVZmv7qceKt4Qof9mH1ulv8SlDwtSjp6thfsjIrNKsB0QiwOasNK/CSW9d3AU+ysPj7ideOernmGre2Un78ZbToE=
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by CY1PR12MB9602.namprd12.prod.outlook.com (2603:10b6:930:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 21:43:39 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::21) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 21:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:43:37 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:43:33 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 14/17] cxl/port: Add cache id programming
Date: Tue, 11 Nov 2025 15:40:29 -0600
Message-ID: <20251111214032.8188-15-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CY1PR12MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ac2b0d-ded8-4354-2d73-08de216b5f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZQ7DJYC7zcvR53m//mDP0ww8bNQmOrunGpzoGh0AaTXkEjQnIpdLUgrIgQir?=
 =?us-ascii?Q?3msJyBXkEVTq9IMAIKjLHUCcRFstpox5mPGbrNgtkAJBr/mMEgXNUaiytcg5?=
 =?us-ascii?Q?gdlCjBGw/09cNSuwxAZRJWKuvk7NNYg3aDr5jwYeQSG7e6ZjreK3J7uh5tXs?=
 =?us-ascii?Q?/+wwvyJRVA5s9UGX619e8xRvZrYPMGKl/pzD0eVJLmRH7PTF420Y+FDCXBXf?=
 =?us-ascii?Q?JDLwYU7p5PcO+IzpSK/BNd9xiSeaJ9NSOmjfscI0geWobgc2hFBFcP6t3lam?=
 =?us-ascii?Q?1puVppSmeoFLioiMTH59qm899KUS2Vdx4GfswKgkVdSek+VMfWcdIm7UcIEI?=
 =?us-ascii?Q?wziaJY3c7H5NkhXlRKDuHq4rS5hQKAqJ/dyL4ubGHctKZhgiEYZ4E5zt4fxF?=
 =?us-ascii?Q?TDCbD8jYBfROLpPhkIiXxe+iwKxbDq6tHSfZUU43HK+aXIPp4i+6FlRarLx+?=
 =?us-ascii?Q?odfcLFjS5U1IwAuivaVF9D9uMEv1G82gpSTm0JBXGV8WrjGI1Nuv+DgKhbLs?=
 =?us-ascii?Q?S5e5NKdFPT4Ml5GN7M/eSmcGmZ6xa+03HulXO0hXuk9MC9+CZihx6jAZtqCv?=
 =?us-ascii?Q?2QXFUDswn+ijjQdQFnMvCQt9CfCPIknWin9tjWaUdxjvlvzc2FYX+r26iKmm?=
 =?us-ascii?Q?Uvp+gL68Tp1oaxlBs88BoH9vVQ3oBxueuo7hnxS6behWkDxJqmh03Vo+P6Ox?=
 =?us-ascii?Q?nLw97QQ4Sm0sMssy0LtX+/5XEAlRZ9xd06VvwoqGb9b14U0v4zJnhKO31Bxk?=
 =?us-ascii?Q?HvJzo7EqTPIpdGR3rckJCWeab1DpWIbt8bVxtSPO/SXkJUIvGAk67GFp8LKY?=
 =?us-ascii?Q?2HQ9SbxyzF7hbgYUKDQuHsLFtXjrJ+Yrp+nXP9O6qrbYFkTlHDlSFBetbyXV?=
 =?us-ascii?Q?jlNA6bwi/74cEpm/sL4776Re1JXWQ4CwKAXxxoHKqUSmlPhim8eQRyKg5PDi?=
 =?us-ascii?Q?AtR4Eh/5EKVN8vE4WLH7jCdK09ad7J7FMfx3aOi3O7DfQ7OiljxwrTpvkSIW?=
 =?us-ascii?Q?qxkdejDIYU8BYkhF6oQIQRTNgiJ0DJ1orrAffxr6/QbN3FRiiWrpfcvNMQUa?=
 =?us-ascii?Q?/Kfo/pH25/TRaONAP903EGoID63dHd4PvnhZB4Ab040niiYLfbh4D9mstpbX?=
 =?us-ascii?Q?4pt1p6XhnOlePLqB2JvsUtvOGorOzpyuXZr3WJtvmwPvD4wTjI+p9Cs7uGze?=
 =?us-ascii?Q?2Rm38i99YW+uKWmigNFW2oY9Ew+5Y2mlCN73U0zAbghBvwDAYYAOh3F9JT+o?=
 =?us-ascii?Q?oYrTfNuLDIfVuoiRfUVTbckYNtN5lxDE2pBRgWvNlQhQcTM8gcF6rlWNwNXE?=
 =?us-ascii?Q?3uraDaoTIqHcbXCLGoibsakQbofQibO/LkFSBA65wBYkOMjaif7OdpXNW/pW?=
 =?us-ascii?Q?WLyAx6TqBZPGcJzJQOnP+21q6aZ+VxWcmpGz1oelZg432JZy8lGIDTltr2Dy?=
 =?us-ascii?Q?vTAjyg65OkKNLGAk2bvGVHNS9TQiyvclVV+fxZNYwsuNVzGEJHkE+VLxGIsq?=
 =?us-ascii?Q?N0W0LIskSis155f6eaiw+HIgt3Y1N4BLFNrSsBW0FDbmWkrmLZkCvOwmI20U?=
 =?us-ascii?Q?7NSkiJ82QIxcNKwL/fg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:43:37.6689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ac2b0d-ded8-4354-2d73-08de216b5f58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9602

Add programming cache ids for CXL.cache endpoint devices as part of
cxl_cache_endpoint_probe().

Programming the cache id for a CXL.cache endpoint requires allocating
a cache id beforehand. The cache id can be programmed by the platform
firmware, in which case calling cxl_endpoint_get_cache_id() will return
the pre-programmed id. In the event the id is not programmed call
cxl_endpoint_allocate_cache_id() with a value of CXL_CACHE_ID_NO_ID,
which will return the first available id. Program the relevant cache
id decoders and route tables for a device by calling
devm_cxl_program_cache_id().

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c | 284 +++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h       |  12 ++
 drivers/cxl/port.c      |  27 ++--
 3 files changed, 310 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1504631ae620..e6e25a201ff9 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2546,7 +2546,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_map_cache_id_regs, "CXL");
  * cxl_endpoint_allocate_cache_id - Allocate a cache id @id on the endpoint's
  * host bridge.
  * @endpoint: Endpoint port representing a CXL.cache device
- * @id: Cache id to attempt to allocate
+ * @id: Cache id to attempt to allocate, CXL_CACHE_ID_NO_ID for any id
  *
  * Returns rc < 0 if id allocation fails. Returns allocated id otherwise.
  */
@@ -2570,13 +2570,16 @@ int cxl_endpoint_allocate_cache_id(struct cxl_port *endpoint, int id)
 		nr_hdmd = FIELD_GET(CXL_CACHE_IDRT_CAP_TYPE2_CNT_MASK, cap);
 
 		guard(device)(&hb->dev);
-		if (hb->nr_hdmd + 1 >= nr_hdmd)
+		if (hb->nr_hdmd == nr_hdmd)
 			return -EINVAL;
 
 		hb->nr_hdmd++;
 	}
 
-	return ida_alloc_range(&hb->cache_ida, id, id, GFP_KERNEL);
+	if (id == CXL_CACHE_ID_NO_ID)
+		return ida_alloc(&hb->cache_ida, GFP_KERNEL);
+	else
+		return ida_alloc_range(&hb->cache_ida, id, id, GFP_KERNEL);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_allocate_cache_id, "CXL");
 
@@ -2602,6 +2605,211 @@ void cxl_endpoint_free_cache_id(struct cxl_port *endpoint, int id)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_free_cache_id, "CXL");
 
+static unsigned long cxl_cache_id_compute_timeout(u8 scale, u8 base)
+{
+	unsigned long timeout = base;
+
+	/* Give the hardware 1 millisecond just in case */
+	if (!timeout)
+		timeout = 1;
+
+	/*
+	 * The timeout scale in the cache id decoder status register is encoded
+	 * as 10 ^ (scale) microseconds. So, to convert to millis we multiply by
+	 * 10 until the scale == 1 ms.
+	 */
+	while (scale > 3) {
+		timeout *= 10;
+		scale--;
+	}
+
+	return msecs_to_jiffies(timeout);
+}
+
+static int cxl_commit_cache_decoder(struct cxl_dport *dport)
+{
+	unsigned long timeout, start;
+	u32 cap, ctrl, stat;
+	u8 scale, base;
+
+	cap = readl(dport->regs.cidd + CXL_CACHE_IDD_CAP_OFFSET);
+	if (!(cap & CXL_CACHE_IDD_CAP_COMMIT_REQUIRED))
+		return 0;
+
+	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	if (ctrl & CXL_CACHE_IDD_CTRL_COMMIT) {
+		ctrl &= ~CXL_CACHE_IDD_CTRL_COMMIT;
+		writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	}
+
+	stat = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	scale = FIELD_PREP(CXL_CACHE_IDD_STAT_TIME_SCALE_MASK, stat);
+	base = FIELD_PREP(CXL_CACHE_IDD_STAT_TIME_BASE_MASK, stat);
+	timeout = cxl_cache_id_compute_timeout(scale, base);
+
+	ctrl &= CXL_CACHE_IDD_CTRL_COMMIT;
+	writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+
+	start = jiffies;
+	do {
+		stat = readl(dport->regs.cidd + CXL_CACHE_IDD_STAT_OFFSET);
+		if (stat & CXL_CACHE_IDD_STAT_COMMITTED)
+			return 0;
+
+		if (stat & CXL_CACHE_IDD_STAT_ERR_COMMIT)
+			return -EBUSY;
+	} while (time_before(start, start + timeout));
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_program_cache_decoder(struct cxl_dport *dport, int id,
+				     bool hdmd, bool endpoint)
+{
+	u32 ctrl, orig;
+	int rc;
+
+	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	orig = ctrl;
+
+	if (endpoint) {
+		ctrl &= CXL_CACHE_IDD_CTRL_ASGN_ID;
+		ctrl &= FIELD_PREP(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK, id);
+	} else {
+		ctrl &= CXL_CACHE_IDD_CTRL_FWD_ID;
+	}
+
+	if (hdmd) {
+		ctrl &= CXL_CACHE_IDD_CTRL_TYPE2;
+		ctrl &= FIELD_PREP(CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK, id);
+	}
+
+	if (ctrl == orig)
+		return 0;
+
+	writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+
+	rc = cxl_commit_cache_decoder(dport);
+	if (rc)
+		writel(orig, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+
+	return rc;
+}
+
+static int cxl_commit_cache_idrt(struct cxl_port *port)
+{
+	unsigned long timeout, start;
+	u32 cap, ctrl, stat;
+	u8 scale, base;
+
+	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
+	if (!(cap & CXL_CACHE_IDRT_CAP_COMMIT_REQUIRED))
+		return 0;
+
+	ctrl = readl(port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
+	if (ctrl & CXL_CACHE_IDRT_CTRL_COMMIT) {
+		ctrl &= ~CXL_CACHE_IDRT_CTRL_COMMIT;
+		writel(ctrl, port->regs.cidd + CXL_CACHE_IDRT_CTRL_OFFSET);
+	}
+
+	stat = readl(port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
+	scale = FIELD_PREP(CXL_CACHE_IDRT_STAT_TIME_SCALE_MASK, stat);
+	base = FIELD_PREP(CXL_CACHE_IDRT_STAT_TIME_BASE_MASK, stat);
+	timeout = cxl_cache_id_compute_timeout(scale, base);
+
+	ctrl &= CXL_CACHE_IDRT_CTRL_COMMIT;
+	writel(ctrl, port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
+
+	start = jiffies;
+	do {
+		stat = readl(port->regs.cidrt + CXL_CACHE_IDRT_STAT_OFFSET);
+		if (stat & CXL_CACHE_IDRT_STAT_COMMITTED)
+			return 0;
+
+		if (stat & CXL_CACHE_IDRT_STAT_ERR_COMMIT)
+			return -EBUSY;
+	} while (time_before(jiffies, start + timeout));
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_program_cache_idrt_entry(struct cxl_port *port, int id,
+					struct cxl_dport *dport, bool valid)
+{
+	u16 target, orig;
+	int rc;
+
+	target = readw(port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
+	orig = target;
+
+	/*
+	 * Touching the port number field while the entry is valid is
+	 * undefined behavior.
+	 */
+	if (target & CXL_CACHE_IDRT_TARGETN_VALID && valid) {
+		if (FIELD_GET(CXL_CACHE_IDRT_TARGETN_PORTN, target) !=
+		    dport->port_id)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	target = FIELD_PREP(CXL_CACHE_IDRT_TARGETN_PORTN, dport->port_id);
+	if (valid)
+		target &= CXL_CACHE_IDRT_TARGETN_VALID;
+	else
+		target &= ~CXL_CACHE_IDRT_TARGETN_VALID;
+
+	if (orig == target)
+		return 0;
+
+	writew(target, port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
+	rc = cxl_commit_cache_idrt(port);
+	if (rc)
+		writew(orig,
+		       port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
+
+	return rc;
+}
+
+static DECLARE_RWSEM(cache_id_rwsem);
+
+static void __cxl_endpoint_deprogram_cache_id(struct cxl_port *ep,
+					      struct cxl_port *stop, int id)
+{
+	struct cxl_dport *dport = ep->parent_dport;
+	struct cxl_port *port = parent_port_of(ep);
+	int rc;
+
+	while (port != stop) {
+		dport->nr_cachedevs--;
+		if (dport->nr_cachedevs == 0) {
+			rc = cxl_program_cache_idrt_entry(port, id, dport, false);
+			if (rc)
+				dev_warn(&port->dev,
+					 "failed to decommit cache id target%d\n",
+					 id);
+		}
+
+		dport = port->parent_dport;
+		port = parent_port_of(port);
+	}
+}
+
+struct cxl_cache_id_ctx {
+	struct cxl_port *endpoint;
+	struct cxl_port *stop;
+	int id;
+};
+
+static void cxl_endpoint_deprogram_cache_id(void *data)
+{
+	struct cxl_cache_id_ctx *ctx = data;
+
+	guard(rwsem_write)(&cache_id_rwsem);
+	__cxl_endpoint_deprogram_cache_id(ctx->endpoint, ctx->stop, ctx->id);
+}
+
 /**
  * cxl_endpoint_get_cache_id - Get the cache id of a CXL.cache endpoint device
  * @endpoint: Endpoint port representing cache device
@@ -2614,11 +2822,19 @@ int cxl_endpoint_get_cache_id(struct cxl_port *endpoint, int *cid)
 {
 	struct cxl_dport *dport = endpoint->parent_dport;
 	struct cxl_port *port = parent_port_of(endpoint);
+	struct cxl_cachedev *cxlcd;
 	bool ep = true;
 
-	if (!cid)
+	if (!cid || !is_cxl_cachedev(endpoint->uport_dev))
 		return -EINVAL;
+	cxlcd = to_cxl_cachedev(endpoint->uport_dev);
 
+	struct cxl_cache_id_ctx *ctx __free(kfree) =
+		kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	guard(rwsem_read)(&cache_id_rwsem);
 	*cid = cxl_dport_get_cache_id(dport, port);
 
 	while (!is_cxl_root(port)) {
@@ -2639,10 +2855,68 @@ int cxl_endpoint_get_cache_id(struct cxl_port *endpoint, int *cid)
 		ep = false;
 	}
 
-	return 0;
+	*ctx = (struct cxl_cache_id_ctx) {
+		.endpoint = endpoint,
+		.stop = port,
+		.id = *cid,
+	};
+
+	return devm_add_action(&cxlcd->dev, cxl_endpoint_deprogram_cache_id,
+			       no_free_ptr(ctx));
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_cache_id, "CXL");
 
+int devm_cxl_endpoint_program_cache_id(struct cxl_port *endpoint, int id)
+{
+	struct cxl_dport *dport = endpoint->parent_dport;
+	struct cxl_port *port = parent_port_of(endpoint);
+	struct cxl_cachedev *cxlcd;
+	bool hdmd, ep = true;
+	int rc;
+
+	if (!is_cxl_cachedev(endpoint->uport_dev))
+		return -EINVAL;
+
+	struct cxl_cache_id_ctx *ctx __free(kfree) =
+		kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	cxlcd = to_cxl_cachedev(endpoint->uport_dev);
+	hdmd = cxl_cachedev_is_type2(cxlcd) && cxlcd->cxlds->hdmd;
+
+	guard(rwsem_write)(&cache_id_rwsem);
+	while (!is_cxl_root(port)) {
+		rc = cxl_program_cache_idrt_entry(port, id, dport, true);
+		if (rc)
+			goto err;
+
+		rc = cxl_program_cache_decoder(dport, id, hdmd, ep);
+		if (rc)
+			goto err;
+
+		ep = false;
+		dport->nr_cachedevs++;
+		dport = port->parent_dport;
+		port = parent_port_of(port);
+	}
+
+	*ctx = (struct cxl_cache_id_ctx) {
+		.endpoint = endpoint,
+		.stop = port,
+		.id = id,
+	};
+
+	return devm_add_action_or_reset(&cxlcd->dev,
+					cxl_endpoint_deprogram_cache_id,
+					no_free_ptr(ctx));
+
+err:
+	__cxl_endpoint_deprogram_cache_id(endpoint, parent_port_of(port), id);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_endpoint_program_cache_id, "CXL");
+
 /**
  * __cxl_driver_register - register a driver for the cxl bus
  * @cxl_drv: cxl driver structure to attach
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f4dc912d67ed..7919c4466b0c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -166,8 +166,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_CACHE_IDRT_CAP_CNT_MASK GENMASK(4, 0)
 #define   CXL_CACHE_IDRT_CAP_TYPE2_CNT_MASK GENMASK(11, 8)
 #define   CXL_CACHE_IDRT_CAP_COMMIT_REQUIRED BIT(16)
+#define CXL_CACHE_IDRT_CTRL_OFFSET 0x4
+#define   CXL_CACHE_IDRT_CTRL_COMMIT BIT(0)
 #define CXL_CACHE_IDRT_STAT_OFFSET 0x8
 #define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
+#define   CXL_CACHE_IDRT_STAT_ERR_COMMIT BIT(1)
+#define   CXL_CACHE_IDRT_STAT_TIME_SCALE_MASK GENMASK(11, 8)
+#define   CXL_CACHE_IDRT_STAT_TIME_BASE_MASK GENMASK(15, 12)
 #define CXL_CACHE_IDRT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
 #define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
 #define   CXL_CACHE_IDRT_TARGETN_PORTN GENMASK(15, 8)
@@ -179,10 +184,14 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_CACHE_IDD_CTRL_FWD_ID BIT(0)
 #define   CXL_CACHE_IDD_CTRL_ASGN_ID BIT(1)
 #define   CXL_CACHE_IDD_CTRL_TYPE2 BIT(2)
+#define   CXL_CACHE_IDD_CTRL_COMMIT BIT(3)
 #define   CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK GENMASK(11, 8)
 #define   CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK GENMASK(19, 16)
 #define CXL_CACHE_IDD_STAT_OFFSET 0x8
 #define   CXL_CACHE_IDD_STAT_COMMITTED BIT(0)
+#define   CXL_CACHE_IDD_STAT_ERR_COMMIT BIT(1)
+#define   CXL_CACHE_IDD_STAT_TIME_SCALE_MASK GENMASK(11, 8)
+#define   CXL_CACHE_IDD_STAT_TIME_BASE_MASK GENMASK(15, 12)
 #define CXL_CACHE_IDD_CAPABILITY_LENGTH 0xC
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
@@ -726,6 +735,7 @@ struct cxl_rcrb_info {
  * @coord: access coordinates (bandwidth and latency performance attributes)
  * @link_latency: calculated PCIe downstream latency
  * @gpf_dvsec: Cached GPF port DVSEC
+ * @nr_cachedevs: Number of CXL.cache devices with a cache id below this dport
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -739,6 +749,7 @@ struct cxl_dport {
 	long link_latency;
 	int gpf_dvsec;
 	int snoop_id;
+	int nr_cachedevs;
 };
 
 /**
@@ -990,6 +1001,7 @@ int cxl_endpoint_map_cache_id_regs(struct cxl_port *endpoint);
 int cxl_endpoint_get_cache_id(struct cxl_port *endpoint, int *cid);
 int cxl_endpoint_allocate_cache_id(struct cxl_port *endpoint, int id);
 void cxl_endpoint_free_cache_id(struct cxl_port *endpoint, int id);
+int devm_cxl_endpoint_program_cache_id(struct cxl_port *endpoint, int id);
 
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c1d1d28bee5c..4cecb731ec5b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -27,6 +27,8 @@
  * PCIe topology.
  */
 
+static DEFINE_MUTEX(cache_id_lock);
+
 static void schedule_detach(void *cxlmd)
 {
 	schedule_cxl_memdev_detach(cxlmd);
@@ -99,30 +101,39 @@ static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
 static void free_cache_id(void *data)
 {
 	struct cxl_cachedev *cxlcd = data;
-	int id = cxlcd->cxlds->cstate.cache_id;
+	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
 
-	cxl_endpoint_free_cache_id(cxlcd->endpoint, id);
+	cxl_endpoint_free_cache_id(cxlcd->endpoint, cstate->cache_id);
+	cstate->cache_id = CXL_CACHE_ID_NO_ID;
 }
 
 static int cxl_cache_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_cachedev *cxlcd = to_cxl_cachedev(port->uport_dev);
-	int rc, id;
+	int rc, orig, id;
 
 	rc = cxl_endpoint_map_cache_id_regs(port);
 	if (rc)
 		return rc;
 
-	rc = cxl_endpoint_get_cache_id(port, &id);
+	guard(mutex)(&cache_id_lock);
+	rc = cxl_endpoint_get_cache_id(port, &orig);
 	if (rc)
 		return rc;
 
-	rc = cxl_endpoint_allocate_cache_id(port, id);
-	if (rc < 0)
-		return rc;
+	id = cxl_endpoint_allocate_cache_id(port, orig);
+	if (id < 0)
+		return id;
 
 	cxlcd->cxlds->cstate.cache_id = id;
-	return devm_add_action_or_reset(&cxlcd->dev, free_cache_id, cxlcd);
+	rc = devm_add_action_or_reset(&cxlcd->dev, free_cache_id, cxlcd);
+	if (rc)
+		return rc;
+
+	if (orig == CXL_CACHE_ID_NO_ID)
+		return devm_cxl_endpoint_program_cache_id(port, id);
+
+	return 0;
 }
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
-- 
2.51.1

