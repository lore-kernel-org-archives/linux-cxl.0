Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F533D6E1;
	Thu, 13 Nov 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032560; cv=fail; b=n+AAIEjxItx2SWqIND/KzInOfGL5Q0Uoy7/zcyaT2onFPZUTWhZXB9Ca/h/3XG4PzyXXnAw5URnBwAncdYy2lt3LuVvVl1331IdG3dYTp0LSsgUFTpVKymd4QbeYzwNzxtM+Mlhd5MEqBW194564cLnfPu2oPb6zbiVqcProCJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032560; c=relaxed/simple;
	bh=cL7KG9mmJ9oA0usxLKjSNZTOIlX/6UiZv1ICHw8NLtc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQCPkjwxMkLEccIUv2tZePbNcgNhD6LaBX5HnzrZRfumt+aTyE4QQrvpqagiP1bzSbHOqBbffdsfM5ijPHvBGgRM8jYvsg5tFN/p5Fr7gi8C2XH2cPd2G++H7yt3s+uQ5d8Hl0jwrAJIKirvWNvAW8QodtlD83r+lah8KzbF0P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yMo0W9L3; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yMo0W9L3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWdqYKivJqy/Abse3EBpV3C/L9S9aNKMOwuCDzTDxVD7N+g73f48olRizY/9gwTuy0S8Ubb80s6UvKpHmK6We19OSvVXCXJUkCmXh6m2sAt8p/IGjn1u+RigzepMgl2gBmHIxRLwW8qMB2c1S77evpXZiAID13wjEcMsuhmYH0PdSTDgHb4n55AE+a/nEIBZRjhWjCpDoS6Q/z+q3RSAQcnF0rwxTqxFwOP8bwJXMSwcRDzn5d3XUia0xlxLWtXsI6rVJ4W7DhBUZ5SzgyngmQlO1HMokAgLE9lM2fTpoi7Bt6ssraEJ0gcLuqtzOQ2jVDlUF1NA99yN7sSmSCPWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFV0B5LK9p+dI6YBYT8DX3SCEtfoMBjmekDlUBazSyY=;
 b=vrfH9uuIIx/0NfQajni7M5s8kfm4qm5yr3HG3xqYrpbh4AAy730CGvJBjKoM1mtWFrKoWg7sObS+BxGuYtWBrUiKGlVLjYWimT3UUBs0C2KkwxG7YTX2526MzXSc+0tjYPKZrPXbLzLBZmxic7+mVdluPnMuzsUXYD5uKt5VFm6pGtTX0qKaQBb+Pe9lJ8/ZQtYo2UnS9NvOEcX3seIdvWcdcc1w1YwvtLgLcQlTceVqD4QN0T7aXF5FE/qF9RIUDq96p5t67eMlZeMhM5Hl7fDsJR5hS3ZJbi99ON0iHJek5+z804OF8EUQvfZLWfr9hCQFppLs9CcMaZx3AM5qeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFV0B5LK9p+dI6YBYT8DX3SCEtfoMBjmekDlUBazSyY=;
 b=yMo0W9L3eUwDurDrC0OI8FD5PPLWRDPGdfSwjlYzMz3s+MF6pUGxfG3DhRd0l/kHiWnXbOWzGZHs4HXW6Fp8gJQJ0STNx8o6EOvxDoRVqlW5cAOAsYPbBU3pbo8ebWa4yoBqZO/cwrobqFa3dmqmu4JagoKug/+qoGjJOBcQEMU=
Received: from SN6PR04CA0105.namprd04.prod.outlook.com (2603:10b6:805:f2::46)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 11:15:54 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::86) by SN6PR04CA0105.outlook.office365.com
 (2603:10b6:805:f2::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 11:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 11:15:53 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 03:15:50 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 3/3] cxl/region: Remove local variable @inc in cxl_port_setup_targets()
Date: Thu, 13 Nov 2025 12:15:23 +0100
Message-ID: <20251113111525.1291608-4-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113111525.1291608-1-rrichter@amd.com>
References: <20251113111525.1291608-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 874d9ab3-759e-44d9-b538-08de22a602bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4psEWLSnLytiC9NphpET+JJeTq89I54pgl5LBgcgEGNMqVMXmOfD3WJV+hmM?=
 =?us-ascii?Q?dCSl5n+s02dQfdz3+uXwjDKoyus77MWrI9t+y/GfF7dtB0PwAtRW/FuaXU1Q?=
 =?us-ascii?Q?YW+E9gAWcTjFpt9vw+nVSLXzJ8B38YbtmvYReCWMRDQCWjHVLhACryBxi2Uh?=
 =?us-ascii?Q?SSPY0N3RCLrBhAXmAZIeB6k4WZRuxzuivfyi7kECLfxqe3VbVkyETcaoHQ7W?=
 =?us-ascii?Q?ohcAFsmyTDpzXqccgFN8gE+//V17YvK2vPUYTO19Wf+LVKoZhArM2Fmk/5v6?=
 =?us-ascii?Q?bmeFRqNvUTFuLYWAiNysdQA1kWMLfEjwhoxS9NgXB1uT+KTQK0pI68GVoerj?=
 =?us-ascii?Q?wERCKid2niViKoxZDRE84+Zl+6r5n3v07l9wvKKzd/INhcn+wjDgcQAf/kiS?=
 =?us-ascii?Q?3JHukbHIDLo7m42jExxVnqCntahtZEGqaZRV7DHNcsup2Zs4UrFVIDoNsyOX?=
 =?us-ascii?Q?wID1Z4V1B7wOKwjJfLPZ/zu9QCs2ZJM0LlNmPKVuiLEyOSYPx6DidjMD1imG?=
 =?us-ascii?Q?RyeVBelcEAVwHHw0zJr20dnxer4rSKKExuv+p2Px47m+5i+9s6PkIJhCoAfz?=
 =?us-ascii?Q?jRDDAmpj4pKFJC5T/1es9YztZAgqKMzA8B1uULsj4Dh3Vq2sV0JiTAs1zwqB?=
 =?us-ascii?Q?ZF6oE7+Qb9qBP/pRNiTJKh8WxM9ia0fRlqK2Utgj3UIoj/mjD0sijAz63VpK?=
 =?us-ascii?Q?UP2rvvIdPnkwAJLSxM2Z42xOWHVxaL2Kf+OQR8povcJyeAOJmhhitl57neAv?=
 =?us-ascii?Q?clnvJNbYMrhwYSS7zQqr0mSDcPZEKHilNjvCLWAm5BAYiEmjKEPywONXEdKL?=
 =?us-ascii?Q?tiLmEnMA/a3pu2tqHasxMJXQpdZjFLpfyUDbVqDJLyU+DkyT6CorS1caeYgL?=
 =?us-ascii?Q?YmcbfrqRU9/YugthATsIOZ6Ok3MZ4NwRuIFWLIKT4Zcz1seNmsGndaOLTrJf?=
 =?us-ascii?Q?y9q7X12jluNc6O/ZdnLCVlwi1Xs3XB6GDJgg0gj0OOkBblKIZvWgPdkog2it?=
 =?us-ascii?Q?AC/pszgr+vXsgwlpe+2YfrzX1HCQgQaiVKOWle5VT+uVQwUmzDPT0Z6AWwRs?=
 =?us-ascii?Q?SaF/OKJXnzNmcZufH/Q/axpmh+qOOU5kSq5FigpbjR9HYHs4yfydcSfTqBhc?=
 =?us-ascii?Q?sGzgImGc+437NE+hZEHE/SdXD9sh4sJ6u/fPr7rDx/SWUmtKYxbWdIP1Bv8B?=
 =?us-ascii?Q?kEEITfMoGk0Lx0PA/8QTQOa7Q6+OaC1egg9ZrCbz3amfCLUyMc5pYbgPgYHK?=
 =?us-ascii?Q?UAqbyxQPeTs6DmYfI8wcWBEDn+DXsd6VUkFBQwnyH9+RuSfMvATgkN+HXerk?=
 =?us-ascii?Q?Coa8xlA3t/Mc/M47zqz5WNAivVsxoTrgCM59m1X86oF6PtFKTuwUurqalAJm?=
 =?us-ascii?Q?XJkywt0gdM9FARZBQnFYR5ZnTLeHi6RLY4y9nz5IEpnswa7ubECAcecXJVW1?=
 =?us-ascii?Q?h0L0L287kVXozUnSlpuKcmn+0dCg4/YizjR8F8f27Zl+IefksWdfQMrUnLjY?=
 =?us-ascii?Q?H92sifsBRaC7/NLf7KezZbeqnekaK9yHgLrglrVfNgvp7qIWxoe12lLXTU6w?=
 =?us-ascii?Q?bSMZRikDrCrnmuN7G68=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:15:53.8434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 874d9ab3-759e-44d9-b538-08de22a602bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

Simplify the code by removing local variable @inc. The variable is not
used elsewhere, remove it and directly increment the target number.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2b5ae5d9a4b6..e577b11bd889 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1357,7 +1357,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
-	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
+	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1549,9 +1549,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
 		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
 	}
-	inc = 1;
+	cxl_rr->nr_targets_set++;
 out_target_set:
-	cxl_rr->nr_targets_set += inc;
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
 		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
-- 
2.47.3

