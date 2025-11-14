Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E62F8BC9;
	Fri, 14 Nov 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107165; cv=fail; b=UxTYokwHS1W228Un1o8xr+hyw6H5B75UCOCe2Q1bNWunw7Hju8sXRh1BuwIZdEqaWqMzxp4GO08HmFnkXI8dn4Ey3R4hvh/zyfAeWet4saTIiBwZ6xY9EJ9Holx+dpyD52AqyihOVDQlgCZOuNui1vHm8xoMW+wJ2m6f19g+lnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107165; c=relaxed/simple;
	bh=PDKTvTvCBFECUgIrHqVAB8OlQ7BYiZ/cV9+GWP8oRB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXNmLNOv08GtiKkj8GiMIfGQi/qF6cfmX3GhIb43/BtZxJYMhJAFE5xGZejzqqvXyAj6EwRRMnYCgSu77qr9CeTKrRdDGSaiNwVY+J6cA6+ImXY4Hhx45H2Oz5cpxYVAAYAcPYoJQO3pp9wCHNxcCmbkoshqQNcGpRLQ7suu3Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n6Jnn+YY; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n6Jnn+YY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGqp9myXNkVPC3TIRlcs0qYnjvc3VWhoUaOhF0Zc5mDTrlwqbZTwuNzgn8DGYJzHlAo5z0yfC/1roKt6oZsLqfCdcEakSHL126RFKOIXAFuVcwu7nIKpAna89z51GgGkhsGqKZi9nEfpFgbUIgdSAC3Pg8rCeKK5AXCelheHixx49w1nT9GyWMhzHXQjCOSO6SLmj+u8PcwBa6IzvvExi0bo9Ra5yuxZn8RX50OY37qZEs02JENO04MwLGO/Q/QY7D1VCzXMCLViJXJK+v3VDTAG52B+X+Nb92wS1QhcnYSP+iCgm7+44+Rp+z/2qtOWUUmvSy7ZyuPFqeyJZS6Bpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7YjhxisUyINIEIMGA3R8nL9MOC8tdnfrtPYcdW7Dgk=;
 b=VV+/RCmZkD06yZbelALb9B0ijcvdAyRWudq2xQEd7b7mmAcsZrxiyENiToc1h6oBlC+cbPSw0Jzi8Nck0OftHsz48ZAG6wF3yiJZZDxJNFuXFPv3x/yUDUvwn+RFotM2COTFYGcNkI3Z2FgfPYanWzyA4Hk7bjW+KIjfImzcfHpn5Do84puW+D2hUcJWfK8JYnr/iGsPo2POx/tLy+7kb69AMNvgrdODxiEE0xBAZOFzvQZkgJO2s6KeIDqvPF3p4D/9QP58Dnmj1Xkj1/g+WMcZSAnMBDgBfMkDvDevn1o46vHtCcqtu/bb9UKVBVPa1pAdtsFO45tGkf9g6ERNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7YjhxisUyINIEIMGA3R8nL9MOC8tdnfrtPYcdW7Dgk=;
 b=n6Jnn+YYGpAq8SJ8g0FW+Fy0WhlSW8GtWzMbAytclbrU8t1GjIjShFDs/D/EXb/4n8MvlLhVu8sKHJfph3UFPIZqGiAInyXUFO+giVwHGwZiPv5yyTuL1Wa+KL5TqFlllED7ZLg1xG08drE5PoheYT7leooAB+YrHAEWTBHeST0=
Received: from PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::18)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:59:19 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::ab) by PH7P220CA0118.outlook.office365.com
 (2603:10b6:510:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 07:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Fri, 14 Nov 2025 07:59:18 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 23:59:14 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 2/3] cxl/acpi: Group xor arithmetric setup code in a single block
Date: Fri, 14 Nov 2025 08:58:42 +0100
Message-ID: <20251114075844.1315805-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114075844.1315805-1-rrichter@amd.com>
References: <20251114075844.1315805-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ad7295-19b1-47e7-980a-08de2353b6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kTLDCRLDWMuVMkg3uColla3NqIsRu1XheV63OsVW5Y7p8vOYr2oUaSxgOWEy?=
 =?us-ascii?Q?WH0HeSV0VJScPUzTbENXUA1iTQeePI5WzTFqjJ2sZ5llAlZAwbRgoDuOcLUF?=
 =?us-ascii?Q?qxvrl5phHarz5lBFlJxwTshW97ZPkmVXo//HLUszgvrFb7n2+cBdOlGc7On4?=
 =?us-ascii?Q?MsO2GicBU6o1YdqKML9EH/DT61JhCowfSQlQD+/YrhNXHcUJR3pp64eMjXyn?=
 =?us-ascii?Q?TVPR6O1H07slURlMbYQbeeIN/GLsROdOgTzBjHVy+0KYShmQgoeogwYJHinG?=
 =?us-ascii?Q?Fgqamz6AAeNMnvZOp+W9+bIPdca8eTHFKVWV3kOaBdIE54Pxn2ubozD2FKUo?=
 =?us-ascii?Q?LMUpoF4fpHi1zbWg1OAI5f98bdDAmE2BVadY6/X1HO3Z1gHdC0Jo9lmRN0K9?=
 =?us-ascii?Q?leGIEMamdtI5zllSstSsDyIG0USA1mmNWGo1wgeII72lmE2T/0caV5nre/Bp?=
 =?us-ascii?Q?YvJsFlAfhMkpzvmjodxTxlmX93IaSKf6ZMQpdxX7urY8Tq+o8FcGwMunLBDU?=
 =?us-ascii?Q?mmM6TXlRWXF84XA9PNlKFR0dDy4mQvMImStC2Rx7M83BzHKO76bOUrkTYQWI?=
 =?us-ascii?Q?CiASwbFvD6LxgNU1fCuQ7B1xXW+WnWNmzxazgfCTFBURCWt7+Nm0HC8zVuyN?=
 =?us-ascii?Q?iGUMn3QDaWYIU5nHjUWSAUzfwCOUrJxyE27CW7PPO557yOfdiP7qWEC7d1Rb?=
 =?us-ascii?Q?vy0N34uFKi57dLJh1mrNoBQXzii7n+9hyrDO1EXV6v/zZEqdGEsW7oSIJ5Ne?=
 =?us-ascii?Q?nGJnL0UNXZZSQtsBwNwgIG4l3Vps4vPH/uK3/M67E5WFUqbzLM0a3guHSkFc?=
 =?us-ascii?Q?JbRrugr1mW8j4b6IdOaRmyEkTXZsiytiCCGrPkJ0rit5zY7oR191xVrDGLrB?=
 =?us-ascii?Q?zNyQsnMmSos5blXdAeM5msTupfJOdoApgd+59jKPgvUb6zN3w7RppVPTqtSC?=
 =?us-ascii?Q?mU4ll63tBTyJpZzTfwr7GNjkKdyEtQBnoCGoxEn6kB2ISLfkNVsed+9SVsKQ?=
 =?us-ascii?Q?Ua96tUv4GozUHFSOBJpYXv0+F5TIYjWhC1YLdYgvpA+iFOr7UrCPn/g74VVj?=
 =?us-ascii?Q?T6XhG8mTVhiQkzJmqbaud3KLAMO7ylCdJIlSV9cDW2l+eDUOdYf5iDyILnJ1?=
 =?us-ascii?Q?GgSwSnUH67JrDUYtgDYtLBBpgVUrO2v4bTpByVZELsa7ebqiDMPIcy+DVvmh?=
 =?us-ascii?Q?0/lHd0HRO9IVCsh9AHH+nCignTA8xlQ4mBOJdgQixI1wG3Hng2mIedZh18nb?=
 =?us-ascii?Q?UuSGG00YBJAcFZZs9a/sZRtHcGZUJBQ3ooOcETkWeuFAYSgPNIV7zY1AhyEI?=
 =?us-ascii?Q?uB9FGbOVV7esS1I7Aln2ANAMy4GgI6gtDQm2VofBCwgJSX5ZDbHBxD7Hs9RS?=
 =?us-ascii?Q?C2P6jYMn54hl0mE8qtXYO7j1dNgS04vCiXixeBE5M7luAltwwR9KL0+REAyR?=
 =?us-ascii?Q?mR8VbTMPA+6tQuiitWDkOR4efFpr8BuN/C0kUygKW/wTqbym2GWXYk8SI9mK?=
 =?us-ascii?Q?i9Q5iYp7uf3b2XqZOdzkjUoZCDczPhWDpmb6k7cE/TcVhUS0bzW/4ieu29GR?=
 =?us-ascii?Q?n6+o0/uldTMIDjORa9E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:59:18.8552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ad7295-19b1-47e7-980a-08de2353b6d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

Simplify the xor arithmetric setup code by grouping it in a single
block. No need to split the block for QoS setup.

It is safe to reorder the call of cxl_setup_extended_linear_cache()
because there are no dependencies.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v2: spell fix in descripton (Jonathan),
---
---
 drivers/cxl/acpi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cef3e07244fd..0a1bad3cafa7 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -453,8 +453,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
-	cxl_setup_extended_linear_cache(cxlrd);
-
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		if (ways != 1 && ways != 3) {
 			cxims_ctx = (struct cxl_cxims_context) {
@@ -470,15 +468,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 				return -EINVAL;
 			}
 		}
-	}
-
-	cxlrd->qos_class = cfmws->qtg_id;
-
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
 		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
 	}
 
+	cxl_setup_extended_linear_cache(cxlrd);
+
+	cxlrd->qos_class = cfmws->qtg_id;
+
 	rc = cxl_decoder_add(cxld);
 	if (rc)
 		return rc;
-- 
2.47.3

