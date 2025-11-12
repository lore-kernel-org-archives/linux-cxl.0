Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBEB2D7DFB;
	Wed, 12 Nov 2025 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980700; cv=fail; b=fB7IE0RFYw6Ug+hJO91FC9pq/WffVYL115Js3cpIzSuXqdpJAaqvfOX2Cs7UtZ7MISUJLqEKEIMLBBNf56PEOagdOe+TI0wV5dcUsYiSToqwBSht5ANLfWB+8scq8B7sMIXrVCdaxuZM3ncdifYzqQyHZKb/15Lhio8g8FTRF/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980700; c=relaxed/simple;
	bh=0VHIY4g5AbPH1stjO+DqQ4jJnFV6otBjq74BhLKSDO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tel44xBxBRG0Sfp3ZwiNYqlT8YLVpHfa/8vchV6s3CD7mVJoCY3Ro1SkGLaoHwe1p5XsRSYOKsLAO/EiH5pw7zrfHlSND5pCYS/Io4KX1iMU5m5yfvLDXDI0u9xzd0xX/up8x03Xx+yiGH6uOPCAQHpNcHrcjiOK5xfSTm3OmEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XlvZnCiQ; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XlvZnCiQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmsLvCa1kfKXqlhv1tal5PVarT05MCMEo2TChzSZpTlfLVuFybBF18ilJOZ75ksaQSdUGk5KimVQHAaqjimOAQijz1SpobU1zf+31lWQ4xjoS2AjIPszAL15WrKfkLt5VXUFq9VXB+HtcK5wml7QWWBm1tEXzvtAWUryp/7XeUcE0gSP/aOmRCl83vpFvvxQKR/VwHL929RF54uGhl2KcUdp4M2kkDzOoGKqCtv3nMAAChGJWZyUzBwJVgesk76evIPpZhomWnsP6Ump1dEk/0V7050TC3iGK/MK4xLFVQc7u0EQkCCu6+R5Eb0SN+nF+mqJzVqFOicpilD3F/VlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4poZ7YVioMDsbtqQTCtChgjUhNILvmLSOYWUZXUcOt8=;
 b=gsQLeUH1o/LgkVYD1CyRPLzNimt4b9beUlJHXKaz+5Uywsvy0tTfJ3m6NceDF4enqXEo07ChQxIekeY5H8Wft2C3V8MOSGBHZNwteH/3A3OitgmDqP99fXTR9eoO55Tqtx4CezdvrvVF0rDoDlUuAYqzWirCGtZINsctSNTNjp6yCmyIFNBGmeNIx86BFH9UttoFm/wuaeToepVCNKA2WUDnrkw+2JBymaqituAnAOuk07MmYTSOuu4D5JxFr4hl5vm2X/75SbuSv+WYZtxrpgKLCBpLfGDFg7y02auLXzlNZIcm5SvU95yn2awNfwObQnRxEtRj/uMONvHBYyN/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4poZ7YVioMDsbtqQTCtChgjUhNILvmLSOYWUZXUcOt8=;
 b=XlvZnCiQ+L7vnVHRK70WTxtfiIBqCPlpSJ3Bq4MUx0OXl9mu28dk6/Hp6yWDwzlklQCl9rFkHN4CEyR4pksJygSn9ZfshV0de03XxJqt6CtyjpyauywL3OMgPqcudAYzFR23XnN0AuGLXzC/6ewlzQ/ysTtOs034voEXcO+a5Z4=
Received: from SN6PR16CA0052.namprd16.prod.outlook.com (2603:10b6:805:ca::29)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 20:51:32 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::63) by SN6PR16CA0052.outlook.office365.com
 (2603:10b6:805:ca::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 20:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:51:31 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:51:28 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 2/3] cxl/acpi: Group xor arithmetric setup code in a single block
Date: Wed, 12 Nov 2025 21:51:03 +0100
Message-ID: <20251112205105.1271726-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112205105.1271726-1-rrichter@amd.com>
References: <20251112205105.1271726-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d61263-5549-4bd1-84ef-08de222d4288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yTHzWkJ+WZD253h9d+WP2DDH78zuS8EmG3ogX4nVpG45eIU1w2CubT+nH2sZ?=
 =?us-ascii?Q?a1mgpewGXDvK5V+f8zpH0LUHnDciy/Z63cnLpgG8uQro531n/2DYyoRzVpJv?=
 =?us-ascii?Q?ptQrsFYWN/9hVFfCfNH+J58fo/f/W14y15U7WCAlCbPFAvIr+b0iAftbVCMN?=
 =?us-ascii?Q?MXYw8ff/qZly4loDcHszcWw3FMw/gUcDSW13bfEseB6YzEZHstVxkWUKLCGR?=
 =?us-ascii?Q?AV9H/LHNdBN34bF/pcWgEphqM+UuuB3KJooMJbpBzrVFpwDldc91nlkgStBK?=
 =?us-ascii?Q?/B3hRhrBdyKApPp0QcpuMw9f8B7dpVJtnaVX/12MnHnCxVAcrVPs/pVC1NrV?=
 =?us-ascii?Q?neFWyVPBZr5P1Zxpd9eDweXR5Q8RomtUFF1RuP0/aWe6gIN3zKsnjN3qO8w+?=
 =?us-ascii?Q?VQj4uHumF7RubcFB5/mlPTaLX3UM9eVyi/OQXZcEkhga/0uf37iX21KjYw5t?=
 =?us-ascii?Q?opCL6OQC0FDejkqQS8ho0lk1fd06hnSX59eHmg2csc7YYoeYFct14BwkeF4m?=
 =?us-ascii?Q?bi3ROfpnGUcYnkGiSEADDhLz8Vqi5cUeQoBlnzP0KArHf3hN6FEk8vUSb9UC?=
 =?us-ascii?Q?1JciCpgMGLobVo0BvPCObm90QUJ6PL++PFefsDTQ6pS4A47XEf/Gz+Ae2yWa?=
 =?us-ascii?Q?Vxydl18rxxVuPAYzRF/iK+jvAjh4rh+729SmT7Tp5HiSqk1JOeTxpzMMtG8c?=
 =?us-ascii?Q?WZ+iqPb99/pFN+PnWVZRItSGzH7jobwdAwhl0afbhxk0W53H01ed4CLoLaqI?=
 =?us-ascii?Q?Wi1Tk0flvDmD6S0TgP75u9B5k94wj5MyUa9KTAig6W0Ki4jC9PyGN9J6FLXu?=
 =?us-ascii?Q?UBNZ9oCWY1z/V7Y+yKBE5EIdPheLmZeJNyUs6TLM1a4O3txy2goucorO6JnF?=
 =?us-ascii?Q?9/E0npGkxGz7FAxev5ATEZP7RPJTzBOiDPAOcUrHKSD7HpXtI4T258qZwYtp?=
 =?us-ascii?Q?kVsObE9g8syybY2xv4am2OlQ5osMUjGTS6dpf1Ks4XZQKVhAo0lc9+uHQNE6?=
 =?us-ascii?Q?AJloVHBVQr0GJvVdypo/kP3pfh0XjgaxUo9WD4BpYuJ/+8+23bYCqzopk8Fc?=
 =?us-ascii?Q?7KTrT+W5ATlkB+vWVWKjnBAg5F5Bx2FdKgAlbTKP0buo/1d0+E8IbGwKreH6?=
 =?us-ascii?Q?DOLRznqhu1TCAjpeLy9buZt7YqgXMWstybGOQFsGqHSPItxtgRFI7TzL4z+9?=
 =?us-ascii?Q?OgyGqP79MbVDXB0bYqhfZ4ewi5Xik6S8Zqh0apSwM31zIoXN37haTSdCJbUG?=
 =?us-ascii?Q?jHLMwvUGfqrjsdBnRinPY/O/Nf5bkMjq46uVFUajdzLoXnEKwHe2DZwMeyE0?=
 =?us-ascii?Q?KALQc/DgdWirUllZLDCtzLQWW5/MuUYv+n6+kN0XVqVFXR6Z6HYDPZklXZb+?=
 =?us-ascii?Q?QC+M3TNIrTtosMnI3PoXEvitL0BSUWWmrU0sUBTNTQ3xN3+VA41oKfWKDdri?=
 =?us-ascii?Q?fRTGAmnaWworRgrEDDdq44D4ZuJV7ChyO1VIWjR84CvZO52HqoZAYXTbMTX3?=
 =?us-ascii?Q?KJOcYy4MKuKVGzC9XrQBIsPLPbxPJtdeqom5tf1zo3MbZCWcgvF7KpdIN5kt?=
 =?us-ascii?Q?VXXtgRp2aoGU0ZOXlX8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:51:31.7661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d61263-5549-4bd1-84ef-08de222d4288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094

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
index fab736aa77dc..50c2987e0459 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -465,8 +465,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
-	cxl_setup_extended_linear_cache(cxlrd);
-
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		if (ways != 1 && ways != 3) {
 			cxims_ctx = (struct cxl_cxims_context) {
@@ -482,15 +480,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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

