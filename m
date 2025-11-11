Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF235C1B5
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897383; cv=fail; b=DPAsiLto3nAR9ieOr+CvxE+NyU5e4CckOVxOnypPxL8Tv2mog/CW2nY8xBqgF5t08z9jkjGhQqOc2uBIf/S9c+oUldBYHFDzv4l76NmgZVQsfKkdDPCzjXrgLwts8q/cPxlXa5sksRBrDfGaXQDTF9sUxfQUWd5/bMY045atbSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897383; c=relaxed/simple;
	bh=Kc3SRWNMmOJ7eCrKTlDa9vD1RT1b3Xl7Qio//xPcYiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2k/j8KnQrDexwUkbWMZwVwTtzyRrNX5gQxu+DMfexTFMAUG9oVzt5AXr31xW550dtxDiuMN2Y4UykvY2yOwMCsz1ugMDYEudfTqe1VtWCpRb1qU4/xo9c4a1rWBOFWfHaLtO4gWfkfjz0EyNb52Flm3RImWKxCd9taypcVbt0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R5ooiICE; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R5ooiICE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po9KCMxhzuNGKklka2VJTs7An7G0yWygAbJlJIhjwPndm/VlgVz0QnrL3zd1SdvfZ+BpynvqLGgnOfpX1uoptUdlTMmQk64UWiKDc6zdTM0E2/oJmEFJz83HZZ/I7xzG7m8SAQKGmcKumgRjTxGsNQG+ob6AHeNctcumvc4cvnfg1j9FimGExmIhnYnGx0ipAlJH24HE4F6+PcdDmuk1mETvTy3Py/V0B45GlvwjWC3jBCOGsBpUuSMVceE/vqFaOnDnVXYQeq0+2cc6Zx9p/0oxozGIkxIHW9zGt6tpcQnvj3nn86KKRE4ZM6HPCSQJw5kpEFvHtpgoAijcIHUmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB5LgFsGFSYadpETO56DR+cW5pt1jSHy/WvLA1WslPM=;
 b=khAlA7o492MrIqkG/7Y71poU8+F/ZM3d8RJguzMUfI3VN43nvSQmuKMLjR6jBtqA8Qqc+rTf5nrMs4hp5x52+uJ2b4G9YHj25d0XbXmHl5ijCAZJOLovlKaL4RpOx6x+MTnoYV+FWM07P10kxGK2O2wrFH1STHsXYvQbQIJ0NSilrxqfvqRgHCOMqsqg0c8tBWdEpvEcuRHavxA9tp7WPNx2Rusjwjc1Y8+ofoNgR16saFUmnS1J4bPESwTNjUSg9DZrbxpWqylAVybCaodRbqC2CeHhtXDDeZxR5aq1VPoMSqQSqnRtbmOTFtgMLacyanK4Bq1b2HAFbsH9cJ+8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB5LgFsGFSYadpETO56DR+cW5pt1jSHy/WvLA1WslPM=;
 b=R5ooiICEa1/DZG3EBdCtxTVqSU9xWtJBnGirUHq1RfBV3gJJZXCDNXJ5WJVEahdmkdH2CQE0Wai56fWT6tGPhv8V2Lcsz6Zc5SOHT/TrAh+6UKZtr4oiwrl3d8JRbpE/QBR72uketCpr5upu8X4VBVu8q4aBjZ4MmUOq4WGkoUA=
Received: from BL0PR1501CA0033.namprd15.prod.outlook.com
 (2603:10b6:207:17::46) by SA1PR12MB6752.namprd12.prod.outlook.com
 (2603:10b6:806:259::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:47 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::4c) by BL0PR1501CA0033.outlook.office365.com
 (2603:10b6:207:17::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 21:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:42:46 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:42:45 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 10/17] cxl/cache, mem: Prevent RAS register mapping race
Date: Tue, 11 Nov 2025 15:40:25 -0600
Message-ID: <20251111214032.8188-11-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b30b1d6-1d1a-4675-59ac-08de216b40a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ATcSaRhKaHsykOMVp5awXeFVcGmDJYHIhMR7VRo1oKFhGhtWtze8BSccRKm0?=
 =?us-ascii?Q?GrHu4g6h53abSxu2N2tNjOvkwQUCfBosjb0K09HNO/ZR9NAhjLCl2rk7xebJ?=
 =?us-ascii?Q?eOCRtPVLwmgDKqml/nXKGkM1RxkNYum7sK6iGf3Q4dG6g8XH0F8sxwj+ajXc?=
 =?us-ascii?Q?5d+72Ez1diToXgNBmK8IRt+m6ryccjSEWUhbQKk6jBRI3VKig5S+LVYWUpSX?=
 =?us-ascii?Q?+Bq4laixNvC7M/7LVzQM7mYuwXNvIfRjJaMQe7imJxE5lpRgKj5tZUov1jTN?=
 =?us-ascii?Q?iqfGlDQa3WeUZF1QvperHIJ+x/MHG7CiXtbXZ7GDTT+/7wpBThOaKhMOrRlv?=
 =?us-ascii?Q?rQ/zMAa397+Bq2WBBkYehR32+LXSfOgTANnyB21hHvwDWwfZci3jw3rDTpGU?=
 =?us-ascii?Q?xy7QboimlEK77hLX/nT89B3NjWSl7G5Od0y7VRyo5dfc6tBsW/Sm+YT13spG?=
 =?us-ascii?Q?F1xTe1gJYtBWTSdI3+xKPHPUfPAsoMIM5fJnB0+gdZMzC+eARJMKAbbB3Uq4?=
 =?us-ascii?Q?AsPEazJZzKPkwcYgapiouvgss1rC2rIpoJgNjyS7lHSXSxNH0IXtgsWNCHAx?=
 =?us-ascii?Q?Ws8xLcAbp8NR2BplGbKQ5+b3I7P31EmAl35LtdjecfKqnR0VXyBxNVqjcWPz?=
 =?us-ascii?Q?xaGT/WwPb7jkvFa8yu3DeJ/aCu8P04K0IdS/pO6annWU/D9FsJUwwKz2QFD7?=
 =?us-ascii?Q?CChPLAtd23pzYsYtzSsFrRPajUfbOrmdJRhzYAwMlu/hd4S080vxF7a73tVd?=
 =?us-ascii?Q?XSZkQ35vOCqABR6KSRMQqEZyLDnbzkAcakCHfRq6bq13M5XZBfnFKuecwOUR?=
 =?us-ascii?Q?5rcwTVdBjRLHeaprghZlto7HBEUNd3CMJ6kvTCmsa1VTD5Q75weG0DSkNB8v?=
 =?us-ascii?Q?K1Pvr1+iAUaEX+J17iVbosnMHPD1VQaC8xGdxztM2QaZCv6sX2NMamPNjaAQ?=
 =?us-ascii?Q?1YCwHrk6MuM4mDQty97uDS+x4mitvmvxih4Eg34TgYRXal330B67hPUvlff8?=
 =?us-ascii?Q?x5wQ+wqrYmo1p8I2XoDXNJ5XCsf7U7cQu1See8Gtj0rOi+82/Kiwe29brCww?=
 =?us-ascii?Q?bwJv9nPgNX/yTedGH7+OFy1NXQSCy1nAlda5DHNgYrDH5wbzLNlp78BXPsU7?=
 =?us-ascii?Q?PHWLi6xBgv0VAWves8BEmMM6ChgG7yq5gWlC8sF6buTMBR1AdxB0dQdcU/2B?=
 =?us-ascii?Q?j/5ieeoY0cS8qsE3ZbsEkIONslPA2u77Szp+cdXPeN7a77556HHo2eY5sVU9?=
 =?us-ascii?Q?E3TxesXRxb452EWCX8z6/q/cwh09fvRV6droclseLz4p69qwihBR3Un77qe0?=
 =?us-ascii?Q?cZ6JTWCBcE5JsgrtMtWJ1sU+UO8O0c5FkOU9Lo/1BQuFduJeDoaLmn0+9Tr5?=
 =?us-ascii?Q?UGhxqRdOQ/c+Yhy6StTPR8JBGOnrz0VV2WvGvGY3D8KYq9AMZX9GuSvA0GMv?=
 =?us-ascii?Q?9jBuHXZpYRtOQWhjPiJPbsKXA55KPmWi2hCV4rF4njDA0ndIczhsSSfnOC4C?=
 =?us-ascii?Q?h2Kr3Xouq/CRE+zzdyEp1b0ftJ0JaBNDjBmx3kzSJAc7xNuXRYgNT4kQnw83?=
 =?us-ascii?Q?ucVnEpxYpM9U6xs/Guo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:46.2447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b30b1d6-1d1a-4675-59ac-08de216b40a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752

CXL type 2 devices will register both a struct cxl_memdev and struct
cxl_cachedev, both of which will attempt to map the parent dport's RAS
registers in cxl_dport_init_ras_reporting(). While the immediate call
fails gracefully, an error is emitted in the dmesg log by
cxl_map_component_regs().

Avoid this error message by checking if the RAS registers are already
mapped while the port's device lock is held.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c | 11 +++++++++++
 drivers/cxl/mem.c   |  5 +++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 630452d53acc..4c9280c0ea72 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -58,6 +58,7 @@ static int cxl_cache_probe(struct device *dev)
 {
 	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
 	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct device *endpoint_parent;
 	struct cxl_dport *dport;
 	int rc;
 
@@ -72,6 +73,16 @@ static int cxl_cache_probe(struct device *dev)
 		return -ENXIO;
 	}
 
+	if (dport->rch)
+		endpoint_parent = parent_port->uport_dev;
+	else
+		endpoint_parent = &parent_port->dev;
+
+	scoped_guard(device, endpoint_parent) {
+		if (!cxlds->cxlmd)
+			cxl_dport_init_ras_reporting(dport, dev);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3b230f8c5925..35706ec1b7e1 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -129,9 +129,10 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
-
 	scoped_guard(device, endpoint_parent) {
+		if (!cxlds->cxlcd)
+			cxl_dport_init_ras_reporting(dport, dev);
+
 		if (!endpoint_parent->driver) {
 			dev_err(dev, "CXL port topology %s not enabled\n",
 				dev_name(endpoint_parent));
-- 
2.51.1

