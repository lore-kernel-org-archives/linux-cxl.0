Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380B3A6412;
	Wed, 14 Jan 2026 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409385; cv=fail; b=B8acNh+1uEX1RtObinHDhOQUog45N8wwdvZo4SWu8t+tSD6QaZ9OT9tX5xr2E8odnD5V+BScTg09n7cIDTITnMHaE7hNVBUxv+v3jIbIBkhsNh1etED6kfviIpn3YhnPqNujU9CMCFtcA5phxPEQqs/EdrPbCGP71ORBNU6bpIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409385; c=relaxed/simple;
	bh=OaYlsG0W9qiNW3r8wewMyj1q1ORAUzkzIEioR6a+yxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6uKnKhy/FmpEVGvaX8Oa2wBSMKItxMUP3Tenoz6Cufp0UCaWPjLbT9JCvp4lMSMS4u5QnSEBZbT/ipr2mGAVDutq1lajpdeMdBWlJ4JHuHIr1fCPcnTGryygntEmhD+IyGayh6jROIp9ICxY0SK8BEc7nbVGrBfDgxdAjw+ZrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NHPF7uij; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NHPF7uij"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfeI+ciiYWP26dh6bdas/JyUeYp5PliJ5D1QP9wZlsAdsFpdKUsRR5IlaMNMwEYTE+IWBzOy53BtLLs5zUFmH2LGjPCp20nazdflfJ7RoJYfDc/rcZ9iOpv1qc9II0iPYFh8iqDyNzTpKm6sHdVzv3pXAT7wWmyJgSzSimsBTOS4xcNiLd2YpZhc2Yt6ayDagvXGdfLe3LH5TPeDQbe+N3Ay0p5r6fXWZpnOhhPIgapAqpXFHUz0DgG0RsSlw6UCF52EHw9mBlipodCFxOi0zzEPnX6Tvb2HP8bVKkwytiwHHvD6vQlauNGlixyYfdbgfPnFi4KX2e28vV+V1EeSow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzbBkRt07st8+BxfIZZdpJmdVxeK9lvPNgG21+xk+jI=;
 b=CSEMg0ZAYav5Ne1Vjwu9y/6r3OVx70cGvguMjz4eIPe7iyR75Qv7hnRNC58nB3KA1o8K1rJJblsPsyNXosWvyntqlWebXzk6zyZW/f5fUc4rpaWiZifAvqSTn+H112ptwbrnL8LATNMbUSxbhub/9zFFIjmH5F89/lDZy618JJ/lud/eBLlX7ka1Rs7GENy0aNX8jkl9Ffh8zg0PyP1OUbxSDVAQec7KJ+RkJy6Y2uu1R8O6DHob7VpF/AQh3MshekjGMYSb+AYmEzvbPwaLZk8NC+Z7HYnud4ELp+8MTMJl24EKYRHLfLB5umOj27zEK4ra3KCX6wKefb6Lh61+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzbBkRt07st8+BxfIZZdpJmdVxeK9lvPNgG21+xk+jI=;
 b=NHPF7uijsUT4RLfiUor/BoUelU3roBsujLPzxPdb1HGYl1HhdbTbAQbHqsw7WxYDapHY/TykOLewxgSf2MRZZ2Hz9kjKZf9vmIBLRDshhjcqJ1LEkrHSTe3ffO58HUY9+yly/dQYpn4Vk/ZUdtxM9IY8b15hG3bCglpfkhaVf2I=
Received: from PH8P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::6)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:49:33 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::ed) by PH8P221CA0027.outlook.office365.com
 (2603:10b6:510:2d8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 16:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:33 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:27 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 08/13] cxl: Introduce callback for HPA address ranges translation
Date: Wed, 14 Jan 2026 17:48:24 +0100
Message-ID: <20260114164837.1076338-9-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 894ce909-9936-4ff5-3cf8-08de538ce4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTIvczNleDVSa1Jyc3VxVXV2WnFIdlp6T0VKdXpramI1V0lZdHBVSTBLaXd3?=
 =?utf-8?B?V3hBMkhlejRjT25pWklJd3MyeG9mRDFwK0lBN01OTndzNWQ2SGhZTnlHMUtu?=
 =?utf-8?B?aG9wdGRiYWIwdjJrL0ZuYnR5ajZ6eHhNaUxjNEJ5UmxjVDdldzhLRlBBbU10?=
 =?utf-8?B?ZFRMeThGMEdsL0JscWlsSzRLdjNZZFI2V3F2bHJFcU4xWFpZOG4xaFBVTkJN?=
 =?utf-8?B?eWM1dldjWm4vUjFGMlhOblZKOGhWYnZpeE92RVpkQTBGenlnU01YTll3SEt0?=
 =?utf-8?B?ZEhPV281TmpGZk1xTmpOMm9iRnlSQzRpcldQTmNFbmNocTFEZW1RcnRKNGc2?=
 =?utf-8?B?c1kzZ0JUUU90aGM4VnlNTDR1MFZrT2ZDYUczSmp5aE44bG9aQmptWlM3K01x?=
 =?utf-8?B?eVl0UzFIRC9rTDJUd2hRVHVRc1JVTnQydFJXRkdrOG0rcHBmVDNCb2JMRkNo?=
 =?utf-8?B?alhuL3UyQWY0ckNLVldIc01GYTJQRWJRVUFyb3hETGVxcVVlTGFyZW1wUHE5?=
 =?utf-8?B?RHdvT0NHU0wzVFNkRU8yZXE3ODk1ZVkwQnF3NEw1WjYxa1JGVkx0L2tCQ2ox?=
 =?utf-8?B?TG4wVk83QkMrQm16eDhqaEZGb0IydVduOFgzN0kzdTNBb2RZWWQvckNtTGZq?=
 =?utf-8?B?RzVtc0xMS0x2bjVHSXJDZGZJa0g0S2lPVVRmREYwVlloVTI4RENnZTVUVDNO?=
 =?utf-8?B?NHBHZDEwQjR2SGNTSk5NM0Qyc01iRFQ2Mm1vRzJwNzh5UnJ0RXVETkdLMXhk?=
 =?utf-8?B?K1NIWjdxZ2E0U3FMaERlcS9qWkp5YkcyQ1dFQ0FQYW10b0xMY0xUWTdNMlJM?=
 =?utf-8?B?cSt2LzlJWlkrdENMQWpDWDBqeUYrYUMxVFBCZWFyVG5TamRCbkJJRXdNMXli?=
 =?utf-8?B?ZVFDNFNnUlQ0NW1CeE5zT0t3a2pzWmhSck80dEZaR3FjbEpwUDA2MEdlbWFp?=
 =?utf-8?B?NXEvczFab3NZamEyWE9KMW9yMHNjMm83Z1VzR1BVSFdHUlR2RXFWRmdjWFo1?=
 =?utf-8?B?SEx3c0RSS09wd2ovT05lVy8vMTlHQ004UjVaYlFDOHRyK1FIOTFKS0Z2NzNh?=
 =?utf-8?B?S2dPUjJKMlF4RVp0d1NCRE1yakJORDdxc0E3bHJIRWJNa0U1bitiZXgrOEEw?=
 =?utf-8?B?L0RqREw5cVR4YXNyZGRWVFBXdVdVdnVjRUZTeXR5TTQ0VmhxSEFmUXdER2p1?=
 =?utf-8?B?cTBMbUN1ZFc3SXljTXF5K1IzUWxDMW1LcllLQnlsV3hiT1VET2lCK0lGWjV6?=
 =?utf-8?B?cDJyODh5MjVjQmp6OHhZeHZJalJEWFdlZEcvRWt1R0NjTzQrak1xTGlzYjRu?=
 =?utf-8?B?MVlHdXl6RE1oWmhQMDBWZmpVWG5BYnBaM3AvTFhyOHVsSmMrVjAzVXJCY3Vw?=
 =?utf-8?B?QktUcEtEVUtQeC9PZDUrK3ozRTM5L1hlTjgxN2JhK3pGTkZTNWpmR1QxbkZL?=
 =?utf-8?B?em5nM3ZmcTU5WHd0SHdIMWZFbWNlTHdzNzFrWTI3cTdLeXV5Y2dYakxlZ0Zw?=
 =?utf-8?B?aUtKeUE1aC8vUVRqU21IbEFnRkRXaDVaK2IwUm9jNXoxSmpOelBGaGhGVzdD?=
 =?utf-8?B?N2VLczNISVpZTytveHMxbWVsa1YwRmwrYnNzMkEyZThFRUVFekQxajlHVy9m?=
 =?utf-8?B?YzJQMUhFWmRxQUdteENaQmk0UG9FK1lnQ2xuWFkzdzV2V3NramNxNFNWNVVL?=
 =?utf-8?B?NnFmcy95Wm9kTEQ0MUx0U0xsbEhZSXNvR0d0L0pBYlgxclNvUDdJTlA1bEhi?=
 =?utf-8?B?QTBWcXN4Yjl5cjhIS3JUWExTOWJhd2QxOTlrNmw2NU5sNm9uMENYeGYxSnNx?=
 =?utf-8?B?cGwvQmZacHBONE16N3ErM0V0S1ovTS96cnUrVTFyNUliYTBoSFNIcWE2M0d1?=
 =?utf-8?B?SEVnWHVJZHl5OVdxNVM4cEVJVnBiQTRZeC9RZm5pb2FsMmh2NXN4T3ZlM2xG?=
 =?utf-8?B?RGQ1VU4vcklHQlRSUW5mckptM3VSM09HcFV3cjQxSDZMcEFSbUdmR2tpQlVQ?=
 =?utf-8?B?d0U5YjM5ZWhrOFBWSzdTUjRDY0ZIdWVBL0JqdDRMbDdZNFlOSit3SXROM3p4?=
 =?utf-8?B?SWdBTUpTL3hnNlo3aHVWYkpMaDJ1WUhjK3RwV2VCUEhLOTc2Q2RvZms4ZUxu?=
 =?utf-8?B?OFFwNUhDZFRDakt1NnhuZEdLVEp6cW94bVFFbnhkcTZsNTZIUzVzRW5sOUxX?=
 =?utf-8?B?TnU3MUJyYXBpNTAxMTZrM2ZSZlYzR2drYjBQQmlYZXI2N0FQaUFmMzMySVVs?=
 =?utf-8?B?TFo3ZFhFM1NHVkZib3U4QUNidnZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:33.1079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 894ce909-9936-4ff5-3cf8-08de538ce4c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

Introduce a callback to translate an endpoint's HPA range to the
address range of the root port which is the System Physical Address
(SPA) range used by a region. The callback can be set if a platform
needs to handle address translation.

The callback is attached to the root port. An endpoint's root port can
easily be determined in the PCI hierarchy without any CXL specific
knowledge. This allows the early use of address translation for CXL
enumeration. Address translation is esp. needed for the detection of
the root decoders. Thus, the callback is embedded in struct
cxl_root_ops instead of struct cxl_rd_ops.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 912796fd708e..ed8469fa55a9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3483,6 +3483,15 @@ static int match_root_decoder(struct device *dev, const void *data)
 	return range_contains(r1, r2);
 }
 
+static int cxl_root_setup_translation(struct cxl_root *cxl_root,
+				      struct cxl_region_context *ctx)
+{
+	if (!cxl_root->ops.translation_setup_root)
+		return 0;
+
+	return cxl_root->ops.translation_setup_root(cxl_root, ctx);
+}
+
 /*
  * Note, when finished with the device, drop the reference with
  * put_device() or use the put_cxl_root_decoder helper.
@@ -3495,6 +3504,21 @@ get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct device *cxlrd_dev;
+	int rc;
+
+	/*
+	 * Adjust the endpoint's HPA range and interleaving
+	 * configuration to the root decoder’s memory space before
+	 * setting up the root decoder.
+	 */
+	rc = cxl_root_setup_translation(cxl_root, ctx);
+	if (rc) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s Failed to setup translation for address range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(rc);
+	}
 
 	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
 				      match_root_decoder);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0e15dc6e169f..8ea334d81edf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -652,6 +652,7 @@ struct cxl_root_ops {
 	int (*qos_class)(struct cxl_root *cxl_root,
 			 struct access_coordinate *coord, int entries,
 			 int *qos_class);
+	int (*translation_setup_root)(struct cxl_root *cxl_root, void *data);
 };
 
 /**
-- 
2.47.3

