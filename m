Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996CA2C326F;
	Fri, 14 Nov 2025 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111160; cv=fail; b=Tg9CbOaqsAn3n5sJGZjc60pqT+7G06BAx+PTpAbj7uexVgCsTlq7SYpW6g4ZIt1UieOGvkAZguIHco9tV87dWC5wdqKD5Xg65PayhXJy2cT1GnCCPOs6MiUJ5Uy2dQxCkKCdbSNVB1tNtdd229kd/tBbxEIbvo/syCQsArEI7c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111160; c=relaxed/simple;
	bh=WyQEd/Hztn+rpz+wIprQu53jrRqtVS7GuqtSe3PTH9E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=azoR9DcWMv3OuhC9P2iA42ExC7di+5Tm0CeV0KKih4EnNKnt8NrD8K0HnpyG7NQF8YYg0899on9UesdBNpblUorjW769bOYimJNGmNu8P+edVSE6HS0JbY2g92FoA3gIkG+Do5RZCpBeTDwrfIZNaupwGJuCs2y/abzCGGoHbC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KaLcar/c; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KaLcar/c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdqKNkvAoxA3926lsFADsNTeBY5uXt+daKUN7qWg9gkXxqqvfbEjfc4ZZ0toW1guXkh4ULLnJ0GMnU1afn7QLcUYLSPz5cBG9e9ckA45CcNcbebDyJSXrGNolwE5XKzwiMCskh6H4m1gFBBNEVJG5OMccCLPsBUJ2Ts9jVwQLMg0tqkeYttlIRz+rYRts9cqy0uD16VMSf709rHBUzX0SakDu+TWAUH5TL7L7E2ETG1LSqSgbW81pY8H0jiVWyA9xFd5WEr2iFH7bQgcFgVqamoGs+JzLCGyd8v04wWJIxBQ5TNSbckb5Po5kdOe+tWcvVCCoGniUy9kYopHB00KNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3PQqKx7GSSPGdgpjki9TdJq9zZBWRghcrtFQqJHXqw=;
 b=xQaOOn0bah6DFWKtmTjf8NqlQhpnsOaxDhljVS7gD3hDOat284n70UeVbEI3ZyIDHeaRWPh3OWY2reuvVqx1ps3YZDZez/x821vqajj28sKwvWtZyrBhgPxLV4m4Q7ZL11o+yNCBxjberMuTf/AvcDRtZEk+EqteF1ZuY+LlMAgTHVPdBB9E0s/dGjZdB9JaesWZovcd2DN28DcY4BdJT5/FdG4/vfUc1gUfb8g9cSKArikNrujs8vNCYn8E3LcRza/6VNWBJk3Fure4UJmPTsEJWTupNAC2gtCfl5r1sx3QEquUq6Upx+9bRMNxITtgH8zok79RXsE7cYq/IA7Lpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3PQqKx7GSSPGdgpjki9TdJq9zZBWRghcrtFQqJHXqw=;
 b=KaLcar/cY+9fV5HDqS4wZpFMBRRtodQTQR4ToNEqr+N/HBVb5drcXUwj94u50VK6S8nxPbxwfvj4Ur3LETY4Gv/DsufyNAxuP//1Vfkms9RXJxaSaJXfrYNnPsBTxbNJ94XE20HiTYegmbs/JsAopUwFY0M1oNnvsmWZO5o6NmE=
Received: from CH2PR12CA0002.namprd12.prod.outlook.com (2603:10b6:610:57::12)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:05:50 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::62) by CH2PR12CA0002.outlook.office365.com
 (2603:10b6:610:57::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 09:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 09:05:50 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 01:05:47 -0800
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH] Delta patch of CXL address translation support
Date: Fri, 14 Nov 2025 10:05:27 +0100
Message-ID: <20251114090532.1323361-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1c186d-808b-483f-c703-08de235d01e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU12U1FhYVJXV2wzaS9TU3h0bmh1YWFSV0d6cVZqZXJjMk92a0RFSDExWTFk?=
 =?utf-8?B?WEExZklBMXo2NDZmaUZTVzAwZTVqR2Z5VUZTclloTGhZQXBGR3g4VCtyUHh1?=
 =?utf-8?B?MEFxYlBQRVJoZUs4b1krK20wb0lQWHFhMzFxS3M5VFlqckpPQTVsUTBQRU9y?=
 =?utf-8?B?VzRrUHpmVDl0ME1iZVBrTmM2cDBWNDRiQTFCdkV3TVpZYUFuL2VhL3hGRk9I?=
 =?utf-8?B?RWJNOEVZQXB3ajZMbVpOMUdiMEZLenFXcWRFeVVEc1Yxb1JpWStYY1lLT0lm?=
 =?utf-8?B?Q0lEUUc2M0JOVm9SOG5KTHJzaWJtV2RhZXVMOVJpaVVVaFhBZG5mY3pjMTQ0?=
 =?utf-8?B?QWxoek1lUEF2S1FvQnVDOUVVWmExR05DT3RETVBZRndCMWZidklieWxqenRx?=
 =?utf-8?B?N0tpNVhxUEFya2o5Nm44WE9kVDV1MWNyQ0RSK3ZpVEdDbTkxTjZWanhzVFUw?=
 =?utf-8?B?dnZWMkJWdUxOak5PQUpNWVUranlxbHpQNzE0UXd4aWZuNCtlZTlkLzY3U29m?=
 =?utf-8?B?eHVlRTJaR3Z5aXVpdkc1QmQ5UEp4a2JJelMrSEJlT2pCOElTK1p4dGNGYjI2?=
 =?utf-8?B?enpTUTN1amN2TVZNZ3AwZVNyMDliSjVZZk1pYVozeW9XbmhRckgzOWJQSXVD?=
 =?utf-8?B?aTdPc0w5M3pBVlhyRzUzNnE1UW83V0EvZkJoOUNIY2p6YVV6NlYrYWhtcHcy?=
 =?utf-8?B?NVFaelc1UjR1TVR0U3l4M3dnSkYyRW9RVEFKU1BIdkw2R0sySzNaNG1GcUNH?=
 =?utf-8?B?cHVpZFExbTNjTU5lM3pZQUlBNVpBYndxYVRGM240K1V2OVdwaFpIVmxIbDN3?=
 =?utf-8?B?bnduWEtjSmQ5WE5yUVRHOXlod0RjNWhkTUVMajR0NG05NFVEMTJETkFjZGJh?=
 =?utf-8?B?cGJ1ODZnOXdBUCtmOWVIRnUxTVRTNGRVU2hwUXpYV2ZDV1ZIcWZkMzI3aWZQ?=
 =?utf-8?B?VGFRcHoxRXQ5QnBLVmlsdjBvdGNBWHBweEIyMzJRRzFMcVBaNWdyZ3A0WGlZ?=
 =?utf-8?B?M0FxWmR4bVFybjMvb2k2cjUvSGlueFowUFRiTHFCdFNVTkhiRzZJTFZ3aG8y?=
 =?utf-8?B?U2liMlh3VHkydTZ3UUhrSFA4QmJ2cGRISllSMFVNOFFienN6d2ZWVHBjOTJa?=
 =?utf-8?B?RWpiYTdJYXJKRVpwR2htc3VIdmtXbStPdDZVci9sbFJGbXBvbVJIY3lubkt1?=
 =?utf-8?B?OEE2bDg3aHFEYTZISWFEc2NveVJ0OVVLSmdmK1JtbHUvMWd0MFQxYWgwUmdn?=
 =?utf-8?B?QlZOTE1vU3ZNVnkva3k4WTBHNU9JS1hUSnZlcURKS21qVklIQnhXelZlSExv?=
 =?utf-8?B?L0pldk96K0lraHNhTVIwMktRNXRnYU9TSUI3VTJtb3dUSWlyL2RiYzY4LzFi?=
 =?utf-8?B?YnZjNUlBbkJJQllTWjRBVGRyaDViS0QyazhGbXFMNXk3WFlENTVOUCtSUGVU?=
 =?utf-8?B?Sm9VSmNBeXVRSk56K29abnpsVDBJQ05iNzF2MzdnSm15d2I4amozYi9OYkJF?=
 =?utf-8?B?WTJxUkVkRmY4VUJuZnFEYnZ1SDBmaUVuTDFGRW1mSDZhY1hpTWZjVzU4M3lm?=
 =?utf-8?B?YURhZWZLd1RsSXFKQ3hjNFZVWklRdDZYZkFUVEQ4VUg5YzlxZElGV2Yxb21y?=
 =?utf-8?B?SDR5ZG1ETEVYODZSc2xIbnNJQmZhaVQ2OUJtZkpLOFhjT05vME00MFAwQWZz?=
 =?utf-8?B?Sk00blBodDI2QXlvUldtVUhCVzVCTytWaC9zQkFwd1pxbWtOMFBZNXgyM0k5?=
 =?utf-8?B?TEhDdlNsNzhMWmMxWDRBTFVZVDJFSnVqdUg1VnpiekZDZFUrbzljYWVyenJy?=
 =?utf-8?B?OERJOFlmMzFTWVU1VGg3WWNBYTZCWjJockErenJtcTZ0VlJRMDNyNlkxRzdt?=
 =?utf-8?B?czN4OGhqMWpRU2ZQT0J0UVp1YjFpUDVjMTFvRHl6SE1yOHZYcGpsSFFWK21m?=
 =?utf-8?B?V3BQYXJBNDd1TlNDMXd1QnArS1ZqZlBQR2dOcnR2aVZFR0ZQNEFYTGVBQjVr?=
 =?utf-8?B?anJvcld1TlRRYXBBR25uTGcyc0oyYVlIQ0dQNysrUjNLWWFDMCs0d3o4UHNt?=
 =?utf-8?B?Zm5qYmV5Nzh0VzFlN1NSUWFpOWhLTFBrcmxueU9WMVNpakpvUFRhSkFwWlhD?=
 =?utf-8?Q?2IaE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:05:50.3107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1c186d-808b-483f-c703-08de235d01e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309

I don't like the approach of handling conflicts (see the effort), but
here the patch on top of cxl/next with conflicts resolved. Use the
code base of this patch when merging into cxl/next and solving
conflicts. I rather would prefer to rebase patches on top of cxl/next,
not -rc5.

Delta patch for conflict resolution when merging:

Base on cxl/next: 482dc84e91a597149949f18c8eefb49cb2dc1bee

    Merge branch 'for-6.19/cxl-zen5-prm' into cxl-for-next

    Add support for address translation using ACPI PRM and enable this for
    AMD Zen5 platforms.

    Signed-off-by: Robert Richter <rrichter@amd.com>

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/Kconfig       |   5 +
 drivers/cxl/acpi.c        |  32 ++--
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/atl.c    | 272 +++++++++++++++++++++++++++
 drivers/cxl/core/cdat.c   |   8 +-
 drivers/cxl/core/core.h   |  11 ++
 drivers/cxl/core/hdm.c    |  70 ++++++-
 drivers/cxl/core/port.c   |   9 +-
 drivers/cxl/core/region.c | 380 +++++++++++++++++++++-----------------
 drivers/cxl/cxl.h         |  33 +++-
 10 files changed, 611 insertions(+), 210 deletions(-)
 create mode 100644 drivers/cxl/core/atl.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..103950a9b73e 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,9 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_ATL
+	def_bool y
+	depends on CXL_REGION
+	depends on ACPI_PRMT && AMD_NB
+
 endif
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1a64e5c71fbd..50c2987e0459 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -318,10 +318,6 @@ static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
 	return cxl_acpi_evaluate_qtg_dsm(handle, coord, entries, qos_class);
 }
 
-static const struct cxl_root_ops acpi_root_ops = {
-	.qos_class = cxl_acpi_qos_class,
-};
-
 static void del_cxl_resource(struct resource *res)
 {
 	if (!res)
@@ -469,8 +465,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
-	cxl_setup_extended_linear_cache(cxlrd);
-
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		if (ways != 1 && ways != 3) {
 			cxims_ctx = (struct cxl_cxims_context) {
@@ -486,18 +480,13 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 				return -EINVAL;
 			}
 		}
+		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
+		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
 	}
 
-	cxlrd->qos_class = cfmws->qtg_id;
-
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
-		cxlrd->ops = kzalloc(sizeof(*cxlrd->ops), GFP_KERNEL);
-		if (!cxlrd->ops)
-			return -ENOMEM;
+	cxl_setup_extended_linear_cache(cxlrd);
 
-		cxlrd->ops->hpa_to_spa = cxl_apply_xor_maps;
-		cxlrd->ops->spa_to_hpa = cxl_apply_xor_maps;
-	}
+	cxlrd->qos_class = cfmws->qtg_id;
 
 	rc = cxl_decoder_add(cxld);
 	if (rc)
@@ -930,11 +919,14 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	cxl_res->end = -1;
 	cxl_res->flags = IORESOURCE_MEM;
 
-	cxl_root = devm_cxl_add_root(host, &acpi_root_ops);
+	cxl_root = devm_cxl_add_root(host);
 	if (IS_ERR(cxl_root))
 		return PTR_ERR(cxl_root);
+	cxl_root->ops.qos_class = cxl_acpi_qos_class;
 	root_port = &cxl_root->port;
 
+	cxl_setup_prm_address_translation(cxl_root);
+
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
@@ -1015,8 +1007,12 @@ static void __exit cxl_acpi_exit(void)
 	cxl_bus_drain();
 }
 
-/* load before dax_hmem sees 'Soft Reserved' CXL ranges */
-subsys_initcall(cxl_acpi_init);
+/*
+ * Load before dax_hmem sees 'Soft Reserved' CXL ranges. Use
+ * subsys_initcall_sync() since there is an order dependency with
+ * subsys_initcall(efisubsys_init), which must run first.
+ */
+subsys_initcall_sync(cxl_acpi_init);
 
 /*
  * Arrange for host-bridge ports to be active synchronous with
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 5ad8fef210b5..11fe272a6e29 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
+cxl_core-$(CONFIG_CXL_ATL) += atl.o
diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
new file mode 100644
index 000000000000..347552835c61
--- /dev/null
+++ b/drivers/cxl/core/atl.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/prmt.h>
+#include <linux/pci.h>
+#include <linux/acpi.h>
+
+#include <cxlmem.h>
+#include "core.h"
+
+/*
+ * PRM Address Translation - CXL DPA to System Physical Address
+ *
+ * Reference:
+ *
+ * AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
+ * ACPI v6.5 Porting Guide, Publication # 58088
+ */
+
+static const guid_t prm_cxl_dpa_spa_guid =
+	GUID_INIT(0xee41b397, 0x25d4, 0x452c, 0xad, 0x54, 0x48, 0xc6, 0xe3,
+		  0x48, 0x0b, 0x94);
+
+struct prm_cxl_dpa_spa_data {
+	u64 dpa;
+	u8 reserved;
+	u8 devfn;
+	u8 bus;
+	u8 segment;
+	u64 *spa;
+} __packed;
+
+static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
+{
+	struct prm_cxl_dpa_spa_data data;
+	u64 spa;
+	int rc;
+
+	data = (struct prm_cxl_dpa_spa_data) {
+		.dpa     = dpa,
+		.devfn   = pci_dev->devfn,
+		.bus     = pci_dev->bus->number,
+		.segment = pci_domain_nr(pci_dev->bus),
+		.spa     = &spa,
+	};
+
+	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
+	if (rc) {
+		pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa, rc);
+		return ULLONG_MAX;
+	}
+
+	pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %#llx\n", dpa, spa);
+
+	return spa;
+}
+
+static void setup_1tb_hole(struct cxl_endpoint_decoder *cxled,
+			   struct range *spa_range)
+{
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct range hpa_range = cxld->hpa_range;
+	u64 hpa_len = range_len(&cxld->hpa_range);
+	u64 spa_len = range_len(spa_range);
+	u64 dpa_base = cxled->dpa_res->start;
+	u64 dpa_len = resource_size(cxled->dpa_res);
+	u64 hole = spa_len - hpa_len;
+	int rc;
+
+	if (spa_range->start >= SZ_1T || spa_range->start + hpa_len <= SZ_1T ||
+	    hpa_len != dpa_len || hpa_len >= spa_len)
+		return;
+
+	/*
+	 * The address range is split at the 1 TB boundary, creating a
+	 * hole at that offset. As a result, the size of the first
+	 * segment is reduced by the size of this hole. Adjust the
+	 * decoder size.
+	 */
+
+	hpa_range.end -= hole;
+	hpa_len = range_len(&hpa_range);
+	if (hpa_range.start + hpa_len > SZ_1T)
+		return;
+
+	dev_dbg(&cxld->dev, "%s: 1TB range found %#llx-%#llx:%#llx-%#llx\n",
+		dev_name(cxld->dev.parent), hpa_range.start, hpa_range.end,
+		spa_range->start, spa_range->end);
+
+	rc = __cxl_dpa_resize(cxled, hpa_len);
+	if (rc) {
+		dev_dbg(&cxld->dev, "__cxl_dpa_resize() failed: %d\n", rc);
+		return;
+	}
+
+	cxld->hpa_range = hpa_range;
+	*spa_range = DEFINE_RANGE(spa_range->start, hpa_len);
+
+	dev_dbg(&cxld->dev, "%s: 1TB range adjusted: %#llx-%#llx:%#llx-%#llx\n",
+		dev_name(cxld->dev.parent), hpa_range.start, hpa_range.end,
+		spa_range->start, spa_range->end);
+
+	/* Create a decoder to cover the 2nd segment. */
+
+	dpa_base += hpa_len;
+	dpa_len -= hpa_len;
+
+	cxled = cxl_endpoint_decoder_create(cxled_to_port(cxled), dpa_base,
+					    dpa_len);
+	if (IS_ERR(cxled)) {
+		dev_dbg(&cxld->dev,
+			"%s: cxl_endpoint_decoder_create() failed: %d\n",
+			dev_name(cxld->dev.parent), (int)PTR_ERR(cxled));
+		return;
+	}
+
+	dev_dbg(&cxld->dev, "%s: %s created\n",
+		dev_name(cxld->dev.parent), dev_name(&cxled->cxld.dev));
+}
+
+static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
+{
+	struct cxl_region_context *ctx = data;
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range hpa_range = ctx->hpa_range;
+	struct pci_dev *pci_dev;
+	u64 spa_len, len = range_len(&hpa_range);
+	u64 addr, base_spa, base;
+	int ways, gran;
+
+	/*
+	 * When Normalized Addressing is enabled, the endpoint maintains a 1:1
+	 * mapping between HPA and DPA. If disabled, skip address translation
+	 * and perform only a range check.
+	 */
+	if (hpa_range.start != cxled->dpa_res->start)
+		return 0;
+
+	if (!IS_ALIGNED(hpa_range.start, SZ_256M) ||
+	    !IS_ALIGNED(hpa_range.end + 1, SZ_256M)) {
+		dev_dbg(cxld->dev.parent,
+			"CXL address translation: Unaligned decoder HPA range: %#llx-%#llx(%s)\n",
+			hpa_range.start, hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	/*
+	 * Endpoints are programmed passthrough in Normalized Addressing mode.
+	 */
+	if (ctx->interleave_ways != 1) {
+		dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
+			ctx->interleave_ways, ctx->interleave_granularity);
+		return -ENXIO;
+	}
+
+	if (!cxlmd || !dev_is_pci(cxlmd->dev.parent)) {
+		dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
+			dev_name(cxld->dev.parent), hpa_range.start,
+			hpa_range.end);
+		return -ENXIO;
+	}
+
+	pci_dev = to_pci_dev(cxlmd->dev.parent);
+
+	/* Translate HPA range to SPA. */
+	base = hpa_range.start;
+	hpa_range.start = prm_cxl_dpa_spa(pci_dev, hpa_range.start);
+	hpa_range.end = prm_cxl_dpa_spa(pci_dev, hpa_range.end);
+	base_spa = hpa_range.start;
+
+	if (hpa_range.start == ULLONG_MAX || hpa_range.end == ULLONG_MAX) {
+		dev_dbg(cxld->dev.parent,
+			"CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
+			ctx->hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	/*
+	 * Since translated addresses include the interleaving offsets, align
+	 * the range to 256 MB.
+	 */
+	hpa_range.start = ALIGN_DOWN(hpa_range.start, SZ_256M);
+	hpa_range.end = ALIGN(hpa_range.end, SZ_256M) - 1;
+
+	setup_1tb_hole(cxled, &hpa_range);
+
+	spa_len = range_len(&hpa_range);
+	if (!len || !spa_len || spa_len % len) {
+		dev_dbg(cxld->dev.parent,
+			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
+			ctx->hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	ways = spa_len / len;
+	gran = SZ_256;
+
+	/*
+	 * Determine interleave granularity
+	 *
+	 * Note: The position of the chunk from one interleaving block to the
+	 * next may vary and thus cannot be considered constant. Address offsets
+	 * larger than the interleaving block size cannot be used to calculate
+	 * the granularity.
+	 */
+	if (ways > 1) {
+		while (gran <= SZ_16M) {
+			addr = prm_cxl_dpa_spa(pci_dev, base + gran);
+			if (addr != base_spa + gran)
+				break;
+			gran <<= 1;
+		}
+	}
+
+	if (gran > SZ_16M) {
+		dev_dbg(cxld->dev.parent,
+			"CXL address translation: Cannot determine granularity: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
+			ctx->hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	/*
+	 * There is only support to translate from the endpoint to its
+	 * parent port, but not in the opposite direction from the
+	 * parent to the endpoint. Thus, the endpoint address range
+	 * cannot be determined and setup manually. If the address range
+	 * was translated and modified, forbid reprogramming of the
+	 * decoders and lock them.
+	 */
+	cxld->flags |= CXL_DECODER_F_LOCK;
+
+	ctx->hpa_range = hpa_range;
+	ctx->interleave_ways = ways;
+	ctx->interleave_granularity = gran;
+
+	dev_dbg(&cxld->dev,
+		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
+		dev_name(cxlmd->dev.parent), base, len, hpa_range.start,
+		spa_len, ways, gran);
+
+	return 0;
+}
+
+void cxl_setup_prm_address_translation(struct cxl_root *cxl_root)
+{
+	struct device *host = cxl_root->port.uport_dev;
+	u64 spa;
+	struct prm_cxl_dpa_spa_data data = { .spa = &spa };
+	int rc;
+
+	/*
+	 * Applies only to PCIe Host Bridges which are children of the CXL Root
+	 * Device (HID=“ACPI0017”). Check this and drop cxl_test instances.
+	 */
+	if (!acpi_match_device(host->driver->acpi_match_table, host))
+		return;
+
+	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
+	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
+	if (rc == -EOPNOTSUPP || rc == -ENODEV)
+		return;
+
+	cxl_root->ops.translate_hpa_range = cxl_prm_translate_hpa_range;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_setup_prm_address_translation, "CXL");
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 7120b5f2e31f..18f0f2a25113 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -213,7 +213,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	if (!cxl_root)
 		return -ENODEV;
 
-	if (!cxl_root->ops || !cxl_root->ops->qos_class)
+	if (!cxl_root->ops.qos_class)
 		return -EOPNOTSUPP;
 
 	xa_for_each(dsmas_xa, index, dent) {
@@ -221,9 +221,9 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 
 		cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
 		dent->entries = 1;
-		rc = cxl_root->ops->qos_class(cxl_root,
-					      &dent->coord[ACCESS_COORDINATE_CPU],
-					      1, &qos_class);
+		rc = cxl_root->ops.qos_class(cxl_root,
+					     &dent->coord[ACCESS_COORDINATE_CPU],
+					     1, &qos_class);
 		if (rc != 1)
 			continue;
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1fb66132b777..359ddec6d8ea 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -19,6 +19,14 @@ enum cxl_detach_mode {
 };
 
 #ifdef CONFIG_CXL_REGION
+
+struct cxl_region_context {
+	struct cxl_endpoint_decoder *cxled;
+	struct range hpa_range;
+	int interleave_ways;
+	int interleave_granularity;
+};
+
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
 extern struct device_attribute dev_attr_delete_region;
@@ -91,9 +99,12 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+int __cxl_dpa_resize(struct cxl_endpoint_decoder *cxled, u64 len);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
 bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr);
+struct cxl_endpoint_decoder *cxl_endpoint_decoder_create(struct cxl_port *port,
+							 u64 base, u64 size);
 
 enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1c5d2022c87a..8f6d693bc2c8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -367,7 +367,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			port->id, cxled->cxld.id, cxled->dpa_res);
 		return -EBUSY;
 	}
-
+#if 0
 	if (port->hdm_end + 1 != cxled->cxld.id) {
 		/*
 		 * Assumes alloc and commit order is always in hardware instance
@@ -379,7 +379,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			cxled->cxld.id, port->id, port->hdm_end + 1);
 		return -EBUSY;
 	}
-
+#endif
 	if (skipped) {
 		rc = request_skip(cxlds, cxled, base - skipped, skipped);
 		if (rc)
@@ -573,6 +573,25 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	return 0;
 }
 
+int __cxl_dpa_resize(struct cxl_endpoint_decoder *cxled, u64 len)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	resource_size_t base, skipped;
+	int rc;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+
+	base = cxled->dpa_res->start;
+	skipped = cxled->skip;
+
+	__cxl_dpa_release(cxled);
+	rc = __cxl_dpa_reserve(cxled, base, len, skipped);
+	if (rc)
+		dev_dbg(&port->dev, "devm_cxl_dpa_reserve() failed: %d\n", rc);
+
+	return rc;
+}
+
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
 {
@@ -1218,6 +1237,53 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	return 0;
 }
 
+struct cxl_endpoint_decoder *cxl_endpoint_decoder_create(struct cxl_port *port,
+							 u64 base, u64 size)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_decoder *cxld;
+	struct cxl_endpoint_dvsec_info info;
+	int rc;
+
+	cxled = cxl_endpoint_decoder_alloc(port);
+	if (IS_ERR(cxled)) {
+		dev_warn(&port->dev, "Failed to alloc decoder: %d\n",
+			(int)PTR_ERR(cxled));
+		return cxled;
+	}
+
+	cxld = &cxled->cxld;
+	info = (struct cxl_endpoint_dvsec_info){
+		.port		= port,
+		.mem_enabled	= true,
+		.ranges		= 1,
+		.dvsec_range	= {
+			(struct range) {
+				.start = base,
+				.end = base + size - 1,
+			},
+		},
+	};
+
+	rc = cxl_setup_hdm_decoder_from_dvsec(port, cxld, &base, 0, &info);
+	if (rc) {
+		dev_warn(&port->dev,
+			"Failed to initialize decoder%d.%d\n",
+			port->id, cxld->id);
+		put_device(&cxled->cxld.dev);
+		return ERR_PTR(rc);
+	}
+
+	rc = add_hdm_decoder(port, cxld);
+	if (rc) {
+		dev_warn(&port->dev,
+			"Failed to add decoder%d.%d\n", port->id, cxld->id);
+		return ERR_PTR(rc);
+	}
+
+	return cxled;
+}
+
 /**
  * __devm_cxl_switch_port_decoders_setup - allocate and setup switch decoders
  * @port: CXL port context
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8128fd2b5b31..2338d146577c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -459,7 +459,6 @@ static void cxl_root_decoder_release(struct device *dev)
 	if (atomic_read(&cxlrd->region_id) >= 0)
 		memregion_free(atomic_read(&cxlrd->region_id));
 	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
-	kfree(cxlrd->ops);
 	kfree(cxlrd);
 }
 
@@ -955,19 +954,15 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, "CXL");
 
-struct cxl_root *devm_cxl_add_root(struct device *host,
-				   const struct cxl_root_ops *ops)
+struct cxl_root *devm_cxl_add_root(struct device *host)
 {
-	struct cxl_root *cxl_root;
 	struct cxl_port *port;
 
 	port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(port))
 		return ERR_CAST(port);
 
-	cxl_root = to_cxl_root(port);
-	cxl_root->ops = ops;
-	return cxl_root;
+	return to_cxl_root(port);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_root, "CXL");
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d5840f7352cc..335e3bc5dbe2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -486,9 +486,9 @@ static ssize_t interleave_ways_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	unsigned int val, save;
 	int rc;
@@ -549,9 +549,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t len)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
-	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
 	int rc, val;
 	u16 ig;
@@ -625,7 +625,7 @@ static DEVICE_ATTR_RO(mode);
 
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
 	u64 remainder = 0;
@@ -661,6 +661,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 		return PTR_ERR(res);
 	}
 
+	cxlr->hpa_range = DEFINE_RANGE(res->start, res->end);
+
 	p->res = res;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
@@ -697,6 +699,8 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	p->state = CXL_CONFIG_IDLE;
 	return 0;
@@ -1366,57 +1370,119 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	return 0;
 }
 
+static inline u64 get_selector(u64 ways, u64 gran)
+{
+	if (!is_power_of_2(ways))
+		ways /= 3;
+
+	if (!is_power_of_2(ways) || !is_power_of_2(gran))
+		return 0;
+
+	return (ways - 1) * gran;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
-	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
-	struct cxl_switch_decoder *cxlsd;
+	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	struct cxl_port *iter = port;
-	u16 eig, peig;
-	u8 eiw, peiw;
+	int ig, iw = cxl_rr->nr_targets, rc, pos = cxled->pos;
+	int distance, parent_distance;
+	u64 selector, cxlr_sel;
+	u16 eig;
+	u8 eiw;
 
 	/*
 	 * While root level decoders support x3, x6, x12, switch level
 	 * decoders only support powers of 2 up to x16.
 	 */
-	if (!is_power_of_2(cxl_rr->nr_targets)) {
+	if (!is_power_of_2(iw)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			cxl_rr->nr_targets);
+			dev_name(port->uport_dev), dev_name(&port->dev), iw);
 		return -EINVAL;
 	}
 
-	cxlsd = to_cxl_switch_decoder(&cxld->dev);
-	if (cxl_rr->nr_targets_set) {
-		int i, distance = 1;
-		struct cxl_region_ref *cxl_rr_iter;
+	if (iw > 8 || iw > cxlsd->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s:%s: ways: %d overflows targets: %d\n",
+			dev_name(port->uport_dev), dev_name(&port->dev),
+			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+		return -ENXIO;
+	}
 
-		/*
-		 * The "distance" between peer downstream ports represents which
-		 * endpoint positions in the region interleave a given port can
-		 * host.
-		 *
-		 * For example, at the root of a hierarchy the distance is
-		 * always 1 as every index targets a different host-bridge. At
-		 * each subsequent switch level those ports map every Nth region
-		 * position where N is the width of the switch == distance.
-		 */
-		do {
-			cxl_rr_iter = cxl_rr_load(iter, cxlr);
-			distance *= cxl_rr_iter->nr_targets;
-			iter = to_cxl_port(iter->dev.parent);
-		} while (!is_cxl_root(iter));
-		distance *= cxlrd->cxlsd.cxld.interleave_ways;
+	/*
+	 * Calculate the effective granularity and ways to determine
+	 * HPA bits used as target selectors of the interleave set.
+	 * Use this to check if the root decoder and all subsequent
+	 * HDM decoders only use bits from that range as selectors.
+	 *
+	 * The "distance" between peer downstream ports represents which
+	 * endpoint positions in the region interleave a given port can
+	 * host.
+	 *
+	 * For example, at the root of a hierarchy the distance is
+	 * always 1 as every index targets a different host-bridge. At
+	 * each subsequent switch level those ports map every Nth region
+	 * position where N is the width of the switch == distance.
+	 */
+
+	/* Start with the root decoders selector and distance. */
+	selector = get_selector(cxlrd->cxlsd.cxld.interleave_ways,
+				cxlrd->cxlsd.cxld.interleave_granularity);
+	distance = cxlrd->cxlsd.cxld.interleave_ways;
+	if (!is_power_of_2(distance))
+		distance /= 3;
+
+	for (iter = parent_port; !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
+		struct cxl_decoder *cxld_iter = cxl_rr_iter->decoder;
+		u64 cxld_sel;
+
+		if (cxld_iter->interleave_ways == 1)
+			continue;
+
+		cxld_sel = get_selector(cxld_iter->interleave_ways,
+					cxld_iter->interleave_granularity);
+
+		if (cxld_sel & selector) {
+			dev_dbg(&cxlr->dev, "%s:%s: overlapping selectors: %#llx:%#llx\n",
+				dev_name(iter->uport_dev),
+				dev_name(&iter->dev), cxld_sel, selector);
+			return -ENXIO;
+		}
+
+		selector |= cxld_sel;
+		distance *= cxl_rr_iter->nr_targets;
+	}
+
+	parent_distance = distance;
+	distance *= iw;
 
-		for (i = 0; i < cxl_rr->nr_targets_set; i++)
+	/* The combined selector bits must fit the region selector. */
+	cxlr_sel = get_selector(p->interleave_ways,
+				p->interleave_granularity);
+
+	if ((cxlr_sel & selector) != selector) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid selectors: %#llx:%#llx\n",
+			dev_name(iter->uport_dev),
+			dev_name(&iter->dev), cxlr_sel, selector);
+		return -ENXIO;
+	}
+
+	/* Calculate remaining selector bits available for use. */
+	selector = cxlr_sel & ~selector;
+
+	if (cxl_rr->nr_targets_set) {
+		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
 				rc = check_last_peer(cxled, ep, cxl_rr,
 						     distance);
@@ -1427,87 +1493,40 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		goto add_target;
 	}
 
-	if (is_cxl_root(parent_port)) {
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+		ig = cxld->interleave_granularity;
+	else
 		/*
+		 * Set the interleave granularity with each interleave
+		 * level to a multiple of it's parent port interleave
+		 * ways. Beginning with the granularity of the root
+		 * decoder set to the region granularity (starting
+		 * with the inner selector bits of the HPA), the
+		 * granularity is increased with each level. Calculate
+		 * this using the parent distance and region
+		 * granularity.
+		 *
 		 * Root decoder IG is always set to value in CFMWS which
 		 * may be different than this region's IG.  We can use the
 		 * region's IG here since interleave_granularity_store()
 		 * does not allow interleaved host-bridges with
 		 * root IG != region IG.
 		 */
-		parent_ig = p->interleave_granularity;
-		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
-		/*
-		 * For purposes of address bit routing, use power-of-2 math for
-		 * switch ports.
-		 */
-		if (!is_power_of_2(parent_iw))
-			parent_iw /= 3;
-	} else {
-		struct cxl_region_ref *parent_rr;
-		struct cxl_decoder *parent_cxld;
+		ig = p->interleave_granularity * parent_distance;
 
-		parent_rr = cxl_rr_load(parent_port, cxlr);
-		parent_cxld = parent_rr->decoder;
-		parent_ig = parent_cxld->interleave_granularity;
-		parent_iw = parent_cxld->interleave_ways;
-	}
-
-	rc = granularity_to_eig(parent_ig, &peig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
-			dev_name(parent_port->uport_dev),
-			dev_name(&parent_port->dev), parent_ig);
-		return rc;
-	}
-
-	rc = ways_to_eiw(parent_iw, &peiw);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
-			dev_name(parent_port->uport_dev),
-			dev_name(&parent_port->dev), parent_iw);
-		return rc;
-	}
-
-	iw = cxl_rr->nr_targets;
 	rc = ways_to_eiw(iw, &eiw);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev), iw);
-		return rc;
-	}
-
-	/*
-	 * Interleave granularity is a multiple of @parent_port granularity.
-	 * Multiplier is the parent port interleave ways.
-	 */
-	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
-	if (rc) {
-		dev_dbg(&cxlr->dev,
-			"%s: invalid granularity calculation (%d * %d)\n",
-			dev_name(&parent_port->dev), parent_ig, parent_iw);
-		return rc;
-	}
+	if (!rc)
+		rc = granularity_to_eig(ig, &eig);
 
-	rc = eig_to_granularity(eig, &ig);
-	if (rc) {
-		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
+	if (rc || (iw > 1 && ~selector & get_selector(iw, ig))) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d:%d:%#llx\n",
 			dev_name(port->uport_dev), dev_name(&port->dev),
-			256 << eig);
-		return rc;
-	}
-
-	if (iw > 8 || iw > cxlsd->nr_targets) {
-		dev_dbg(&cxlr->dev,
-			"%s:%s:%s: ways: %d overflows targets: %d\n",
-			dev_name(port->uport_dev), dev_name(&port->dev),
-			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
+			iw, ig, selector);
 		return -ENXIO;
 	}
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
-		    (iw > 1 && cxld->interleave_granularity != ig) ||
 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
@@ -1563,9 +1582,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
 		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
 	}
-	inc = 1;
+	cxl_rr->nr_targets_set++;
 out_target_set:
-	cxl_rr->nr_targets_set += inc;
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
 		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
@@ -1729,10 +1747,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 }
 
 static int cxl_region_attach_position(struct cxl_region *cxlr,
-				      struct cxl_root_decoder *cxlrd,
 				      struct cxl_endpoint_decoder *cxled,
 				      const struct cxl_dport *dport, int pos)
 {
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
@@ -1872,6 +1890,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 /**
  * cxl_calc_interleave_pos() - calculate an endpoint position in a region
  * @cxled: endpoint decoder member of given region
+ * @hpa_range: translated HPA range of the endpoint
  *
  * The endpoint position is calculated by traversing the topology from
  * the endpoint to the root decoder and iteratively applying this
@@ -1884,11 +1903,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
  * Return: position >= 0 on success
  *	   -ENXIO on failure
  */
-static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
+static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
+				   struct range *hpa_range)
 {
 	struct cxl_port *iter, *port = cxled_to_port(cxled);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *range = &cxled->cxld.hpa_range;
 	int parent_ways = 0, parent_pos = 0, pos = 0;
 	int rc;
 
@@ -1926,7 +1945,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
+				       &parent_ways);
 		if (rc)
 			return rc;
 
@@ -1936,7 +1956,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	dev_dbg(&cxlmd->dev,
 		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
 		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
-		dev_name(&port->dev), range->start, range->end, pos);
+		dev_name(&port->dev), hpa_range->start, hpa_range->end, pos);
 
 	return pos;
 }
@@ -1949,7 +1969,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 
-		cxled->pos = cxl_calc_interleave_pos(cxled);
+		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
 		 * cxled->pos so that follow-on code paths can reliably
@@ -1969,7 +1989,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_region_params *p = &cxlr->params;
@@ -2074,8 +2094,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 			ep_port = cxled_to_port(cxled);
 			dport = cxl_find_dport_by_dev(root_port,
 						      ep_port->host_bridge);
-			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
-							dport, i);
+			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
 			if (rc)
 				return rc;
 		}
@@ -2098,7 +2117,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
 	if (rc)
 		return rc;
 
@@ -2134,7 +2153,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled);
+		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		dev_dbg(&cxled->cxld.dev,
 			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
 			(test_pos == cxled->pos) ? "success" : "fail",
@@ -2394,8 +2413,8 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
 	/*
@@ -2452,6 +2471,8 @@ static void unregister_region(void *_cxlr)
 	for (i = 0; i < p->interleave_ways; i++)
 		detach_target(cxlr, i);
 
+	cxlr->hpa_range = DEFINE_RANGE(0, -1);
+
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
 }
@@ -2478,10 +2499,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	 * region id allocations
 	 */
 	get_device(dev->parent);
+	cxlr->cxlrd = cxlrd;
+	cxlr->id = id;
+
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;
-	cxlr->id = id;
 	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
 
 	return cxlr;
@@ -2968,16 +2991,6 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 	return false;
 }
 
-static bool has_hpa_to_spa(struct cxl_root_decoder *cxlrd)
-{
-	return cxlrd->ops && cxlrd->ops->hpa_to_spa;
-}
-
-static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
-{
-	return cxlrd->ops && cxlrd->ops->spa_to_hpa;
-}
-
 #define CXL_POS_ZERO 0
 /**
  * cxl_validate_translation_params
@@ -3123,7 +3136,7 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_hpa_offset, "cxl_translate");
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 dpa_offset, hpa_offset, hpa;
@@ -3151,8 +3164,8 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa = hpa_offset + p->res->start + p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
-	if (has_hpa_to_spa(cxlrd))
-		hpa = cxlrd->ops->hpa_to_spa(cxlrd, hpa);
+	if (cxlrd->ops.hpa_to_spa)
+		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
 
 	if (!cxl_resource_contains_addr(p->res, hpa)) {
 		dev_dbg(&cxlr->dev,
@@ -3161,7 +3174,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	}
 
 	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
-	if (!has_hpa_to_spa(cxlrd) && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
+	if (!cxlrd->ops.hpa_to_spa && !cxl_is_hpa_in_chunk(hpa, cxlr, pos))
 		return ULLONG_MAX;
 
 	return hpa;
@@ -3176,7 +3189,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 				       struct dpa_result *result)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_endpoint_decoder *cxled;
 	u64 hpa, hpa_offset, dpa_offset;
 	u16 eig = 0;
@@ -3194,8 +3207,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
 	 * If the root decoder has SPA to CXL HPA callback, use it. Otherwise
 	 * CXL HPA is assumed to equal SPA.
 	 */
-	if (has_spa_to_hpa(cxlrd)) {
-		hpa = cxlrd->ops->spa_to_hpa(cxlrd, p->res->start + offset);
+	if (cxlrd->ops.spa_to_hpa) {
+		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
 		hpa_offset = hpa - p->res->start;
 	} else {
 		hpa_offset = offset;
@@ -3468,47 +3481,63 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int match_decoder_by_range(struct device *dev, const void *data)
+static int match_root_decoder(struct device *dev, const void *data)
 {
 	const struct range *r1, *r2 = data;
-	struct cxl_decoder *cxld;
+	struct cxl_root_decoder *cxlrd;
 
-	if (!is_switch_decoder(dev))
+	if (!is_root_decoder(dev))
 		return 0;
 
-	cxld = to_cxl_decoder(dev);
-	r1 = &cxld->hpa_range;
+	cxlrd = to_cxl_root_decoder(dev);
+	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+
 	return range_contains(r1, r2);
 }
 
-static struct cxl_decoder *
-cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
+static int translate_hpa_range(struct cxl_root *cxl_root,
+			       struct cxl_region_context *ctx)
 {
-	struct device *cxld_dev = device_find_child(&port->dev, hpa,
-						    match_decoder_by_range);
+	if (!cxl_root->ops.translate_hpa_range)
+		return 0;
 
-	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
+	return cxl_root->ops.translate_hpa_range(cxl_root, ctx);
 }
 
+/*
+ * Note, when finished with the device, drop the reference with
+ * put_device() or use the put_cxl_root_decoder helper.
+ */
 static struct cxl_root_decoder *
-cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
+		     struct cxl_region_context *ctx)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-	struct cxl_decoder *root, *cxld = &cxled->cxld;
-	struct range *hpa = &cxld->hpa_range;
+	struct device *cxlrd_dev;
+	int rc;
+
+	rc = translate_hpa_range(cxl_root, ctx);
+	if (rc) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s Failed to translate address range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(rc);
+	}
 
-	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
-	if (!root) {
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
+				      match_root_decoder);
+	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
 			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
-		return NULL;
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(-ENXIO);
 	}
 
-	return to_cxl_root_decoder(&root->dev);
+	return to_cxl_root_decoder(cxlrd_dev);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
@@ -3530,7 +3559,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 					    struct resource *res)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_region_params *p = &cxlr->params;
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
@@ -3566,11 +3595,12 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 }
 
 static int __construct_region(struct cxl_region *cxlr,
-			      struct cxl_root_decoder *cxlrd,
-			      struct cxl_endpoint_decoder *cxled)
+			      struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct range *hpa_range = &ctx->hpa_range;
 	struct cxl_region_params *p;
 	struct resource *res;
 	int rc;
@@ -3586,12 +3616,13 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
+	cxlr->hpa_range = *hpa_range;
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return -ENOMEM;
 
-	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
+	*res = DEFINE_RES_MEM_NAMED(hpa_range->start, range_len(hpa_range),
 				    dev_name(&cxlr->dev));
 
 	rc = cxl_extended_linear_cache_resize(cxlr, res);
@@ -3622,8 +3653,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	}
 
 	p->res = res;
-	p->interleave_ways = cxled->cxld.interleave_ways;
-	p->interleave_granularity = cxled->cxld.interleave_granularity;
+	p->interleave_ways = ctx->interleave_ways;
+	p->interleave_granularity = ctx->interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
@@ -3643,8 +3674,9 @@ static int __construct_region(struct cxl_region *cxlr,
 
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+					   struct cxl_region_context *ctx)
 {
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -3664,7 +3696,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		return cxlr;
 	}
 
-	rc = __construct_region(cxlr, cxlrd, cxled);
+	rc = __construct_region(cxlr, ctx);
 	if (rc) {
 		devm_release_action(port->uport_dev, unregister_region, cxlr);
 		return ERR_PTR(rc);
@@ -3674,11 +3706,12 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 }
 
 static struct cxl_region *
-cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
+cxl_find_region_by_range(struct cxl_root_decoder *cxlrd,
+			 struct range *hpa_range)
 {
 	struct device *region_dev;
 
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa_range,
 				       match_region_by_range);
 	if (!region_dev)
 		return NULL;
@@ -3688,25 +3721,34 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_region_context ctx;
 	struct cxl_region_params *p;
 	bool attach = false;
 	int rc;
 
+	ctx = (struct cxl_region_context) {
+		.cxled = cxled,
+		.hpa_range = cxled->cxld.hpa_range,
+		.interleave_ways = cxled->cxld.interleave_ways,
+		.interleave_granularity = cxled->cxld.interleave_granularity,
+	};
+
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
-		cxl_find_root_decoder(cxled);
-	if (!cxlrd)
-		return -ENXIO;
+		get_cxl_root_decoder(cxled, &ctx);
+
+	if (IS_ERR(cxlrd))
+		return PTR_ERR(cxlrd);
 
 	/*
-	 * Ensure that if multiple threads race to construct_region() for @hpa
-	 * one does the construction and the others add to that.
+	 * Ensure that, if multiple threads race to construct_region()
+	 * for the HPA range, one does the construction and the others
+	 * add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
-		cxl_find_region_by_range(cxlrd, hpa);
+		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
 	if (!cxlr)
-		cxlr = construct_region(cxlrd, cxled);
+		cxlr = construct_region(cxlrd, &ctx);
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6cfe65a35c95..3ae22a642679 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -451,7 +451,7 @@ struct cxl_root_decoder {
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
-	struct cxl_rd_ops *ops;
+	struct cxl_rd_ops ops;
 	struct cxl_switch_decoder cxlsd;
 };
 
@@ -529,6 +529,8 @@ enum cxl_partition_mode {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
+ * @cxlrd: Region's root decoder
+ * @hpa_range: Address range occupied by the region
  * @mode: Operational mode of the mapped capacity
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -542,6 +544,8 @@ enum cxl_partition_mode {
 struct cxl_region {
 	struct device dev;
 	int id;
+	struct cxl_root_decoder *cxlrd;
+	struct range hpa_range;
 	enum cxl_partition_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
@@ -642,6 +646,15 @@ struct cxl_port {
 	resource_size_t component_reg_phys;
 };
 
+struct cxl_root;
+
+struct cxl_root_ops {
+	int (*qos_class)(struct cxl_root *cxl_root,
+			 struct access_coordinate *coord, int entries,
+			 int *qos_class);
+	int (*translate_hpa_range)(struct cxl_root *cxl_root, void *data);
+};
+
 /**
  * struct cxl_root - logical collection of root cxl_port items
  *
@@ -650,7 +663,7 @@ struct cxl_port {
  */
 struct cxl_root {
 	struct cxl_port port;
-	const struct cxl_root_ops *ops;
+	struct cxl_root_ops ops;
 };
 
 static inline struct cxl_root *
@@ -659,12 +672,6 @@ to_cxl_root(const struct cxl_port *port)
 	return container_of(port, struct cxl_root, port);
 }
 
-struct cxl_root_ops {
-	int (*qos_class)(struct cxl_root *cxl_root,
-			 struct access_coordinate *coord, int entries,
-			 int *qos_class);
-};
-
 static inline struct cxl_dport *
 cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 {
@@ -778,8 +785,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct device *uport_dev,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
-struct cxl_root *devm_cxl_add_root(struct device *host,
-				   const struct cxl_root_ops *ops);
+struct cxl_root *devm_cxl_add_root(struct device *host);
 struct cxl_root *find_cxl_root(struct cxl_port *port);
 
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
@@ -811,6 +817,13 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
 #endif
 
+#ifdef CONFIG_CXL_ATL
+void cxl_setup_prm_address_translation(struct cxl_root *cxl_root);
+#else
+static inline
+void cxl_setup_prm_address_translation(struct cxl_root *cxl_root) {}
+#endif
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);

base-commit: 482dc84e91a597149949f18c8eefb49cb2dc1bee
-- 
2.47.3

