Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56D30E0D8;
	Fri, 12 Sep 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688372; cv=fail; b=gIjji8f4Cy2J+L+LkYD73rUVdsqV8dOe+OxdajXO02JIApcmR9jUyc0bqTzjWQP0VC9CIAV4VyJig/DvnUli4WYSbvKJvoC4FMUUon77ENfS4nacRg1P+tIzTGtpafoeTa/i3DAEf8KwULZ2ZbCVgE2kEFX3iJU1HDG9bDAOGrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688372; c=relaxed/simple;
	bh=j/Gspj7HsZlHCZYLAGeWuD7al9QKNR+1Az6lti/KaME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnQX/3yPcIkTZJcMNsS4eNDkn2PY857Grqd+3HK3X0wZ0vTxv3DtAc3c5aNCZXVkMz+484C3YkmdmVk9BBooBRXteYsXfvJzxkUdiYULQXNEJrugistR9mW4IvGj8Hedu5ZxoqvzgsxHVMQfx/58G6A+0dkzesIGIMvtm7v0Sjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z02sziuh; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z02sziuh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSlkI1P70IzPkOSYYEVThkfHYAf2Tija8cbzkzBpooHqDhgnmWFJYWrmkH6OPEprFGypjFrNg1ChrrOFFWCJGU1xmcOrWr/4nymQnd00taettwMVDevip3l3QB4JhF7rMHMoTzJI6F73WMwbQfeQ6/OPpAAj9HwCiRtQ98sY4bTZQMF8XAbgHCaY81hHpUPLxMpY1ATrMrLTzbZVm8hi26un5asLDG1l93405YVIH2AVU6mDldqtefigXySTRW8ONp3HLn97zQ2WQUrWcvKyxvO41tm/r94TEQvPAJhUWal1jstPchDr2xUON017DWH2V2DVkEz3F318s8Wm18SU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgcnoz0/P3DxW5OYw6uWfsVUxnsMcf/XridMCiQfdLQ=;
 b=OlmGmeP4ygMglZ0H6B5eilnyc2dPRyXrMlcJoGEq8ofGvLpwvksD5P9IYJF+vHVq0GZroDe9JdFu2kXkLf+tdmgYKdu/BFbgppBttgu5ts67v3iNyZgk8JfkFNQTJEm6ZXTE7hm0v/Q3vfO0twFA9eCUq5Dk1YbsayNye4Wc5x1yX5z6i4ycLyovdqZRohyz1eZcrGNCdQAvD3eKciFm4R3hWpGnb7yJXVyjO5l6bw+HDEnRwUD6RdkCex5D21yoragSmd3TowFq0wmnpZprbTKYXQPdw945CnDllE7Gcl+MZUUCdSM0bjgGvozUWK/Js1uRIS1seMWkfbMuCmIXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgcnoz0/P3DxW5OYw6uWfsVUxnsMcf/XridMCiQfdLQ=;
 b=Z02sziuhcpqAIdT2gQ9h6ZAbjZ13YzGwzegMp0KUfmk1YYBjFt9GBBRTxx9m5L4rA13re7ku9zv4WMvQuS0xMV0XJeaqAZxvtZurPYRqXxcTRzxWrLn37gKzqHs7TFZWCNHwPO79fadva43NotZvAbK2PhoNzE9m/DH3FBJlEww=
Received: from DS7PR03CA0039.namprd03.prod.outlook.com (2603:10b6:5:3b5::14)
 by SA5PPF7D510B798.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:46:04 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::56) by DS7PR03CA0039.outlook.office365.com
 (2603:10b6:5:3b5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 14:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:46:04 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:45:58 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 07/11] cxl: Introduce callback to translate a decoder's HPA to the next parent port
Date: Fri, 12 Sep 2025 16:45:09 +0200
Message-ID: <20250912144514.526441-8-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: d3028542-08d4-4c94-630b-08ddf20b19b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PYYnxSJO/r2fNe3Lm8z0Uo9uQ5/iHiLH8USpb45GpHyFliZsdANF6L8HBO/U?=
 =?us-ascii?Q?nlrbdX3cbr17wSAO6gv8xCtUWOVc38L1X2NuWnDyU9AcEo3PKRxiDMD8nhf2?=
 =?us-ascii?Q?5SDYR7SgurPXuecwsG1kasJEdAlAbTBw8p6Faqea/OukeLfxDRmZ3NqyiAE+?=
 =?us-ascii?Q?YYWTCUz9ZzogX17wM0D53/VODOUxShdayjd5/Vtxppk/G/ibswFBOLKlfzVC?=
 =?us-ascii?Q?6exvhFqxCFc5ZkqaEsHCJd31JiD+PTPEVw/Y76qZWknxbCmN9Hkc7P1O+Qlr?=
 =?us-ascii?Q?zKKR+/U3cxf7LcenzpGyIJt8K5VBNXSavDzTH0OaYafNMFA5QMfhVJV2APG9?=
 =?us-ascii?Q?vcH4eUwE0oDopvcmJTNc8uKbxHDOK5KIaFCZ9BHNmKPRVsdk2aN8w/+BKKOF?=
 =?us-ascii?Q?bJgyENfcmSgAH9YYCoVjUevBEcLuEPei/RipV3PNBb1D9DXMUUKROWnDcC90?=
 =?us-ascii?Q?odu6+wmATCMphZmcAi/EWjhGuiekss79PJRPjnYE/9QZ2taqhFKhmnjpFCbQ?=
 =?us-ascii?Q?6mpvJa3+MniBL2R/NPoo9Zf7CftA9Sv2sV0gzYt6+yDjsjhpqbQLHUU67I1d?=
 =?us-ascii?Q?ZUvQ7uUpYcnZrgHVo7XY+8MJXClpW2iD0IuUFz/JEhj1584PMIAPj9N7gI04?=
 =?us-ascii?Q?BlCZuDY+jfkGG17EtzTwVdzdU6/UOdUk3V9DTVAtd2FnZjCf7xzEbU/lPKqv?=
 =?us-ascii?Q?N+nUtNM3Jcu9BM0I69xCMYZ1mBVBRiOKUnSLTmLrDQkrHN1MVEldmOOZdTNX?=
 =?us-ascii?Q?TdNXINgBhjyFvU+254XDElcgGv+ikgaXlAfYg8A8uohXFV0QrEbFq2JESLyX?=
 =?us-ascii?Q?inY+I1Gr4eiqkRcFivpwoTsrUASYQ1IEN3PnXL73Y/81TA9z9NXx7kOTQ97P?=
 =?us-ascii?Q?zXGSPHIhKG1WisOO5Y8g1tBgz4PGSwWu21mDnoYxsx+d9JVv2v/B9IYXGLoq?=
 =?us-ascii?Q?HznpV45GuG39Zcj7j+QCQow6vQ8d/13jK9AkjtbREEt2hWH7g14+NUlhkayi?=
 =?us-ascii?Q?j7P110Lj4eHT1MBWk6cMGO59MIum+c7UiH58DnKEgmtehbX81UylmDPf01c9?=
 =?us-ascii?Q?BNQVfc4GuqgZk2FmiMxWklD1cTUC4vr1jXT5rtlRTgud97ltKaiFzU8sa1kZ?=
 =?us-ascii?Q?Wyy81JRDJ02oGDQ2fxw8B35xqSpFQGnDBgQCyQQyP1b9OgqRy9rHff4IPogb?=
 =?us-ascii?Q?bH2O/UpuF0fHM2c5VL2WQ8LMvC4B5q0nVDzEDWPGtdSdibtDCQMPlZukq/op?=
 =?us-ascii?Q?7gJZB1CZVKMwHojLDlfOTpA8cvjkdUwIGXZDeJQ0NjtzHEJKie/+mjAvlal9?=
 =?us-ascii?Q?+k/HjmtUU2gSnB+ra8yF8wgS/bk9Ve9AbXceeS4BZvhhupQ21FkP9FAKoz+m?=
 =?us-ascii?Q?QZ6vLx0erTa4TvnfW5DqLYP4JG1rxaeZGSc6HAG5kAwPxeNK7C98COz9d2YL?=
 =?us-ascii?Q?8X9rr1xUItRLlb5DW7tGTquSJTN4vx6twIv0vGmHiFbabK9+mRwS1HhNUbA/?=
 =?us-ascii?Q?ZD2fIMbwYg9itbfC20zJii6+4HYRNyFnrzzZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:46:04.5792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3028542-08d4-4c94-630b-08ddf20b19b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798

To enable address translation, the endpoint decoder's HPA range must
be translated when crossing memory domains to the next parent port's
address ranges up to the root port. The root port's HPA range is
equivalent to the system's SPA range.

Introduce a callback to translate an address of the decoder's HPA
range to the address range of the parent port. The callback can be set
for ports that need to handle address translation.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/cxl.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f182982f1c14..eb837867d932 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -429,6 +429,17 @@ struct cxl_rd_ops {
 	u64 (*spa_to_hpa)(struct cxl_root_decoder *cxlrd, u64 spa);
 };
 
+/**
+ * cxl_to_hpa_fn - type of a callback function to translate an HPA
+ * @cxld: cxl_decoder to translate from
+ * @hpa: HPA of the @cxld decoder's address range
+ *
+ * The callback translates a decoder's HPA to the address range of the
+ * decoder's parent port. The return value is the translated HPA on
+ * success or ULLONG_MAX otherwise.
+ */
+typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
+
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
@@ -599,6 +610,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @to_hpa: Callback to translate a child port's decoder address to the port's HPA address range
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -619,6 +631,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	cxl_to_hpa_fn to_hpa;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-- 
2.39.5

