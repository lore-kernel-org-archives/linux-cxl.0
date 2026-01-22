Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1CB39CB35;
	Thu, 22 Jan 2026 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102720; cv=fail; b=DWJbVDftOyqngZIrSNs8mGzR/dVxYKoSQqjTiPTT8tun31J76lMCjb3vJQ6M+vHlTUeEwr1cYvQapIl+lVvH0NosM90BD07rji35vWbPTQFE/Q55nWFUwRoDuOznhfJxShmWt6mPr7QIGqq+VWET7me37ci1s0lk9kMGhVyblJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102720; c=relaxed/simple;
	bh=loKctYcgkaOolNq7Vs9Z4BMN8884fTjffQoBTFIXusI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTYT+5/5EBUCrqYt4fpqR2L+4ShukdpcoLuDdN45LYPZ0iC+tK+hBoHkineBBtkZYennuroM1EzrFKB1IeFUD3DwLRZcW9ZHw4bYn1VvYQ9yY/1w/IlG7LNC2EGWu1ZDcc+q28dqC+u/bLrt39vPpE+BrZoizEXLTwvaF1nh2CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SHivgyNL; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SHivgyNL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi3WIS0PWi1nmhdgrz5lkc+TU5pvU3SG8LgCpm+pTlsbSl3HJ/EImzl+RoY+XSwG9jLN86v/zzQuAhv1V2LAvZviQL9qdsUefmzl3UnLuyvlnUqtccyATKS1SgjYpteemLc6Bf59x2kFxj0csuTc0RimJKnPdi6Cp5zE/pwALosUu4s14/cakIaKdsECbHnDE4YpEeDRuxUKA0P1Wr8NHYHHJ3SQOVpgMoGmb/ZOrMplmZT3xYpL2xoScdCgJwA2b8LfbqgowskrZry03l15L2+JfS6DFhFWlleHRyBDPujFXLaMMSmEkeJrT2aOCBoe71U7b64UYqrMrpHSX8DCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1IMnAkkRipu+p7nZaIhlLNlwllEr063M6Qnd6io+ms=;
 b=XXNvGhTRHMZrTQFnAho5mX6VsbyGQHWrFHfLArX0p/9nl9bzs0mLZffaPMf1CtyXk7A58vOsstuZ30lZQJGYwzQGUj18Ip5IMM6yIfa2SgHN9UuSxbY3sYvAixGosxEmPn7zTiRMqVH9NDQ5Y33Wtuuqvb5ZM3euXsjj1ucNfh12AWb5UQICaOGYOEhTULRJrJIv4NSlipUEdVIRFZwqdJIXQu5arclkbKYzgIzXOKbCDQlTu8oGen5yxtwYz1wBlvN84v+uJ3Il97iQ8tu3rK4m67VFGsvNXQ46tcHhOBnOPce/V2W5NgQOyvRU3vpCPt+JWrH3hCkPYm0G2OwRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1IMnAkkRipu+p7nZaIhlLNlwllEr063M6Qnd6io+ms=;
 b=SHivgyNL4XoM2iBBgSVlAGQ6TJwlXwxWSPn9iMusktC83jBLNIRQ53XHVVbblzcA8FRNS+1R4Wz+8kYz5pMvCOebPrqwHw8xgthY5GmWrGa6zM+YRvwNawDm0+VPpzg0xvKBTS0Ch8YacuyLatPrwaf06twiTEz0higAYhKECWc=
Received: from PH8P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::18)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 17:24:55 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::18) by PH8P222CA0003.outlook.office365.com
 (2603:10b6:510:2d7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 17:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 17:24:55 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 11:24:49 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH v4 2/3] cxl, doc: Moving conventions in separate files
Date: Thu, 22 Jan 2026 18:24:28 +0100
Message-ID: <20260122172432.369215-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122172432.369215-1-rrichter@amd.com>
References: <20260122172432.369215-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 432e4b21-beb6-4584-0c59-08de59db28ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUlFTWxwRkVkRG0xaEZiZlUwVFJSNFVSMGFRZ0RjZVFHdVpoRkU5M2lnTjNt?=
 =?utf-8?B?T3NtdGFNYVpUVzdkVkkwZE9DWjlNZndoL0VyaGlYWXNzdmNFNTJCVWM0L29K?=
 =?utf-8?B?am1QaWhTSDdVaXlTVGtLSk1pY1NjbjRUY1VaNDR1WDBMWkIwVG9YN21tZnp1?=
 =?utf-8?B?VXJGbjdmTEVRL1luZ1hIanIwZ3NSZm5xYVlVOE1rWkt3ejltbmVCRXF5U2x2?=
 =?utf-8?B?NGRkVUVCQWZPT01EMXc4dTJYdDVKRDUrNUlWUWhNYWJCQXVwY2dyQ29QTGJ5?=
 =?utf-8?B?MDViV0lKR1c4M0FLZkRmNmhFb3JrN3pGMCtjTjBYSy9zOVUrVkp1SHB1Sm9V?=
 =?utf-8?B?eXE0NXlrNDFPVk96N1E1RnBORm1rOWJ0b0J5TXh0UjRDYW5VQ2ROcFllWU1T?=
 =?utf-8?B?allQNU1jZHgycDZKYzlLR1ZOWGVTdTdUOHFqS3o4Mko1R1hJcTcxU0pOTkZp?=
 =?utf-8?B?NzI4cFpUa1BuUnB3bng2elhUbTNiOW14bHlGY2lzblRCU1ViQzRoQ3I3SmVq?=
 =?utf-8?B?akMrTkd0UG8zUHhqZzNhZjlnTTB0YUlFMVl1QmFta2R6aGRUK3JrZHQ0RjVH?=
 =?utf-8?B?WFphSjFoUGV4d0E0QjN1bFRSVkNXeWdKd3dTblZOaWFjSE14VW0rR3B4TzFj?=
 =?utf-8?B?ZEwyb05la0N1TE1rcVFEVUNlQjIzTzkxUXA2cmVRazBSV1FLN0ZGWmJVTHpm?=
 =?utf-8?B?dWJCMHdzZzRCNVBTaGN2cVJqb1dpaUgyamtZR1p4WFVwWUYyNk1PK3FKQmFx?=
 =?utf-8?B?eGw2UUV2WHorZG80dmEyWUNIZTdJSnovZVFIbkVqNWVEVnFydnRvTk04UnZN?=
 =?utf-8?B?UGN1MVY1VDRQL0pnQ01wNHJIR2JqTllwbmgxR1ZpVnJSak9HTyt2N1VDdk9V?=
 =?utf-8?B?WEUwR3lJeWN2K2Nqd1dJZEZ6RHc4TGZTaStpbVNncUlSRTJvNk9QWnRreGdK?=
 =?utf-8?B?VnQ2dDk1SkozZVQ2VStDR0l5akFRUWd4R0RJNzBWajFMS2JXdTdVR0REblo1?=
 =?utf-8?B?NTdlMkd0MmdKVzdyMFVvUzJIalY1TUF3Sitnekk2T2RRbE9JWmtFVmV6dmdT?=
 =?utf-8?B?UEJGTTYxcVZxVFpobVloc0dMbXliL1lDaHZocEZUSGtmSXhaMzNZWEJUTTFs?=
 =?utf-8?B?OFlnMjJQdWdYcnRGOVVUN1VLbStRNVcwNEhYWGFwOVcrVXlGS1VoZldMQ24w?=
 =?utf-8?B?RXRlcmYra2pyMHRlLytwOGdQa3N0VktyZ3RxSHhocG1GaXNveUlZWlFkSGRL?=
 =?utf-8?B?dXBwZy9ldW9jQWpxWVlJcTUyVjZ3RXB5ODFjMitQd3lBK3llRW95dStLMk9j?=
 =?utf-8?B?VzlvZjN3SkpxNEVZUS9oOWxaOTdsT0pKbHF1OE5ZU2E2K1A4dXRtVnpUbGFU?=
 =?utf-8?B?MlNmY0h4T1IwWmtIS1EzdlREZ0J3MnlEQnBCRzdKbS9ZRnB2ZWwrdng0REx5?=
 =?utf-8?B?N0pIRnJRb0s5aXV1cVpRYU96R1R0Q1ZVQkFVUWt5U3liRDlqVHpXTnNFZkU0?=
 =?utf-8?B?VktDeVNrMUQyRkdpY1dsYnMrSHVEZHkwV0UxNS9Fem9PYm1Zd3pwREhvazdZ?=
 =?utf-8?B?a3VIbURQbnMwYWk2SXBsREl0UUhFTFNBMHgzZTExN0N0azE0dUhaalhJT0hz?=
 =?utf-8?B?akdra1FlOXFCZmZReHYxQS9uOVpHamYxMDNHUUFRUkM1ZWtHT2lST1JLUnRH?=
 =?utf-8?B?b3RGWW83MVpSTUF0QnpHc0FPUjl4cWVOVlR0SjhRQWtHeENTdU5jdW9JUHp6?=
 =?utf-8?B?UEVYcFFmaktlUVB6cG5Td2k3SjJ3WDVOR1RLNGJDVFp3M0xLaGtkSmMySW9a?=
 =?utf-8?B?MGhCeXRzYmUvOUZPNmlrZVBnMUNVUVhNbGFiYXlpMnNHYXJ2S0lGMldZN2dp?=
 =?utf-8?B?MnhFOEFSQnNGOUZVRFZmdFdrMWJ4WFBTVTFPaENPV3BpN21TazZWanVGakF1?=
 =?utf-8?B?SjhjeTJjSkNrNitYVnRVa2VOSFdiblJjY0s5bmsxcWlyakxVbWNpckJqZnVo?=
 =?utf-8?B?NmxCNjVhaDRkZVV4K0JvNndXaGJZUDJhUXpUTjI0V3JQaTZxTlhvRkJCWHh2?=
 =?utf-8?B?ZUdPUGRLamFqSTRHeE5LNWxnT2hrdDIwWGMreTdzMWl2L05EUDFKcTNXRTh1?=
 =?utf-8?B?c2dFa3lObGdpYzBiTFJaaFZJa2tGS204amRUQzVwWkxZeXBMaERkTW56SENO?=
 =?utf-8?B?eEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 17:24:55.1725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 432e4b21-beb6-4584-0c59-08de59db28ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108

Moving conventions in separate files.

Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v4:
 * updated sob-chain,
v3:
 * updated sob-chain,
 * move isonum.txt removal to separate patch (Jonathan Cameron),
 * kept intro in conventions.rst (Jonathan Cameron),
 * removed additional blank line in template (Jonathan Cameron),
v2:
 * removed include:: <isonum.txt> line (Jonathan Corbet).
---
 Documentation/driver-api/cxl/conventions.rst  | 176 +-----------------
 .../driver-api/cxl/conventions/cxl-lmh.rst    | 135 ++++++++++++++
 .../driver-api/cxl/conventions/template.rst   |  37 ++++
 3 files changed, 178 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/conventions/cxl-lmh.rst
 create mode 100644 Documentation/driver-api/cxl/conventions/template.rst

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index ed4237583d36..9267a697b2fe 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -1,8 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=======================================
 Compute Express Link: Linux Conventions
-=======================================
+#######################################
 
 There exists shipping platforms that bend or break CXL specification
 expectations. Record the details and the rationale for those deviations.
@@ -10,172 +9,9 @@ Borrow the ACPI Code First template format to capture the assumptions
 and tradeoffs such that multiple platform implementations can follow the
 same convention.
 
-<(template) Title>
-==================
+.. toctree::
+   :maxdepth: 1
+   :caption: Contents
 
-Document
---------
-CXL Revision <rev>, Version <ver>
-
-License
--------
-SPDX-License Identifier: CC-BY-4.0
-
-Creator/Contributors
---------------------
-
-Summary of the Change
----------------------
-
-<Detail the conflict with the specification and where available the
-assumptions and tradeoffs taken by the hardware platform.>
-
-
-Benefits of the Change
-----------------------
-
-<Detail what happens if platforms and Linux do not adopt this
-convention.>
-
-References
-----------
-
-Detailed Description of the Change
-----------------------------------
-
-<Propose spec language that corrects the conflict.>
-
-
-Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
-============================================================================
-
-Document
---------
-
-CXL Revision 3.2, Version 1.0
-
-License
--------
-
-SPDX-License Identifier: CC-BY-4.0
-
-Creator/Contributors
---------------------
-
-- Fabio M. De Francesco, Intel
-- Dan J. Williams, Intel
-- Mahesh Natu, Intel
-
-Summary of the Change
----------------------
-
-According to the current Compute Express Link (CXL) Specifications (Revision
-3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
-or more Host Physical Address (HPA) windows associated with each CXL Host
-Bridge. Each window represents a contiguous HPA range that may be interleaved
-across one or more targets, including CXL Host Bridges. Each window has a set
-of restrictions that govern its usage. It is the Operating System-directed
-configuration and Power Management (OSPM) responsibility to utilize each window
-for the specified use.
-
-Table 9-22 of the current CXL Specifications states that the Window Size field
-contains the total number of consecutive bytes of HPA this window describes.
-This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
-
-Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
-memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
-the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
-
-The HPA represents the actual physical memory address space that the CXL devices
-can decode and respond to, while the System Physical Address (SPA), a related
-but distinct concept, represents the system-visible address space that users can
-direct transaction to and so it excludes reserved regions.
-
-BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
-with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
-resulting in lost capacity in the Endpoints with no SPA to map to that part of
-the HPA range that intersects the hole.
-
-E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB:
-
- +--------+------------+-------------------+------------------+-------------------+------+
- | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
- +========+============+===================+==================+===================+======+
- |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
- +--------+------------+-------------------+------------------+-------------------+------+
- |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
- +--------+------------+-------------------+------------------+-------------------+------+
-
-HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
-a 12 ways region and all the intermediate Switch Decoders. They are configured
-by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
-3GB. Instead, the CFMWS Base and CFMWS Size are used to configure the Root
-Decoder HPA range that results smaller (2GB) than that of the Switch and
-Endpoint Decoders in the hierarchy (3GB).
-
-This creates 2 issues which lead to a failure to construct a region:
-
-1) A mismatch in region size between root and any HDM decoder. The root decoders
-   will always be smaller due to the trim.
-
-2) The trim causes the root decoder to violate the (NIW * 256MB) rule.
-
-This change allows a region with a base address of 0GB to bypass these checks to
-allow for region creation with the trimmed root decoder address range.
-
-This change does not allow for any other arbitrary region to violate these
-checks - it is intended exclusively to enable x86 platforms which map CXL memory
-under 4GB.
-
-Despite the HDM decoders covering the PCIE hole HPA region, it is expected that
-the platform will never route address accesses to the CXL complex because the
-root decoder only covers the trimmed region (which excludes this). This is
-outside the ability of Linux to enforce.
-
-On the example platform, only the first 2GB will be potentially usable, but
-Linux, aiming to adhere to the current specifications, fails to construct
-Regions and attach Endpoint and intermediate Switch Decoders to them.
-
-There are several points of failure that due to the expectation that the Root
-Decoder HPA size, that is equal to the CFMWS from which it is configured, has
-to be greater or equal to the matching Switch and Endpoint HDM Decoders.
-
-In order to succeed with construction and attachment, Linux must construct a
-Region with Root Decoder HPA range size, and then attach to that all the
-intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
-regardless of their range sizes.
-
-Benefits of the Change
-----------------------
-
-Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
-Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
-with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
-
-This change allows the OSPM to construct Regions and attach intermediate Switch
-and Endpoint Decoders to them, so that the addressable part of the memory
-devices total capacity is made available to the users.
-
-References
-----------
-
-Compute Express Link Specification Revision 3.2, Version 1.0
-<https://www.computeexpresslink.org/>
-
-Detailed Description of the Change
-----------------------------------
-
-The description of the Window Size field in table 9-22 needs to account for
-platforms with Low Memory Holes, where SPA ranges might be subsets of the
-endpoints HPA. Therefore, it has to be changed to the following:
-
-"The total number of consecutive bytes of HPA this window represents. This value
-shall be a multiple of NIW * 256 MB.
-
-On platforms that reserve physical addresses below 4 GB, such as the Low Memory
-Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
-have a size that doesn't align with the NIW * 256 MB constraint.
-
-Note that the matching intermediate Switch Decoders and the Endpoint Decoders
-HPA range sizes must still align to the above-mentioned rule, but the memory
-capacity that exceeds the CFMWS window size won't be accessible.".
+   conventions/cxl-lmh.rst
+   conventions/template.rst
diff --git a/Documentation/driver-api/cxl/conventions/cxl-lmh.rst b/Documentation/driver-api/cxl/conventions/cxl-lmh.rst
new file mode 100644
index 000000000000..baece5c35345
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/cxl-lmh.rst
@@ -0,0 +1,135 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
+============================================================================
+
+Document
+--------
+
+CXL Revision 3.2, Version 1.0
+
+License
+-------
+
+SPDX-License Identifier: CC-BY-4.0
+
+Creator/Contributors
+--------------------
+
+- Fabio M. De Francesco, Intel
+- Dan J. Williams, Intel
+- Mahesh Natu, Intel
+
+Summary of the Change
+---------------------
+
+According to the current Compute Express Link (CXL) Specifications (Revision
+3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
+or more Host Physical Address (HPA) windows associated with each CXL Host
+Bridge. Each window represents a contiguous HPA range that may be interleaved
+across one or more targets, including CXL Host Bridges. Each window has a set
+of restrictions that govern its usage. It is the Operating System-directed
+configuration and Power Management (OSPM) responsibility to utilize each window
+for the specified use.
+
+Table 9-22 of the current CXL Specifications states that the Window Size field
+contains the total number of consecutive bytes of HPA this window describes.
+This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
+
+Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
+memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
+the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
+
+The HPA represents the actual physical memory address space that the CXL devices
+can decode and respond to, while the System Physical Address (SPA), a related
+but distinct concept, represents the system-visible address space that users can
+direct transaction to and so it excludes reserved regions.
+
+BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
+with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
+resulting in lost capacity in the Endpoints with no SPA to map to that part of
+the HPA range that intersects the hole.
+
+E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB:
+
+ +--------+------------+-------------------+------------------+-------------------+------+
+ | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
+ +========+============+===================+==================+===================+======+
+ |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
+ +--------+------------+-------------------+------------------+-------------------+------+
+ |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
+ +--------+------------+-------------------+------------------+-------------------+------+
+
+HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
+a 12 ways region and all the intermediate Switch Decoders. They are configured
+by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
+3GB. Instead, the CFMWS Base and CFMWS Size are used to configure the Root
+Decoder HPA range that results smaller (2GB) than that of the Switch and
+Endpoint Decoders in the hierarchy (3GB).
+
+This creates 2 issues which lead to a failure to construct a region:
+
+1) A mismatch in region size between root and any HDM decoder. The root decoders
+   will always be smaller due to the trim.
+
+2) The trim causes the root decoder to violate the (NIW * 256MB) rule.
+
+This change allows a region with a base address of 0GB to bypass these checks to
+allow for region creation with the trimmed root decoder address range.
+
+This change does not allow for any other arbitrary region to violate these
+checks - it is intended exclusively to enable x86 platforms which map CXL memory
+under 4GB.
+
+Despite the HDM decoders covering the PCIE hole HPA region, it is expected that
+the platform will never route address accesses to the CXL complex because the
+root decoder only covers the trimmed region (which excludes this). This is
+outside the ability of Linux to enforce.
+
+On the example platform, only the first 2GB will be potentially usable, but
+Linux, aiming to adhere to the current specifications, fails to construct
+Regions and attach Endpoint and intermediate Switch Decoders to them.
+
+There are several points of failure that due to the expectation that the Root
+Decoder HPA size, that is equal to the CFMWS from which it is configured, has
+to be greater or equal to the matching Switch and Endpoint HDM Decoders.
+
+In order to succeed with construction and attachment, Linux must construct a
+Region with Root Decoder HPA range size, and then attach to that all the
+intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
+regardless of their range sizes.
+
+Benefits of the Change
+----------------------
+
+Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
+Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
+with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
+
+This change allows the OSPM to construct Regions and attach intermediate Switch
+and Endpoint Decoders to them, so that the addressable part of the memory
+devices total capacity is made available to the users.
+
+References
+----------
+
+Compute Express Link Specification Revision 3.2, Version 1.0
+<https://www.computeexpresslink.org/>
+
+Detailed Description of the Change
+----------------------------------
+
+The description of the Window Size field in table 9-22 needs to account for
+platforms with Low Memory Holes, where SPA ranges might be subsets of the
+endpoints HPA. Therefore, it has to be changed to the following:
+
+"The total number of consecutive bytes of HPA this window represents. This value
+shall be a multiple of NIW * 256 MB.
+
+On platforms that reserve physical addresses below 4 GB, such as the Low Memory
+Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
+have a size that doesn't align with the NIW * 256 MB constraint.
+
+Note that the matching intermediate Switch Decoders and the Endpoint Decoders
+HPA range sizes must still align to the above-mentioned rule, but the memory
+capacity that exceeds the CFMWS window size won't be accessible.".
diff --git a/Documentation/driver-api/cxl/conventions/template.rst b/Documentation/driver-api/cxl/conventions/template.rst
new file mode 100644
index 000000000000..ff2fcf1b5e24
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/template.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. :: Template Title here:
+
+Template File
+=============
+
+Document
+--------
+CXL Revision <rev>, Version <ver>
+
+License
+-------
+SPDX-License Identifier: CC-BY-4.0
+
+Creator/Contributors
+--------------------
+
+Summary of the Change
+---------------------
+
+<Detail the conflict with the specification and where available the
+assumptions and tradeoffs taken by the hardware platform.>
+
+Benefits of the Change
+----------------------
+
+<Detail what happens if platforms and Linux do not adopt this
+convention.>
+
+References
+----------
+
+Detailed Description of the Change
+----------------------------------
+
+<Propose spec language that corrects the conflict.>
-- 
2.47.3

