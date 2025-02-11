Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49801F153F;
	Tue, 11 Feb 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267665; cv=fail; b=ZEHx+okyUE74xHY2w76SKnnDGj7oIW2HmmxQn+q8QqQREAE1ro7Fj5CFU7wjERRqH+wlHcaZUx/JtErr9YWsmX+BPteKPZXt/u9eshT/AkBF7SYZNTtXjqTI/aeJ8TTXcWtadLPZ9f/PDJKzGpqzGSAQfwWNOVKpu9ZqmwTzwY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267665; c=relaxed/simple;
	bh=LkL80zOZM7vGAHXWWU8s3OdmpbYF/HVnjOixF1dCh7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbAKrqIcNfQRXvIuc2/QkM8DwHflAv85lcyGi9F7nbP8lhMcG5KVQx/DSKsQlgM8KSfUhFJk0WeeZ2oSalwKAcbz9/N9cAAGIdF19ODjFD2fXeefRlvYKmY/F+geJohWaeqTyO35uzhdAp118y8ohorp7DFF3GDSVaSoDD6Dwd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mm7hHMFb; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mm7hHMFb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIn2rnga4DPpSbG3+vUa6WJwCnuyl//HS8YuoxFdQe0QHCKaFvSrQHeMJSxmLT4uZN9uEcrCPyrPWjrqKeenUIAcuTGSpI2tTwk8XSNwQ3QbxOQmruvkBzlMJLCv4eBtmvQzCxWwgYQbYH7Q+EhBKDTBCjkDtIAnUjubAPAY7fHabMTYNFuOFJCXOYBYzr5CPgyfcLR1l88/Dv/n+UPtkqbDBMYwroH56axpgPQ6GCdt/lz4YMCJMJzS5hoB2BgoSgOS57rVfHEUbk9WhI0ojz+kM693oHaJ1yiOXBulakoq+f+vG7DhVJWSCMXqJ0qk/i4E4LR5eneXL7qRW3JLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls9fcGjwrZfXlWrm3qXBe/oTh79rf+TxNGQ0OaHnrCY=;
 b=rnvHkw6iDIojXyVPBOWfcXnpPgoyhHJfFN6DwjtlgZ9zkHBqdZo6r5PpqvRiumZ+msz6a7LI0Vc/7MKlUp8oX5mLrTp4GZPyhVy0zdkuB1FHmpab8amvX8t2CuVUrVSTUr7yS+I3KL4LV0XA5qYBy+uXwTWU4KctsmUn8aF97SbeLDiihxCgLQOhV5hSJC7ZJZmcptEeMrq6jd+o7sDVd9X6eqkLJHPSpErLfBYgE1Q5Mr+ooHNk/3o2r4jvuiecdsyWSyBTOAPaRGeviWxC7DySei2VDuezraNzuS/aX3oZEfwRzEFdjxxz2H3PFccrgt2xGb/Fb754pWgHaIku6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls9fcGjwrZfXlWrm3qXBe/oTh79rf+TxNGQ0OaHnrCY=;
 b=Mm7hHMFbBp5ZFuAU+00g6Dx8VyhG1JriqUzu6TblrWGSo5Gppscxi+i60+WxjbWGuRd3hsugBMQg4hwExQJhnaZcz8jJs1+A32ss1ADQsEev8w3RbL0Ru0ndEuo8yIl64aeSYY6+qP0wVkhklS9DQJfRlrpiO3lcp71dCf/uPZQ=
Received: from BN0PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:143::25)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:54:20 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::15) by BN0PR10CA0007.outlook.office365.com
 (2603:10b6:408:143::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:19 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:16 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 01/18] cxl: Remove else after return
Date: Tue, 11 Feb 2025 10:53:31 +0100
Message-ID: <20250211095349.981096-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8d9db8-f37a-41c7-ca2d-08dd4a820df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UQab4fYlOHBqfe1F+OmMrdwqX2HfQNZT/f6fnOaxCVrdlluH0+ueLfDowgFJ?=
 =?us-ascii?Q?t43qyV5W2YmT3oPP0SSeAEzLQsRHm2qRi2NsKuyLaoVCxcC0Opdkg98wmcN9?=
 =?us-ascii?Q?w4lMFQ9jUBoFi5uLmdzXUeA31bGtaIU/uO3JTz0a4NTmS6dO/xRT0gRDXP4g?=
 =?us-ascii?Q?fG5zy4MHyq2lnZpMyXzIvJXji3ie8DlqjMTPeUZHj0Hcrj5MuH9jVi/mYhJq?=
 =?us-ascii?Q?gKueN3O+bfC1i9yJcQHCWkC3T+UB845jQFGGtxlWy0rPHAjjYrNc3oHRCGUw?=
 =?us-ascii?Q?mX9dNbU48cAPiCY2lniG5cvtyRwhNZXlRLvsIE6a6nniu0K8A9eTOLmqo735?=
 =?us-ascii?Q?umVW1+8TGZm9vtHFTaXG9cNc9EfryLf2QbY/dsXJ126fM6XnfPP7lcuytZBY?=
 =?us-ascii?Q?LiGYTK0nvBmRsKrtGNjmzysaDn+lAb0dLBL9PR6X1hCuo5hyOfSGBEDLG6WH?=
 =?us-ascii?Q?aZGpidvEEnX/tvFYYPfe9CeQ7WYDTO1EWi9BQo6ZQ0laEV9vtckn4cvnC4ox?=
 =?us-ascii?Q?OyDXc2KhgB5dR50sc9biDSY6gqUyrbocVqmBO5TOlrjXEcE/ENHZIH1XU/Um?=
 =?us-ascii?Q?enpvu8WJ/1e1j9/EMqjnpoNJnAKA/2Wf6VjOkUf8NAEOgBK+vHNBYoVH92vR?=
 =?us-ascii?Q?WNu625mwany5945iUjsAx1e7aCASjAebnfwfkscEAclYV+OCVqwD/rNO1LGD?=
 =?us-ascii?Q?Lgn41XxANDcB38gXKHU9fTVMTx3XstYE9AAnQQ0wULvSLkhbvwh1kz9p6mQx?=
 =?us-ascii?Q?4CQR5D07lXgkhEU2Y2y30KqzVzCy3VoRC+5b10VoK5ME4NsrgLOU4EYhTDxQ?=
 =?us-ascii?Q?9LBwgHBkds+gyqIHq1FZ3OY5gqMBj9o+ox43c9uDCYtF87JOd+Uyo9xWdc6N?=
 =?us-ascii?Q?DB15DN/n50eJmJqC1enj1zV8TrwTSVx4KxfO/x26n999kzuQMbnrcEs91GKK?=
 =?us-ascii?Q?aiWIVIKk5mEsHkJqtuSBDSp6B/uIkn/sBrWqsd7QvtpwQtxszNJ5HjdArefO?=
 =?us-ascii?Q?xYUkDVpwteVKcOVaKsc/E1WJtL9VsFFqq+X09zxasmJdICaA+rICAbj4ooQ4?=
 =?us-ascii?Q?S2BL8Va1XpkwxWdEeqKG9iKahTDSXRf9xZHehyXVdkve8m1xCjAfuJgngarf?=
 =?us-ascii?Q?f7KgYpmXvkJkxhxB5afLQn0If7i6kb2yR6TI1KexomE3zCM6xPc7bcEtS2K6?=
 =?us-ascii?Q?tQ+gh823Zw99SctbUX3wjCVth7ZpihdJ692Zybx4PS7XYxmrmqazCyY0SlU7?=
 =?us-ascii?Q?lSwYw1bHBny99pzT6xjMQ5QVY/rb6yygjqLX3H/Qs4goSKllgsfvBvh1JzxI?=
 =?us-ascii?Q?nTP+mc05ZraNrw2hC8Io6fKZNwYWw890ezQcWO502g8AR+VXLMJkpX2Kc8dj?=
 =?us-ascii?Q?qbSdzROb7qTdd8DgUVUfnh/DZqODZJC4yYk9Cy9Hp6J5jT8RRWt9p/KiD2Tf?=
 =?us-ascii?Q?hR4UHWDd6IKX5lYqumCC4U7WwcqQiLni/ZrvazuYnhpVr3aAZe5AuCKFuXT9?=
 =?us-ascii?Q?vHN2y4GOFVJ0ikM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:19.6138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8d9db8-f37a-41c7-ca2d-08dd4a820df3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034

Remove unnecessary 'else' after return. Improves readability of code.
It is easier to place comments. Check and fix all occurrences under
drivers/cxl/.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/cdat.c   | 2 +-
 drivers/cxl/core/pci.c    | 3 ++-
 drivers/cxl/core/region.c | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bfba7f5019cf..0a09add46d5c 100644
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
index a5c65f79db18..2ec8c97ab160 100644
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
index 84ce625b8591..5d252dfae138 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1926,7 +1926,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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

