Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AB4120A
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847153; cv=fail; b=T4gUMHx1YPWw0xW30EMhlVCd+SDrry60Mm2YzwS1T4VmOnoyd/BBWkkzgkUyP7m5T1OdqldxJaGFPJ3oGyFVdJ0FtTe41sadndzFrGvsJaPKSfQoK4ctxwi+mniZsjmvM9dcp7ADjQRMP1KvG28VJcd5fnRAT0rsGZZhM7I+b9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847153; c=relaxed/simple;
	bh=WC7FN9Njh3OvX/07BRiPIrApL3IN3y5Gp70aL53pujE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6HJSgL3U03u+PBznL0YbqL5qSgApskx9w5bRFxw6GGYsRNA3HQSPtSncZMw0yfn26piDqoJ2+63RYAOHVdU9nPz9AXS49nqUoAhVRGv0/50vzzXDsu1X680Ya1gNSGHOHoWBNzUbMjPvDisBq3hWcSW2v2wU6CvgyIPSmJQvmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YdLqnbuC; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YdLqnbuC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnFieR4zXG2nWoFEGjkGrG5H5qzVNFxOPp3wOOLw0hSTeYDKSfadD6gNpeWqoheYwBEAlyHX0X04xSvDs43vcLM5W3RkrO00KbxwyrnMSfocVuE5qcXf6ach0FRDOh5gAuC6KVMW/5vVaILAf4zOhB/AypOwAOoP78bOgO3oyuEC0dE9Na/0iU1QDL7PLSE4WTj9aExI75zlUdjORIBOLb0Jd4cH8KX4lhm2/ssFdMXtCdb5QCbZx1VLhO4PDijpjtg65ct/bxox2ZajJbYLPZEgWu8Mz4pLUdu7FgvmB+8IhKoH7GlWRoHvpvBjKDjcFrh5+gk1QnsVkMXnYZjZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdDtBRFT8l9xNV6Jr9toFs3vsXJOLYFBrMNBu6ZYRYk=;
 b=WX7/0kgwGUaOSrFW5Hh3doMnnUmszWTnAbX29/C5DHWc9IWmkLLT6ER/x2kWowISMn7aaT9b3IpX41VTgiMvdh58hjx0rwNSUuY8XB++8L4KmO2aEba/xJAbWS2FuQcH1zgn/wzzWTdNp1YGzmb4M/emC9Evgn7OsdFbAA2wSEryRJEZsZpN/XudGRkm6/gHMQ7Z+7o0SDuUodJ7SHNy4Mzl5VbP9iWlPKkIGICsVSxtJl9KoyPWf0bOsEM6jNZSSQrNtMI5vRdEHFe8OdtN1Df6xxgmk/gililuM0fSsZdUi6F3ogZ9Sj4gY6W8L/GqSrrOstQFPmcUKoQqyYmaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdDtBRFT8l9xNV6Jr9toFs3vsXJOLYFBrMNBu6ZYRYk=;
 b=YdLqnbuC8hfLzRXwlakVVB4+jTwbvurwWqAGuqZMut52Ux3VNBh+oyPopeWRI1vmwYwRqw3hPZMDjYrr6Xli212U47YZNa+Viq4VXouVrPFfsybGlGU2QDw5kqxfProx3WCVBkPv64Ra7hSqU41mwcEozrqCZZ0kWUhTVssCDhw=
Received: from BN0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:408:e7::13)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 08:12:29 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::cc) by BN0PR03CA0038.outlook.office365.com
 (2603:10b6:408:e7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 08:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:26 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:26 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 10/13] cxl: make region type based on endpoint type
Date: Thu, 16 May 2024 09:11:59 +0100
Message-ID: <20240516081202.27023-11-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: eca808e9-783f-45cb-9b09-08dc757fee10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v5+IAAT1b+NFtN3dvarSUDLMWJjJJVgr1LIouEcFqPPhtKYKQkgZBuvXpzd3?=
 =?us-ascii?Q?JaUur1Pnevq13FL7GtlI20HjyIKlF28blJ6Cjjjm31lhyoAO2HDbHGZOrHlx?=
 =?us-ascii?Q?Fouma0ALkocGk8NW0Ffu08OoQuSxoHMugM0a7ecC7tUUCwd1ko6ntMFJvJP6?=
 =?us-ascii?Q?Kf/O0ma75LDshnDgVCnTG4hxfT4M0PYoIwpX8mf1XDLE+/p1ELYNiu/7Wnx+?=
 =?us-ascii?Q?LuBrZ6w+i9W8KO8O/RIafbR6kMfChrx3UhnHbixThjzlkr81jan0h8+c5cSF?=
 =?us-ascii?Q?bezD5YXpUsOhqiTN2vRVdwZXZzL5scseQ+oNo/GphNr1MSKtiQO6NbkIfb6+?=
 =?us-ascii?Q?HYPFt+cmCtFlO3vNMyC0ymHSti5WBTG0IoTdEDJKtQDjlFPIUE46Edwessy5?=
 =?us-ascii?Q?Cjuq18IH3rQVjXImWSHlziRXAT5NVRb97+HCEi6LydG0vyKTa8J8MGu2lJnI?=
 =?us-ascii?Q?QFjQF7Lx8wCdvbFGUYUkjcxmmcDzcuyZcQc0WL/ALCoXIXdTVHruXvDa1mFF?=
 =?us-ascii?Q?C5L/5eb5TgWLjee7L8te/lRWuVO5tUa08SuYUUaZL/fiMS/Ndv5STxya1VMl?=
 =?us-ascii?Q?Oqrk4mXnYZba++7ufWb6I79RLJ6rl7dBN57zZUDkYHyNPznJlzyJmVgmdD3L?=
 =?us-ascii?Q?j+vaPNtoQ8IyY8p2+3lApWVgMGnaTtjpn4EIhhYi65m6pQmGZp7fyowP9sFX?=
 =?us-ascii?Q?4In+EoG4VjqL//SMess6dm4+Qmf75wrT+EChslck8cHT0Rvg8xAQIMiby3nX?=
 =?us-ascii?Q?teEZxSRDQGXIn1zbMd5nittluyTZ5GddBDlHNQXOHgvCvZiP8B12wM9ORm3y?=
 =?us-ascii?Q?RScI/B05zXgeBeuy7IAda0Z3aWwVxfGjKbfPcsBLmDe5+6X6W0x9Ok8i4wBh?=
 =?us-ascii?Q?YkFjZtZ8e17B3nlQzdMBkQHkSqQNp+xP2GBAikE1wkq7O7RA/8XMH34X/nOG?=
 =?us-ascii?Q?NOG96tPkaJ6lB4fmq31z9bwa7U1pSkWCptsX1crWgwIooA7L1lDvYCFKeC/y?=
 =?us-ascii?Q?Sh82Yq6ihjDeUZXmX4b7hmwHvGZLu5fGzgcCayDT6BSl3lvMwQDQEzaIQ96B?=
 =?us-ascii?Q?vUJ1fHqopEfwZzqVMXRY8+l3HHEZxwmflmXSGlO6MIpWLlvdm2whfWX17fjw?=
 =?us-ascii?Q?EVW1aaAO/lek9qMfcw+0ckJATNYAxZInC3W7CXg9wOV5LBqyYJZVJ4mG8ovN?=
 =?us-ascii?Q?hvWfZgPPSPGkYb+azqVgrQbFEA3RAskwNeUPeWxactujUyInXtB7UCpv9KOA?=
 =?us-ascii?Q?gyW8PZ2wzyrqUzrSSQtH1z0S6jDB6x7Wmqe8OAOn8wUOCFezzDR1mxDsvo+Q?=
 =?us-ascii?Q?UL0FNhuWzbn4JRuEboNbEVhc41EYIGKDE6oqWlh35rWpt5UaChr9zuclZBmU?=
 =?us-ascii?Q?YYDgPtAinuA7a05hywZIHF1vtmf8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:29.4661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca808e9-783f-45cb-9b09-08dc757fee10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Suport for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2731fd4243a1..8228b7e96d8d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2574,7 +2574,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  enum cxl_decoder_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2587,7 +2588,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
@@ -2602,7 +2603,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2622,7 +2624,8 @@ static ssize_t create_ram_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
+	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
+			       CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3146,7 +3149,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.17.1

