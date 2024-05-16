Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E87829C
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847154; cv=fail; b=DSfgD5v9pTTr5Clz1evzsSybYN0v2tYycojengd24bs0Tc7hauJFdzkKTIcatFftOGKONTLcsAst0RHGmaFa3g2gEXkq7j1p9NKkJpRUGhDOCYMcKKY1Tzuy3GfXZbr6hEj0szxVy+2VlQQRvJBgLoGbKz9G7A/szKVRNk/ISsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847154; c=relaxed/simple;
	bh=cl2LMZk15VbkBnEVPN+nFgKcs3JpRqwlZfBty5GJKcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rm00w1tGdRW8kR4hRsted7zdQ8LTAXqTTkU1aQ9t6vuFatRgJHu8eJmFVOKVGXcqUanuzvVllirT7PkqcT5GN24fgSc+A0Gbn4OMM5HzsD9OsoZ8GhUxOa5KdnKQ/a36FhSxtdk56UZbybEbIaCmAwRHIAkIPs5XVn+GYV9XCUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RoRdWxbx; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RoRdWxbx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqNDSUHHL2on95msdFBqel9WrZyG6uVbpalQ0dyxViuEjraUtv7vkczhm6F2LRjc0GXIBO3C6MpU0CDrTZkdMyc6Y0oewtbvHa/8NA1YGBeOXpAsDoA6dhYCQbHCw01MvRBiy3UXKSXgE4R6+gOiRa/zqSUPy3ktwgyos9ZgLVStx7iUH2HOv8uy6FVVsnJdKtZc6e23Gw0EvfaBn2qEVcqZ9dAZJcQhfjAGHozATrn6M2L3cv4QpeITn3/2Bvs9SOEFoazgQpEq+Uo39k0/09LaxPT8Zg0yWiteCKhp7YYc750az2fhm9n+wCqRp4Fx/egiiCXcSNpTKjqhFO6zqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/697oYtt8RicuAJzPpJl1ttkQvJ1w9h+6D1LUcHd8gY=;
 b=oGSW9JkbrDSelsZJDkTxB2BPTbek3GsWritjfrBenwPe0GH8lc4M8Xyo+k/gUmuVCruy0+d5sP1p1hqNiD+dC3yPiXFg6PejtR0p6KOP/RkZJiN313l55L9Rnn6LKkgL3XQDZnqRKpba7Wt6arz0k7OF61/BamqZ+cPUv70H7TFzMlHEomlLVOiFFOO1CiFTEl2x9TdpvOR8IAK2+4tEeVeIk2lwzQHtLZdastB6iH04O8XoJM709S0IT3iEUJCGZRPCY/CiH9Lrh+rsmuJpVN5dKJMM6/TfwogWOu63v56Db4rU7qitUKcmgyTHcP2uvUmgrvZvqVKzgsqY4RDclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/697oYtt8RicuAJzPpJl1ttkQvJ1w9h+6D1LUcHd8gY=;
 b=RoRdWxbx7Cz226BlV+wuzs4ash1lcYBz7k7bveW9qp1VWdkqEaBYRMXOkZg5MLtgJD4rkDNEX9DD+unfjIbgizF8uGXKBHIldL+PDUzYPUxvDKhN2O5GjKU6DgipG1+h4owg5ooc/N5ZbbW/ewRvsuFbeD6sA46Uf500/z3aP7A=
Received: from MN2PR19CA0060.namprd19.prod.outlook.com (2603:10b6:208:19b::37)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 08:12:30 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::a3) by MN2PR19CA0060.outlook.office365.com
 (2603:10b6:208:19b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 08:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:30 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:29 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 13/13] cxl: test type2 private mapping
Date: Thu, 16 May 2024 09:12:02 +0100
Message-ID: <20240516081202.27023-14-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b1d7b1-ab02-41af-bf6e-08dc757feed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r3nIfupQT26doNSZ2YH5AIGdNToPKA/j8WoroawPEpqYQRSU+N/f0j+ZG/ha?=
 =?us-ascii?Q?wEAuEt+mDvUzOyeet3lEywFaNit7yp3JIVLqTyFqVgKpyJNkluRyeT5T5LY4?=
 =?us-ascii?Q?k9T70kEQznWEEKYuz4nHqVa27JNrj7653MnJYucS2ivMH3GmAwE+cx9oHQfH?=
 =?us-ascii?Q?WWweONYTvNsgGjEpL1m+FAoRG1EYR9yLDge8MiojPjjnYWOANhDmI+vFGbur?=
 =?us-ascii?Q?JGuXSXJ+nw9q+Wl+x2kBt7jYXHj+GUPJ8niogusiKhZO4JQnQ9eUCgTVKNwJ?=
 =?us-ascii?Q?NrSWpE0X/WNkCT1CeL/b+iStRA1wIhEN4CEXs5KUd0aqQp8LoITaS6ANqpWL?=
 =?us-ascii?Q?4X/ngy+6uV/JS9eP6rxyxMv+at+BECi0QuIq5oQUBS/6sO9VP57TqXUr/uFH?=
 =?us-ascii?Q?/ALpK8RunxtFMWuZkO5ANHsAno8uMtf/VRpnuvkNfGzyVwoNhMMPFt2+8PAy?=
 =?us-ascii?Q?p2dk6Xzsg1M3B3JaUl35VSIvFN++BIwnHmedc4HIS6SMI/IkeimVCbsPM4b9?=
 =?us-ascii?Q?V7BUsj348UgEOBnszDC9oJjMhHP2w2EoneYw4TV1Z1C2UR/uedGe5eOWWdiE?=
 =?us-ascii?Q?h5+OE2i2zgW74jQcSQuh8s3TqcRmlGPYugj4OSfNOg5Jd+0BW+6dQB4WM7ry?=
 =?us-ascii?Q?YSWQq26AFjR5E1keU9A4f2Xp0gkcY5kl1gOY/SpdfhMb3DRU23a1SVI5EGKh?=
 =?us-ascii?Q?BwrsnW2fLOmcQKgx+gefr4M+1TxyBWcSr6mPRwk3zYishPtIKW8LcnCdW/vR?=
 =?us-ascii?Q?DjfHJ+peg4hthJgd8i4eonU3PhfaA9WhGtfQELZwp8Od/5ipQwwLX009GisE?=
 =?us-ascii?Q?iFvVO4eL1d8pIipRSaNv7mrzV8ONNVUqIfO9Wowf6+XpXYy+Wj5qVmknq2l7?=
 =?us-ascii?Q?KfyUL1S63Hislf0nl6ZilRYjSkRZdEYJTLbfRLaV8LEbaPk1DErlzeZjBHk1?=
 =?us-ascii?Q?BnmvCYrOkIdBfFaIMJb/+ptnjCHvaipsmQOaRLHNFgBEc8/xL5bYwqeU3BgU?=
 =?us-ascii?Q?XuPp/voFwWfmWl3cvsGclMr4IABRcBJhT1J8Qy5USd3HuYYPo6S3ro6QjOsk?=
 =?us-ascii?Q?u0CDRJAtGH2CQYgE6RX+hmx/w8SxkQ8xOe5q6PYv76uj2xLm2DaRgzNEhBYq?=
 =?us-ascii?Q?TU2Gzh87732Jq1YVevqkmn4pw8JZYpUoS5gehuSbm0tpgwmTrNiJOTQRmzbt?=
 =?us-ascii?Q?Yn83vz9r0hIdfQaTXMo3EudWnhHlDrF83LOhG4kfVZytf3Yr5bKw3qken/0p?=
 =?us-ascii?Q?bdEkZXYoyEAMF6sLYDYqNR6tXyXbz6bbI5cgLjfPBbDkVMxRLzcOrTq43HDv?=
 =?us-ascii?Q?e4TE0rULaqdos8YyQPX2D33iHcy68IURoVG2zBvz9i6LAwPaSjYbM7vgkdkN?=
 =?us-ascii?Q?xZzLEU3TxvKlggP++xz241DUfK7i?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:30.7843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b1d7b1-ab02-41af-bf6e-08dc757feed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

From: Alejandro Lucero <alucerop@amd.com>

Based on the cxl region allocated, map it internally and do
a write and read to a random offset.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 tools/testing/cxl/type2/pci_type2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
index 0e7f17c0c920..4bd71e444ab4 100644
--- a/tools/testing/cxl/type2/pci_type2.c
+++ b/tools/testing/cxl/type2/pci_type2.c
@@ -4,6 +4,7 @@
 #include <linux/cxlpci.h>
 #include <linux/cxlmem.h>
 
+void __iomem *ctpio_cxl = NULL, *ctpio_target = NULL;
 struct cxl_region_params *region_params;
 struct cxl_endpoint_decoder *cxled;
 struct cxl_root_decoder *cxlrd;
@@ -20,6 +21,8 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 {
 	struct cxl_register_map map;
 	resource_size_t max = 0;
+	u32 data_read;
+	u32 offset;
 	u16 dvsec;
 	int rc;
 
@@ -122,6 +125,28 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 	pci_info(pci_dev, "CXL region: start=%llx, end=%llx\n", region_params->res->start,
 			  region_params->res->end);
 
+	ctpio_cxl = ioremap(region_params->res->start, region_params->res->end -
+			    region_params->res->start);
+	if (!ctpio_cxl) {
+		printk("%s: ioremap failed\n", __func__);
+	} else {
+		printk("%s: ioremap OK. ctpio_cxl=%p\n", __func__, ctpio_cxl);
+	}
+
+	get_random_bytes(&offset, sizeof(offset));
+
+	offset &= (CXL_TYPE2_MEM_SIZE - 1);
+	offset &= ~0xf;
+	ctpio_target = ctpio_cxl + offset;
+	printk("%s: ctpio_target=%p\n", __func__, ctpio_target);
+
+	*(uint32_t *)ctpio_target = 0xdeadbeef;
+
+	data_read = 0;
+	data_read = *(uint32_t *)ctpio_target;
+
+	printk("%s: ctpio_target=%p read back, %08x\n", __func__, ctpio_target, data_read);
+
 	cxl_release_endpoint(cxlmd, endpoint);
 	return 0;
 
@@ -135,6 +160,7 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 
 static void type2_pci_remove(struct pci_dev *pci_dev)
 {
+	iounmap(ctpio_cxl);
 	cxl_dpa_free(cxled);
 }
 
-- 
2.17.1

