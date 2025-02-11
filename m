Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1631F2364;
	Tue, 11 Feb 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267668; cv=fail; b=D9t8EOL9KIO0iP2v3VvFHS8laTmmBA6VlISxHnIpLfWArC4ysHiUuIA49/WgFTvDiey4ulxO6CTYwLckKkS+QziMT61iCS5miXxtRosEpSXXblOHiG8PJZWcJ9fmFYTR1L7JvHH42S3rveNTPVIxu+VNOKXIAE4+R6F6onJH8Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267668; c=relaxed/simple;
	bh=sKih2rjR85ilWjbScwNcBOvDEsgIFFkHFnlg6x/QZhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1Xwf22uZKpUwXVlU5gb1Kkv+sL18lSbf6UoTsC7YRcuedEH2V0Bn9XyNm7p6i1uUIGnhjYyjjpqIrQlYcBqlqwB3Jyd0HT8cMunfnrUtC4sZe4Yg9qImyzJxgxMNkce6bkj0NSO8ZC0IFvSSySg9nOmaBLDyUpgvrmzoObCOS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LZ/2MYMW; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LZ/2MYMW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFpkHfMQuwp6czY+4K1GIc5fnb3wvusm7lZkaRd54c9bFOBAGgIhL/sDDnUgrwPaRFDdY34YZjZUENp9kUjz1QeRMAteFtDyGVR0nMojCy7zylfLc7DeUdAqQ5mcv8IZXPYKC3qKMNGExh6+xkm06v0XhaxhUO3b8Eb1/S+HyWRL8x/OnxRlowhjPgcwUY6uUikxHyqH2Ef8cAamXMU0J+yoh1tC9LkAD/CxCpgXGZai707wLjOHJBffa7i/K98l5jW71udIAR4T6zb9Cv3fLoN28N0zas8lrUBt3bm8gsJvYHzVY4ArMiN/Dq7bWw0wAtq5RxeNTgqJQBl3I+/rOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj8R37Kd5SyU82pj2/J066uCAaN2aiDqkX8J1LNGWI4=;
 b=xbmSXG4RZJdwsBR/sNbmCsdUcO58wInzHDlNR8JWTV8ku3rKhZPnXy7X9aQwg8VSrmbMeOaQFP49twRAHGpyalO8yz3vvsdAaMLi+SuM3f8+vmATv/DntJJB9z/d0YKpnkoeIdev3oEDeWDL56Zrf17RyyG5Vfoxn4zWXM+hT6BBsGMyzeqsICgrBB9jgCQ+L27oBuDZGtl9/ihxKLQNbLfXcYvCZCRKQbUqaMWg/Pkbe6rRSWiy3ayAXy2idTxNFhDlb5S0JrqiEKB9AvEAIFMociTiDt1QCUBbYd1qTZAXP5stznHoX8ryxes2Cvuks8xUO6Bdy80FMv7mvwfEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj8R37Kd5SyU82pj2/J066uCAaN2aiDqkX8J1LNGWI4=;
 b=LZ/2MYMWHRZIToJVCP1LWLz4FkqSr9G8w5y8VFpm8I4N+e0tzG2fncEzAceN5AkSV/6wFGuEoVgarIkb46j/icJw3Er22gIlH0MgMTNAXzGPE0qMB5EfYXMa9VOszchd9K1zmjYFRWzPqXdMpaQUY015EQNdvnD6TcPQ9TUL+xQ=
Received: from MN0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::20)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 09:54:23 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::28) by MN0P220CA0010.outlook.office365.com
 (2603:10b6:208:52e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:23 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:20 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 02/18] cxl/pci: Moving code in cxl_hdm_decode_init()
Date: Tue, 11 Feb 2025 10:53:32 +0100
Message-ID: <20250211095349.981096-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d9b542-f1ce-4d6a-0345-08dd4a821005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ej84dQ+KKanugtnqYrc9I70YC9Ld8egTAFW4xAdKWUCpF5oMzsRf4xH8BjsL?=
 =?us-ascii?Q?pp5iQN5i0lSG0wbtTPb8SpOB5SJcRGtIGM5jRBTYAlgd4qVH4ASFNIcXNjvM?=
 =?us-ascii?Q?lMEb0hN0hx7P9c3Rd40bnp1cM9MTw9+sKx+55WM+UbhcFztdA/nuEGXpGrSE?=
 =?us-ascii?Q?UvmNerdEfE8Z48N8/H+kA/TrVLhDXcbQmtzCF2fGdmyi6F/Gs4eV/DUW5VMh?=
 =?us-ascii?Q?pfpSOhQpY9OhEFYyNAPY/7+8ifxCQE1KHpF5ZUJ/Vj6i5+bbuy7MkiWZPwbL?=
 =?us-ascii?Q?cLjwTnu5K8D8rjhV6tbEDrK2KHxB7k3r2Mh00PYdI/zwOB+3j/w7AuriN1tB?=
 =?us-ascii?Q?g64VQIw+PXWtOylQJTfAhlFzoen7RkU0tcudNYB1C6OEep8CnzTs28fxehb8?=
 =?us-ascii?Q?olnOm8MKhbX77/QmrKcehA3KPoG3Uq3TaKVI8MF6XhCT1XSay8gpa3ZFLJX/?=
 =?us-ascii?Q?qgdtDcHijNxeUA6Dmp9CZxuhhEK30JqDckTGiTFiSknR+LVzGZMS6tV+v2eI?=
 =?us-ascii?Q?hmNLqErY8szoKyuRB3HPGR2QV8QOM9bGWaraJEK+5a2aH7ordZDYYJcR2Us4?=
 =?us-ascii?Q?QEfepTOJXggTo3Q62oWjjgs41P2MJip6lpn5UGqP4V4U4HmyiioK1pOz26wt?=
 =?us-ascii?Q?+qF2M3uE5/JyZBd9JqvOId0wdyTpyqxkPT+foVOgoZo4u5FGPVdGyvrds9ny?=
 =?us-ascii?Q?e7fJBs99F+3Xb5hjlI9Yc6Snmfwvq/NqOJoJmaNXbzBRbgzh139N4+MNakTE?=
 =?us-ascii?Q?TRh8x5eAzhepceKL4Z30yae9Zl64sk/y94M9X9xa4ndrDUg3RicffC7z2c4y?=
 =?us-ascii?Q?XxvCvw8X41MfhLsHVWhANiNjN3IUuVmtDgibmcAL+CV+WJPqny9H8HJouAfQ?=
 =?us-ascii?Q?zL396/xWfrW+HQL5VdBjuqTHKBAbgWNi5bgAQ8fJaQg6ib82w8DWIMHbuNRd?=
 =?us-ascii?Q?9w4OZtzgm60/aVU5kIX1vJ2d8BIAQhYlmACtEnY736QX4Ygne4jk/NqUMeeO?=
 =?us-ascii?Q?rwl7C7GBUidUX/GgAfw08pucfsED1+0fcS8e2JGxSdNP4BKqdTanirpU58d1?=
 =?us-ascii?Q?9VzDu1C1CMAYfJAU+TIqf2NlwiaMBfRjsJYVJCGplghm2HQj8QVYOZ2EahgT?=
 =?us-ascii?Q?VujFvY0mzrVSO0cKDYX+SVUfETuVKqF31l8oCQ7DUdKbOuwf/0xJNzv1D1t6?=
 =?us-ascii?Q?IJy+fU54lAeR+E1R6Z280OpWL4eW69Bf8y4tdllZ7NcvLYj9agnBRB3I94b7?=
 =?us-ascii?Q?IbjxcVkIa0RgZi3wBBbVi1cl9hYMcYiiOslpi7HtfvzhccHM0Lazw6hlV+w5?=
 =?us-ascii?Q?La9xaXw3vSpCHcIutiAQoO1oK3NJb9Nk7sUh8Tg39/RZifUiixsqrHUs+VQP?=
 =?us-ascii?Q?fgNoovzZNstBgL6cvSRMpU5jJi5ExDHUKubXq4N6lWZ/1aKcGvkQMnWZ5GpM?=
 =?us-ascii?Q?kL3YumWEIv7qHgsfmZ1M2ddo9BK870+pwkHnCvgdQBvCGlPk0Yyph05chlv2?=
 =?us-ascii?Q?qjeSP+4MnM0xMsk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:23.0665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d9b542-f1ce-4d6a-0345-08dd4a821005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
cxl_hdm_decode_init()") changed the code flow in this function. The
root port is determined before a check to leave the function. Since
the root port is not used by the check it can be moved to run the
check first. This improves code readability and avoids unnesessary
code execution.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2ec8c97ab160..f8e22bc278c3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (!hdm)
 		return -ENODEV;
 
-	root = to_cxl_port(port->dev.parent);
-	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
-		root = to_cxl_port(root->dev.parent);
-	if (!is_cxl_root(root)) {
-		dev_err(dev, "Failed to acquire root port for HDM enable\n");
-		return -ENODEV;
-	}
-
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 	}
 
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return -ENODEV;
+	}
+
 	for (i = 0, allowed = 0; i < info->ranges; i++) {
 		struct device *cxld_dev;
 
-- 
2.39.5

