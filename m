Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D256284B49
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034390; cv=fail; b=kIqGdj8bKj5i+vzs1figi5D8jpy0fP254dBSyAle0Xj/eEnrHLYNwyfdyvEGKpQsJTviSafkEEUvhsxT3COlMBLY+7Rs8wkQYX39nibWddHpfb4wQWDV2blpSoUOP6oupP2SxxRK/nZrGn4wnaHjwSQ4AfK8ezE7fxWPdmsEYVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034390; c=relaxed/simple;
	bh=l+1Yg7MEEYuqO0hUfeyRnOJDME7IROg2J1/+Lob1LSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U94GbEaASn9Oel5muJIssUPh0bWatBe8t63SkbyfID0fJhOp1DtK7ku9pRp0lyQgQ9tJ1KVHN8N/BnArUcRIkpYnUmBoP2bmzvLo684UaVyW52v0rC/eue/rD5W+5sc5e5lJkZNN4pL93dCeWXnuzYI9s1Pqqll5J4qdEVdlOGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eLQASMfE; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eLQASMfE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqhMbgT20M3sCZKuqDZYRbF9JLHXQpxMzT9n/wqeArksGasybm2vYpdkwSIK3ZRxiAUo8uecRZw5F/Y6WgRBf8mrQJaR7XORAuPyTcTVaOanOyCE0Q9jdvDHtr42SojiECWmK987WHTCB45jtDjYAeIxFNzY5vNO0oKNV+HKynBiy1U3Fsn3oRSEKqO1/cymiqIcSnZquqGhZOfi+TaHMvo/G7kAD6DAnnkhfkW0UgXEjBpSAcz3CIPLpVX1iZi7mirQuhPM3li4PjcjkBueXtOG3Gw5WMGhK63nGR3y/cK6IbP+Fk/bNbBWzJoaWPXU18Hy39zsFOR82H5xV/nyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp1UmAHWkZ3IVSkjXv0lcP4dsrJt8D5BUmBx9bKkVRE=;
 b=h2Qw1CC2Dw0oaL3CS0Anl+Xk7OHLzMi/5UIZ6VPYWqhcd0VWDwPkeEw0go/nqraOx/ceNYFsGf+DKp6b79g5Ndcr71skeylWv+lN8BRGZbfpe/gJZ9Uy4YetvjOhIXWAoF4hXnj1SQqvbT1jS/SBdSIR0lir30zRSF1guBmE5fBUr5rAHsPO1fqwRsRJ9D11RtRHZI4SjaJE9CECp5fO/quXPZIigb2kq/8/rDYgrHX2idjRjteLMUsM3OwyHu638s+Ji4beKxbslhfzRM+MDXVx4nFLlUMV2/0Y4KPePmhDNhen16XwpU3gVhBuiNTAhCKTJDraAkoakdqtLxKKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp1UmAHWkZ3IVSkjXv0lcP4dsrJt8D5BUmBx9bKkVRE=;
 b=eLQASMfE/wgSJzVq+M5h46BZq07DfO8Ikq6SxZb0HMZgT5CBI8lMYBAaAZvYidJp/3UxCq0Nr83V6q9sSfwmzp0xXCu8lwvTc/rcMzn1XzXHU+1mHVxqRrCccCcpwfy3w5J13aj3GB3gufu8Do/nTgVl+3iL8jayNQbP4PIFxtg=
Received: from DM6PR13CA0011.namprd13.prod.outlook.com (2603:10b6:5:bc::24) by
 MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.13; Tue, 12 Aug 2025 21:33:07 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::ee) by DM6PR13CA0011.outlook.office365.com
 (2603:10b6:5:bc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 21:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:33:06 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:33:05 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 15/18] cxl/cache: Implement Cache ID Decoder programming
Date: Tue, 12 Aug 2025 16:29:18 -0500
Message-ID: <20250812212921.9548-16-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9fafd6-e6dc-4ad6-6d91-08ddd9e7d3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2uGPgo6t+uljfCk/ulFmoKwiQMwnif2Q9IuBZLS+aKflC0kHEBZt3C9D8iE8?=
 =?us-ascii?Q?shV9uCq5OchFuE/wHgVoY9j3gGfjMhan/pSRA9P2RbPvd07f+iodRH5thTDo?=
 =?us-ascii?Q?SONNqt92/xHhaQPyXB0DfB2XU2v/GkHoUP/Ler0MteSX2E/Fiw96ngEdToQB?=
 =?us-ascii?Q?n5u+miyRi1gLv8o+fZEknWvttOX11dw+cDtTj5xrtEAG/kEPNe5Nqv5xUGYy?=
 =?us-ascii?Q?q4JVzUVDd0Oc/Q+M6MZudQC1lfeSPyHuYcDvwoc+QSTAd1IlG0tg+DLVXbSj?=
 =?us-ascii?Q?zWfrRtgNAvYf1hAMJfEeGfEK1IPJDI7bd4MEi10es9D0sqXvlwr6w/xRZo/H?=
 =?us-ascii?Q?rCcq5hY4YNcaIuwcOGiuOVTcTz7YK0QHF74m/jmLrBUxz8+vlMjs17ekYrzP?=
 =?us-ascii?Q?BIQvqTmx8UjVQO7klXWUCm0Pjcv55RCDrSOkex0DXJt1fYTeZuWzZjTI/MlV?=
 =?us-ascii?Q?E6SYYx7IR3DD1knDb4U9hUG7j8xxgQaX6zJzSZHFUN3U6LUjJS5wXXgxHRkN?=
 =?us-ascii?Q?b6FeInZUGg7Ktk5AFQvYf5Qd7e7c+SNF9YZG1v/sRlwbfG/8B3Sf17Yj5eGJ?=
 =?us-ascii?Q?HdNsJuDSsRK70Z8phhl4XAxhof8Xk+Nf/tBRtQYOHHYYGnRwkZju+nby1eLc?=
 =?us-ascii?Q?D8ZITZeQMxJr30bcpRQTyRG7Y9xEDVEXDwbyVSCM5XZMqwozOAexeEBfz+AI?=
 =?us-ascii?Q?NOxVBR+Zr18cgkmKPfxd1/MJalj6hpd3QUI6wGs7aDc+Thg5o6+0WqUpXseo?=
 =?us-ascii?Q?HaVpNC/Evij+VCZKT5wUH8agDSsJIYKKkzO+ikaYU8+/ZhjlTg0JKgyFRa6X?=
 =?us-ascii?Q?ljt3Hqk3Fdx75hT/JBQwEFnyYeaYJU928RRt/WskXNzFtpQvEuk3DxLFQIvw?=
 =?us-ascii?Q?iukYBLEWwGcBhkWpiwbi2IegISFWx9h4fkxZ8CLNq5+X0MlFGmuL2pP5D2ii?=
 =?us-ascii?Q?EBPcoBkavE54Vqx5xN7Cg2Z9T1v8rDQA/GXOhKpQfbywn2f9tewWT+G8Xnme?=
 =?us-ascii?Q?Kus5g4uKsUiQJogzNkos/EdoX7MJvACerirdfQFRY9NMb6MzkzxoCmREYebv?=
 =?us-ascii?Q?LQUDgqvzdERJq30KEldU0sqFxkpk3AlOQgvUCt6kQJPVGGaGCbxRzBDK0AfR?=
 =?us-ascii?Q?+rYVRRnzW1SHo8gG/11Od70s+HNKCta1yEdxRECJNHKtsiR4cP1YXMFzC2wA?=
 =?us-ascii?Q?+NakZpnOzj1eu7PQtUO/ApdqeVlA/iRVev6yiQ1keEQ6WclIL1K1nmNuqcSV?=
 =?us-ascii?Q?xnSXY43n4GLWuV1/03gprRYOnhnbBOHMApQ+cYb1kYk3xsM5z8rrgNw8fiSi?=
 =?us-ascii?Q?1Ds8HNJXr8jnpmmIeHaLWOEcIQiRSRm4DxkvEjmfl4jg4ggsgoMk5REnl2j3?=
 =?us-ascii?Q?gTLUoPs7Ou5SbhsE2YrMSLILZEzs78wFlutnk7bGFcrcqUZQ1O/tRQaZHHOd?=
 =?us-ascii?Q?F+eiPIxmC8hz7OPwPjqYznB/lYTSEvWXWst+w6JJf3t4OO4uZK+0gOnvqj0Z?=
 =?us-ascii?Q?HnItIJ7D3nY5Jy5CtKa9BH8duX8qIdsih9tI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:33:06.6920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9fafd6-e6dc-4ad6-6d91-08ddd9e7d3a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362

The CXL Cache ID Decoder capability is an optional capability present on
CXL downstream switch and CXL-enabled PCIe Root ports. This capability
is required for having multiple CXL.cache enabled devices under the same
port (CXL 3.2 8.2.4.29).

Implement cache id decoder programming. Validate the configuration in the
case BIOS already programmed the id(s).

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c     |   4 ++
 drivers/cxl/core/port.c | 109 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  14 ++++++
 drivers/cxl/cxlcache.h  |   3 ++
 4 files changed, 130 insertions(+)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index f123d596187d..fa3223165a18 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -163,6 +163,10 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
 		rc = map_cache_idd_cap(dport);
 		if (rc)
 			return rc;
+
+		rc = cxl_dport_program_cache_idd(dport, cxlcd);
+		if (rc)
+			return rc;
 	}
 
 	return 0;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f491796f6e60..3606ad557bfb 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1080,6 +1080,115 @@ int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_program_cache_idrt, "CXL");
 
+static int cxl_dport_commit_idd(struct cxl_dport *dport)
+{
+	unsigned long timeout, start, end;
+	u32 cap, ctrl, status;
+	int i;
+
+	cap = readl(dport->regs.cidd + CXL_CACHE_IDD_CAP_OFFSET);
+	if (!(cap & CXL_CACHE_IDD_CAP_COMMIT))
+		return 0;
+
+	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	if (ctrl & CXL_CACHE_IDD_CTRL_COMMIT) {
+		ctrl &= ~CXL_CACHE_IDD_CTRL_COMMIT;
+		writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	}
+
+	ctrl |= CXL_CACHE_IDD_CTRL_COMMIT;
+	writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+
+	status = readl(dport->regs.cidd + CXL_CACHE_IDD_STAT_OFFSET);
+
+	i = FIELD_GET(CXL_CACHE_IDD_STAT_TIMEOUT_SCALE_MASK, status);
+	timeout = 1 * HZ;
+	while (i-- > 3)
+		timeout *= 10;
+
+	timeout *= FIELD_GET(CXL_CACHE_IDD_STAT_TIMEOUT_BASE_MASK, status);
+	start = jiffies;
+	do {
+		status = readl(dport->regs.cidd + CXL_CACHE_IDD_STAT_OFFSET);
+		if (status & CXL_CACHE_IDD_STAT_ERR_COMMIT)
+			return -EBUSY;
+
+		if (status & CXL_CACHE_IDD_STAT_COMMITTED)
+			return 0;
+
+		end = jiffies;
+	} while (time_before(end, start + timeout));
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_cache_idd_alread_programmed(struct cxl_dport *dport,
+					   struct cxl_cachedev *cxlcd)
+{
+	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
+	u32 ctrl, status, cache_id;
+
+	status = readl(dport->regs.cidd + CXL_CACHE_IDD_STAT_OFFSET);
+	if (!(status & CXL_CACHE_IDD_STAT_COMMITTED))
+		return 0;
+
+	/*
+	 * The decoder is probably already committed by BIOS, validate
+	 * the configuration
+	 */
+	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	/* TODO: Check for 68B flit mode */
+	if (dport == cxlcd->endpoint->parent_dport &&
+	    !(ctrl & CXL_CACHE_IDD_CTRL_ASGN_ID))
+		return -EINVAL;
+
+	if (dport != cxlcd->endpoint->parent_dport &&
+	    !(ctrl & CXL_CACHE_IDD_CTRL_FWD_ID))
+		return -EINVAL;
+
+	cache_id = FIELD_GET(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK, ctrl);
+	if (cache_id != cstate->cache_id)
+		return -EINVAL;
+
+	if (!!(ctrl & CXL_CACHE_IDD_CTRL_TYPE2) != cstate->hdmd)
+		return -EINVAL;
+
+	return 1;
+}
+
+int cxl_dport_program_cache_idd(struct cxl_dport *dport,
+				struct cxl_cachedev *cxlcd)
+{
+	u32 ctrl;
+	int rc;
+
+	rc = cxl_cache_idd_alread_programmed(dport, cxlcd);
+	if (rc)
+		return rc < 0 ? rc : 0;
+
+	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+
+	if (cxlcd->cxlds->cstate.hdmd) {
+		ctrl |= CXL_CACHE_IDD_CTRL_TYPE2;
+		ctrl &= ~CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK;
+		ctrl |= FIELD_PREP(CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK, cxlcd->id);
+	}
+
+	/* TODO: Check for 68B flit mode */
+	if (dport == cxlcd->endpoint->parent_dport)
+		ctrl |= CXL_CACHE_IDD_CTRL_ASGN_ID;
+	else
+		ctrl |= CXL_CACHE_IDD_CTRL_FWD_ID;
+
+	ctrl &= ~CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK;
+	ctrl |= FIELD_PREP(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK,
+			   cxlcd->cxlds->cstate.cache_id);
+
+	writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
+	return cxl_dport_commit_idd(dport);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_program_cache_idd, "CXL");
+
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
 static int cxl_einj_inject(void *data, u64 type)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 04fde1a994d0..9c475d8c1573 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -178,6 +178,20 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8)
 
 /* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
+#define CXL_CACHE_IDD_CAP_OFFSET 0x0
+#define   CXL_CACHE_IDD_CAP_COMMIT BIT(0)
+#define CXL_CACHE_IDD_CTRL_OFFSET 0x4
+#define   CXL_CACHE_IDD_CTRL_FWD_ID BIT(0)
+#define   CXL_CACHE_IDD_CTRL_ASGN_ID BIT(1)
+#define   CXL_CACHE_IDD_CTRL_TYPE2 BIT(2)
+#define   CXL_CACHE_IDD_CTRL_COMMIT BIT(3)
+#define   CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK GENMASK(11, 8)
+#define   CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK GENMASK(19, 16)
+#define CXL_CACHE_IDD_STAT_OFFSET 0x8
+#define   CXL_CACHE_IDD_STAT_COMMITTED BIT(0)
+#define   CXL_CACHE_IDD_STAT_ERR_COMMIT BIT(1)
+#define   CXL_CACHE_IDD_STAT_TIMEOUT_SCALE_MASK GENMASK(11, 8)
+#define   CXL_CACHE_IDD_STAT_TIMEOUT_BASE_MASK GENMASK(15, 12)
 #define CXL_CACHE_IDD_CAPABILITY_LENGTH 0xC
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index d28222123102..60563b391844 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -32,4 +32,7 @@ int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds);
 int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
 				     struct cxl_dport *dport,
 				     struct cxl_cachedev *cxlcd);
+int cxl_dport_program_cache_idd(struct cxl_dport *dport,
+				struct cxl_cachedev *cxlcd);
+
 #endif
-- 
2.34.1

